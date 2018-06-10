/*********************************************************************
 * \file
 * \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
 * \brief
 *
 * \copyright
 * Copyright 2009-2015, by the California Institute of Technology.
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

import MM_STATES::*;
import PFS::*;

module mm_throttle (
    input  logic      clock_16mhz,
    input  logic      clock_1mhz,
    input  logic      reset,
    input  mm_state_t state,
    input  pfs_reg_t  step_len,
    output logic      done
);

// Number of microseconds left in a step
pfs_reg_t us_left;

// Delayed 1MHz clock
logic z1_clock_1mhz;

// Strobe on the rising edge of the 1MHz clock
wire strobe_1us = clock_1mhz & ~z1_clock_1mhz;

// The throttle is finished when there are 0 microseconds left
assign done = (us_left == 0);

// Delayed version of the clock (to search for edges)
always_ff @(posedge clock_16mhz) begin
    z1_clock_1mhz <= clock_1mhz;
end

// Logic to update the # of microseconds left in this step
always_ff @(posedge clock_16mhz or posedge reset) begin
    if (reset) begin
        us_left <= 0;
    end else begin
        if (strobe_1us) begin
            // Decrement the number of microseconds left until 0, then stop
            if (us_left) begin
                us_left <= us_left - 1;
            end
        end
        // In the START_MOTOR state, initialize the number of
        // microseconds left
        if (state == START_MOTOR) begin
            us_left <= step_len;
        end
    end
end

endmodule

/* vim: set syntax=systemverilog: */
