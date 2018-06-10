/*********************************************************************
 * \file
 * \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
 * \brief
 *
 * \copyright
 * Copyright 2009-2014, by the California Institute of Technology.
 * ALL RIGHTS RESERVED.  United States Government Sponsorship
 * acknowledged. Any commercial use must be negotiated with the Office
 * of Technology Transfer at the California Institute of Technology.
 * \copyright
 * This software may be subject to U.S. export control laws and
 * regulations.  By accepting this document, the user agrees to comply
 * with all U.S. export laws and regulations.  User has the
 * responsibility to obtain export licenses, or other export authority
 * as may be required before exporting such information to foreign
 * countries or providing access to foreign persons.
 ********************************************************************/

`timescale 1ns/100ps

import PFS::*;

module adc_current_if #(
    parameter BUS_ADDR = 0
) (
    pfs_bus.slave bus,
    input  logic soft_reset,
    output logic [15:0] adc_sum,
    
    // need these guys to know whether the adc current value is valid
    input [ROW_AWIDTH-1:0] cal_row,
    input [MOTOR_ROWS-1:0] row_rdy,

    // ADC signals
    input logic douta,
    input logic doutb,
    output logic adc_sclk,
    output logic [2:0] adc_addr,
    output logic ncs,
    output logic rng
);

/*******************************************************************************
 * Parameters
 ******************************************************************************/

localparam LAST_READ_COUNT = 15;

/*******************************************************************************
 * Bus alias signals
 ******************************************************************************/

logic wr_req;
logic rd_req;

rd_addr_t rd_addr;
rd_data_t rd_data;
wr_addr_t wr_addr;
wr_data_t wr_data;

wire clock = bus.clock;
wire reset = bus.reset | soft_reset;

wire wr_gnt = bus.wr_gnt[BUS_ADDR];
wire rd_gnt = bus.rd_gnt[BUS_ADDR];

assign bus.wr_req[BUS_ADDR] = wr_req;
assign bus.rd_req[BUS_ADDR] = rd_req;

assign bus.rd_addr[BUS_ADDR] = rd_addr;
assign bus.wr_addr[BUS_ADDR] = wr_addr;

assign rd_data = bus.rd_data;
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
} state, next_state;

// Accumulator (for filtering)
logic [15:0] accum;

// Local copy of the address
pfs_reg_t addr;

// Which sample is this?
logic [3:0] state_count;

// Output ADC values
wire [11:0] data_a;
wire [11:0] data_b;

// the proper adc data to accumulate
logic [11:0] adc_data;

// signal when a state transition is about to occur
wire state_transition = (state != next_state);

// ADC7265 flow control
logic req;
logic rdy;

// flag for whether the motor to calibrate is running
wire motor_going = ~row_rdy[cal_row];

/******************************************************************************/
// adc data must be muxed based on address,
always_comb begin
    adc_data = (addr[3]) ? data_b:data_a;
end

/******************************************************************************/

// Next state transition
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= RESET;
    end else begin
        state <= next_state;
    end
end

/******************************************************************************/

// Next state decoder
always_comb begin
    next_state = state;

    case (state)
      RESET: next_state =                         IDLE;
      IDLE:  next_state = (rd_gnt)              ? SETUP : state;
      SETUP: next_state = (motor_going)         ? READING : state;
      READING: begin
        if (motor_going & (state_count == LAST_READ_COUNT) & rdy)
             next_state =                         LOGGING;
        else
             next_state = (~motor_going)         ? IDLE : state;
      end
      LOGGING: next_state = wr_gnt ? IDLE : state;
    endcase
end

/******************************************************************************/

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        state_count <= 0;
        accum <= 0;
        addr <= 0;
        adc_sum <= 0;
        
    end else begin
        if (state == SETUP) begin
            state_count <= 0;
            accum <= 0;
            addr <= rd_data[ADC_ROW];
        end
        if (rdy & (state == READING) & motor_going) begin
            state_count <= state_count + 1;
            accum <= accum + adc_data;
            
            if (state_transition) begin
                adc_sum <= accum + adc_data;
                
            end
        end
    end
end

/******************************************************************************/

always_comb begin
    if (reset) begin
        req = 0;
        wr_req = 0;
        rd_req = 0;
        rd_addr = 0;
        wr_addr = 0;
        wr_data = 0;
    end else begin
        req = 0;
        wr_req = 0;
        rd_req = 0;
        rd_addr = 0;
        wr_addr = 0;
        wr_data = 0;

        if (state == IDLE) begin
            // don't bother with a read request until the motor is going
            rd_req = motor_going;
            rd_addr = make_rd_addr_t(ADC_COL, ADC0_CTRL_REG);           
        end

        if ((state == READING) && (state_count != LAST_READ_COUNT)) begin
            req = rdy;
        end

        if (state == LOGGING) begin
            wr_req = 1;
            wr_addr = make_wr_addr_t(ADC_ROW, ADC_COL, ADC0_VAL_REG);
            wr_data = adc_sum;
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
