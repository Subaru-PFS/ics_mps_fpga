///////////////////////////////////////////////////////////////////////////////
//% \file
//% \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
//% \brief Motor driver
//%
//% \copyright
//% Copyright 2009-2014, by the California Institute of Technology.
//% ALL RIGHTS RESERVED.  United States Government Sponsorship
//% acknowledged. Any commercial use must be negotiated with the Office
//% of Technology Transfer at the California Institute of Technology.
//% \copyright
//% This software may be subject to U.S. export control laws and
//% regulations.  By accepting this document, the user agrees to comply
//% with all U.S. export laws and regulations.  User has the
//% responsibility to obtain export licenses, or other export authority
//% as may be required before exporting such information to foreign
//% countries or providing access to foreign persons.
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

import PFS::*;

///////////////////////////////////////////////////////////////////////////////
//% This is the main motor driver module for the Prime Focus Spectrograph.
//% It provides control signals to drive a TI DRV8839 1/2 H-bridge driver with
//% the two output phases in quadrature.
//%
//% \note It is the parent module's responsibility to ensure that input
//%       registers don't change while ready is low.
///////////////////////////////////////////////////////////////////////////////

module motor_driver (
    input clock_16mhz,       //% 16MHz Master clock
    input clock_1mhz,        //% 1-cycle (16MHz) strobe of 1MHz
    input reset,             //% Active-high reset
    pfs_reg_t pulse_period,  //% Pulse period [clock cycles], t<SUB>p</SUB>
    pfs_reg_t pulse_len,     //% Amount of time to drive pulses [us], N<SUB>p</SUB>
    input start,             //% Posedge-triggered start
    input dir,               //% Drive direction

    output logic ready,         //% High when module is ready for a new command
    output logic ph_a_h,        //% High side, phase A
    output logic ph_a_l,        //% Low  side, phase A
    output logic ph_b_h,        //% High side, phase B
    output logic ph_b_l         //% Low  side, phase B
);

enum {
    RESET,      //% State after reset
    IDLE,       //% Idle, ready to start
    LATCH,      //% Just started, latch input data
    SYNC_1US,   //% Wait until receiving the rising edge of the 1MHz clock
    MTR_DRV     //% Driving the motor
} state, next_state;

// Internal copies of the input parameters
pfs_reg_t pulse_period_init;

// Counters
pfs_reg_t div_count;
pfs_reg_t us_left;

// Delayed copies of signals
logic z1_start;
logic z1_clock_1mhz;

// Phase thresholds
pfs_reg_t ph_thresh [0:2];

// Rising edge of start signal
wire start_r = (start & ~z1_start);

// Strobe on the rising edge of the 1MHz clock
wire strobe_1us = clock_1mhz & ~z1_clock_1mhz;

/* Only start if there's a pulse period long enough to create a pulse (more than
 * three clocks) and a nonzero length of pulses.
 */
wire inputs_valid = (pulse_period > 3) && (pulse_len > 0);

// Only ready to accept new inputs when we're in IDLE
assign ready = (state == IDLE);

// Determine if we're in the A quadrants (0, 1) and/or the B quadrants (1, 2)
wire in_a_quad = (div_count < ph_thresh[1]);
wire in_b_quad = (ph_thresh[0] <= div_count) && (div_count < ph_thresh[2]);

// Pipes to delay the Low sides by 13 16mhz clock cycles (812.5ns)
logic [13:0] ph_a_l_z;
logic [13:0] ph_b_l_z;
assign ph_a_l = ph_a_l_z[13];
assign ph_b_l = ph_b_l_z[13];

always_ff @(posedge clock_16mhz) begin
    z1_start <= start;
    z1_clock_1mhz <= clock_1mhz;
end

always_ff @(posedge clock_16mhz or posedge reset) begin
    if (reset) begin
        state <= RESET;
    end else begin
        state <= next_state;
    end
end

// Next state decoder logic
always_comb begin
    next_state = state;

    case (state)
      RESET:    next_state = IDLE;
      IDLE:     next_state = start_r ? LATCH : state;
      LATCH:    next_state = inputs_valid ? SYNC_1US : IDLE;
      SYNC_1US: next_state = strobe_1us ? MTR_DRV : state;
      MTR_DRV:  next_state = (strobe_1us && (us_left == 0)) ? IDLE : state;
    endcase
end

always_comb begin
    // Subtract 1 due to zero indexing
    pulse_period_init = pulse_period - 1;

    // Compute the phase thresholds:
    //  ph_thresh[i] <- (i + 1)*pulse_period/4
    ph_thresh[0]     = pulse_period >> 2;
    ph_thresh[1]     = pulse_period >> 1;
    ph_thresh[2]     = (pulse_period >> 2) + (pulse_period >> 1);
end

// Update counters
always_ff @(posedge clock_16mhz) begin
    if (reset) begin
        div_count   <= 0;
        us_left <= 0;
    end else begin
        case (state)
          LATCH: begin
            // Initialize the counters
            div_count <= pulse_period_init;
            us_left   <= pulse_len - 1;
          end
          MTR_DRV: begin
            // Standard idiom.  Decrement the clk_div counter until it hits
            // zero, then reset it and decrement the pulse count.  If the pulse
            // count hits zero we're going into MTR_IDLE, so reset it to the
            // wait count.
            div_count <= div_count - 1;
            if (div_count == 0) begin
                div_count <= pulse_period_init;
            end
            if (strobe_1us) begin
                us_left <= us_left - 1;
            end
          end
        endcase
    end
end

// Output decoder
always_ff @(posedge clock_16mhz) begin
    // Normally we want these held low
    ph_a_h <= 0;
    ph_a_l_z <= 0;
    ph_b_h <= 0;
    ph_b_l_z <= 0;

    if (state == MTR_DRV) begin
        // We're in the drive state, drive the phases

        // Drive A high during phases 0 or 1.  Drive B in quadrature.  B derives
        // from dir---if it's low you'll get one direction, high the other.
        ph_a_h <= in_a_quad ?  1 :  0;
        ph_a_l_z[0] <= in_a_quad ? ~1 : ~0;
        ph_b_h <= in_b_quad ?  dir : ~dir;
        ph_b_l_z[0] <= in_b_quad ? ~dir :  dir;
        
        ph_a_l_z[13:1] <= ph_a_l_z[12:0];
        ph_b_l_z[13:1] <= ph_b_l_z[12:0];
        //
    end
end

endmodule

/* vim: set syntax=systemverilog: */
