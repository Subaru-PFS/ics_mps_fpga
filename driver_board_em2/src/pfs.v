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

module pfs (
    input  logic   sin_clock_16mhz,  ///< 16MHz input clock with sin
    input  logic   tlmin_clock_16mhz,  ///< 16Mhz input clock with tlmin data
    input  logic   clock_1mhz,  ///< 1MHz input clock
    input  logic   reset,       ///< Active-high reset
    input  logic   sin,         ///< Serial in
    output logic   sout,        ///< Serial out
    output logic   [MOTOR_ROWS-1:0] ph_a_h,
    output logic   [MOTOR_ROWS-1:0] ph_b_h,
    output logic   [MOTOR_ROWS-1:0] ph_a_l,
    output logic   [MOTOR_ROWS-1:0] ph_b_l,
    output logic   [MOTOR_COLS-1:0] col_en,

    output logic   current_sense,
    
    // Liveness checks
    output logic    cmd_received,
    output logic    tlm_ready,
    
    //ADC 0
    input  logic   adc0_douta,
    input  logic   adc0_doutb,
    output logic   adc0_sclk,
    output logic   [2:0] adc0_addr,
    output logic   adc0_ncs,
    output logic   adc0_rng,
    
    //ADC 1
    input  logic   adc1_douta,
    input  logic   adc1_doutb,
    output logic   adc1_sclk,
    output logic   [2:0] adc1_addr,
    output logic   adc1_ncs,
    output logic   adc1_rng,

    input  logic   tlm_in,
    output logic   tlm_out
);

localparam  CMD_TO_BUS_ADDR = 0,
            MOTOR_MUX_BUS_ADDR = 1,
            CALIBRATOR_BUS_ADDR = 2,
            ADC0_IF_BUS_ADDR = 3,
            ADC1_IF_BUS_ADDR = 4,
            NUM_SLAVES = 5;

// use the clock sync'd to cmdin as primary            
logic clock_16mhz = sin_clock_16mhz;

// Flag for when a new command was received
logic new_cmd_in;
// Same value, delayed by one cycle
logic z1_new_cmd_in;
// Received command
rem_cmd_t cmd_in;

// local response
cmd_t response;

// Flag for when a command needs to be routed
logic new_cmd_route;
// Command to route
rem_cmd_t cmd_route;

// Flag for when a local command needs to be handled
logic new_cmd_local;
// Command to handle
cmd_t cmd_local;

logic [$bits(cmd_route)-1:0] rr_mux_din [0:1];
logic rr_mux_nd [0:1];


logic soft_reset;

// Flag for when local telemetry needs to be handled
logic new_local_tlm;
// Local telemetry to handle
rem_cmd_t tlm_local;

// Flag for when non local telemetry needs to be handled
logic new_nonlocal_tlm;
// Same value, delayed by one cycle
logic z1_new_nonlocal_tlm;
// Non-local telemetry to handle
rem_cmd_t tlm_nonlocal;

//Flag for when there is telemetry to send
logic new_tlm_out;
// Telemetry to send but needs increment first
rem_cmd_t tlm_needs_incr;
// Telemetry to send
rem_cmd_t tlm_outgoing;

logic mux_ready;
logic col_finished;

// flags for whether each motor driver is ready
logic [MOTOR_ROWS-1:0] row_rdy;

// the row being used in calibration
logic [ROW_AWIDTH-1:0] cal_row;

// motor current passed from adc_current_if to the calibrator
logic [15:0] motor_current;


always_comb begin
	//local telemetry target is initially -1, will be incremented to 0
    tlm_local = '{target: -1, payload: response};
    rr_mux_din = {tlm_nonlocal, tlm_local};
    rr_mux_nd = {z1_new_nonlocal_tlm, new_local_tlm};
end

// Incrementing the telemetry before sending
always_comb begin
    tlm_outgoing = '{
        target: tlm_needs_incr.target + 1, payload: tlm_needs_incr.payload
    };
end

// Delay this by one clock so the router gets it at the same time as the data
always_ff @(posedge clock_16mhz) begin
    z1_new_cmd_in <= new_cmd_in;
	z1_new_nonlocal_tlm <= new_nonlocal_tlm;
end

// simple liveness checks of COMM link
always_ff @ (posedge clock_16mhz or posedge reset) begin
    if (reset) begin
        cmd_received <= 0;
        tlm_ready <= 0;
    end else begin
        if (new_cmd_in)
            cmd_received <= 1;
            
        if (new_local_tlm)
            tlm_ready <= 1;
    
    end
end

// The interconnection bus
pfs_bus #(
    .NSLV(NUM_SLAVES)
) bus (
    .clock(clock_16mhz),
    .reset(reset)
);

// Remote command router
router router (
    .clock(clock_16mhz),
    .reset(reset),
    .cmd_in(cmd_in),
    .new_cmd_in(z1_new_cmd_in),
    .cmd_route(cmd_route),
    .new_cmd_route(new_cmd_route),
    .cmd_local(cmd_local),
    .new_cmd_local(new_cmd_local)
);

// CMD Communication interface (SERDES + FIFO)
comm #(
    .WIDTH($bits(rem_cmd_t)),
    .DEPTH(256)
) comm_cmd (
    .clock(clock_16mhz),
    .reset(reset),
    
    .sin_clock(sin_clock_16mhz),
    .sin(sin),
    .rx_rd(new_cmd_in),
    .rx_val(new_cmd_in),
    .rx_full( /* NC */ ),
    .rx_data(cmd_in),
    
    .tx_data(cmd_route),
    .tx_wr(new_cmd_route),
    .tx_rdy( /* NC */ ),
    .sout_clock(sin_clock_16mhz),
    .sout(sout)
);
// TLM communication interface (SERDES + FIFO)
comm #(
    .WIDTH($bits(rem_cmd_t)),
    .DEPTH(256)
) comm_tlm (
    .clock(clock_16mhz),
    .reset(reset),
    
    .sin_clock(tlmin_clock_16mhz),
    .sin(tlm_in),
    .rx_rd(new_nonlocal_tlm),
    .rx_val(new_nonlocal_tlm),
    .rx_full( /* NC */ ),
    .rx_data(tlm_nonlocal),
    
    .tx_data(tlm_outgoing),
    .tx_wr(new_tlm_out),
    .tx_rdy( /* NC */ ),
    .sout_clock(sin_clock_16mhz),
    .sout(tlm_out)
);

// Register read/write controller
pfs_bus_master #(
    .NSLV(NUM_SLAVES)
) pfs_bus_master (
    .bus(bus),
    .soft_reset(soft_reset)
);

cmd_to_bus #(
    .BUS_ADDR(CMD_TO_BUS_ADDR),
    .DEPTH(256)
) cmd_to_bus (
    .bus(bus),
    .cmd_in(cmd_local),
    .new_cmd_in(new_cmd_local),
    .response(response),
    .new_response(new_local_tlm)
);

// Mux for local & nonlocal telemetry
roundrobin_mux #(
    .WIDTH($bits(rem_cmd_t)),
    .DEPTH(64),
    .MUXIN(2)
) roundrobin_mux (
    .clock(clock_16mhz),
    .reset(reset),
    .din(rr_mux_din),
    .nd(rr_mux_nd),
    .dout(tlm_needs_incr),
    .dval(new_tlm_out)
);

// Motor drivers
motor_mux #(
    .BUS_ADDR(MOTOR_MUX_BUS_ADDR)
) motor_mux (
    .bus(bus),
    .clock_1mhz(clock_1mhz),
    .soft_reset(soft_reset),
    .ready(mux_ready),
    .col_finished(col_finished),
    
    .row_ready(row_rdy),
    
    .ph_a_h(ph_a_h),
    .ph_b_h(ph_b_h),
    .ph_a_l(ph_a_l),
    .ph_b_l(ph_b_l),
    .col_en(col_en)
);

calibrator #(
    .BUS_ADDR(CALIBRATOR_BUS_ADDR)
) calibrator (
    .bus(bus),
    .soft_reset(soft_reset),
    .adc_val(motor_current),
    .mux_ready(mux_ready),
    .col_finished(col_finished),
    .current_sense(current_sense),
    
    .cal_row(cal_row)
);

adc_current_if #(
    .BUS_ADDR(ADC0_IF_BUS_ADDR)
) adc_current (
    .bus(bus),
    .soft_reset(soft_reset),
    .adc_sum(motor_current),
    
    .cal_row(cal_row),
    .row_rdy(row_rdy),
    
    .douta(adc0_douta),
    .doutb(adc0_doutb),
    .adc_sclk(adc0_sclk),
    .adc_addr(adc0_addr),
    .ncs(adc0_ncs),
    .rng(adc0_rng)
);

adc_temps_if #(
    .BUS_ADDR(ADC1_IF_BUS_ADDR)
) adc_temps (
    .bus(bus),
    .clock_1mhz(clock_1mhz),
    .soft_reset(soft_reset),
    
    .douta(adc1_douta),
    .doutb(adc1_doutb),
    .adc_sclk(adc1_sclk),
    .adc_addr(adc1_addr),
    .ncs(adc1_ncs),
    .rng(adc1_rng)
);


endmodule


/* vim: set syntax=systemverilog: */
