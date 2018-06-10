`timescale 1ns/100ps

import PFS::*;

module adc_temps_if #(
    parameter BUS_ADDR = 0
) (
    pfs_bus.slave bus,
    input logic clock_1mhz,
    input logic soft_reset,
    
    // ADC signals
    input logic douta,
    input logic doutb,
    output logic adc_sclk,
    output logic [2:0] adc_addr,
    output logic ncs,
    output logic rng
);


localparam LAST_READ_COUNT = 15;

/*******************************************************************************
 * Bus alias signals
 ******************************************************************************/

logic wr_req;

wr_addr_t wr_addr;
wr_data_t wr_data;

wire clock = bus.clock;
wire reset = bus.reset | soft_reset;

wire wr_gnt = bus.wr_gnt[BUS_ADDR];

assign bus.wr_req[BUS_ADDR] = wr_req;

assign bus.wr_addr[BUS_ADDR] = wr_addr;

assign bus.wr_data[BUS_ADDR] = wr_data;

/*******************************************************************************
 * Local signals
 ******************************************************************************/

// FSM states
enum {
    RESET,
    IDLE,
    SETUP,
    READING,
    LOGGING
} state, next_state, z1_state;

// Accumulator (for filtering)
logic [15:0] accum;

// Local copy of the address
logic [3:0] addr;

// Which sample is this?
logic [3:0] state_count;

// Output ADC values
logic [11:0] data_a;
logic [11:0] data_b;

// the proper adc data to accumulate
logic [11:0] adc_data;

// result of adc accum
logic [15:0] adc_sum;

// signal when a state transition is about to occur
wire state_transition = (state != next_state);

// ADC7265 flow control
logic req;
logic rdy;

// ADC Results to be written
localparam NUM_RESULT_REGS = 3;
localparam reg_addr_t RESULT_REG_ADDR [NUM_RESULT_REGS] = {
    TEMP0_REG,
    TEMP1_REG,
    VOLTAGE_REG
};

// ADC address values to sample
localparam [3:0] ADDR_VALS [NUM_RESULT_REGS] = {
    4'h1, // ADC input A1
    4'h2, // ADC input A2
    4'h3 // ADC input A3
};

// Index of the adc value being sampled
logic [$clog2(NUM_RESULT_REGS)-1:0] sel_idx;

// local copy of where to store result
reg_addr_t result_reg_addr;

// time to wait in uSec between capturing adc results
localparam ADC_WAIT_TIME_US = 262_143; // ~ 262ms
logic [$clog2(ADC_WAIT_TIME_US)-1:0] wait_counter;
logic new_capture;

/******************************************************************************/
// adc data must be muxed based on address,
always_comb begin
    adc_data = (addr[3]) ? data_b:data_a;
end


/******************************************************************************/

/******************************************************************************/

// Next state transition
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= RESET;
        z1_state <= RESET;
    end else begin
        state <= next_state;
        z1_state <= state;
    end
end

/******************************************************************************/

// Next state decoder
always_comb begin
    next_state = state;

    case (state)
      RESET: next_state = IDLE;
      IDLE:  next_state = new_capture ? SETUP : state;
      SETUP: next_state = READING;
      READING: next_state = ((state_count == LAST_READ_COUNT) && (rdy)) ? LOGGING : state;
      LOGGING: next_state = wr_gnt ? IDLE : state;
    endcase
end

/******************************************************************************/

// Wait time counter every 1uS
always_ff @(posedge clock_1mhz or posedge reset) begin
    if (reset) begin
        wait_counter <= ADC_WAIT_TIME_US;
        new_capture <= 0;
        
    end else begin
        wait_counter <= (wait_counter == 0) ? ADC_WAIT_TIME_US:wait_counter-1;
        new_capture <= (wait_counter == 0);
        
    end
end
    

/******************************************************************************/

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        state_count <= 0;
        accum <= 0;
        addr <= 0;
        adc_sum <= 0;
        sel_idx <= 0;
        result_reg_addr <= 0;
        
        
    end else begin

        if (state == SETUP) begin
            state_count <= 0;
            accum <= 0;
            addr <= ADDR_VALS[sel_idx];
            result_reg_addr <= RESULT_REG_ADDR[sel_idx];
        end
        
        if (rdy && (state == READING)) begin
            if (z1_state == READING) begin
                state_count <= state_count + 1;
                accum <= accum + adc_data;
                
                if (state_transition) begin
                    adc_sum <= accum + adc_data;

                end
            end
        end
        if ((state == LOGGING) && state_transition) begin
            sel_idx <= (sel_idx==NUM_RESULT_REGS-1) ? 0:sel_idx+1;
        end
    end
end

/******************************************************************************/

always_comb begin
    if (reset) begin
        req = 0;
        wr_req = 0;
        wr_addr = 0;
        wr_data = 0;
    end else begin
        req = 0;
        wr_req = 0;
        wr_addr = 0;
        wr_data = 0;

        if ((state == READING) && (state_count != LAST_READ_COUNT)) begin
            req = rdy;
        end

        if (state == LOGGING) begin
            wr_req = 1;
            wr_data = adc_sum;
            wr_addr = make_wr_addr_t(ADC_ROW, ADC_COL, result_reg_addr);
            
        end

    end
end

/******************************************************************************/
// Note: ADC only goes if addr is not 0 or 7, otherwise it just stays rdy

ad7265 ad7265 (
    .clk(clock),
    .rst(reset),
    
    .req(req),
    .addr(addr[2:0]),
    .rdy(rdy),
    .data_a(data_a),
    .data_b(data_b),
    
    .adc_sclk(adc_sclk),
    .adc_addr(adc_addr),
    .adc_ncs(ncs),
    .adc_rng(rng),
    .adc_a(douta),
    .adc_b(doutb) 
);


endmodule

/* vim: set syntax=systemverilog: */
