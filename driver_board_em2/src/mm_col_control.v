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

module mm_col_control (
    input  logic clock,
    input  logic reset,

    input  mm_state_t state,
    input  logic update_counts_done,
    input  logic col_done,
    input  logic last_col,

    output col_addr_t             col,
    output logic [MOTOR_COLS-1:0] col_en,
    output logic                  col_finished
);

////////////////////////////////////////////////////////////////////////////////

// Signal that a col is finished as we're exiting a col drive state
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        col_finished <= 0;
    end else begin
        col_finished <= 0;
        if ((state == DRIVE) && (col_done)) begin
            col_finished <= 1;
        end
    end
end

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        col <= 0;
        col_en <= 0;
    end else begin
        case (state)
          START_MUX: begin
            // When we start the mux, initialize the state variables
            col <= 0;           // Start with the first col
            col_en <= 1;        // Enable the first col
          end
          UPDATE_COUNTS: begin
            if (update_counts_done) begin
                // Once all motor drivers are ready...
                col <= last_col ? 0 : col + 1;             // Go to the next col
                col_en <= last_col ? 1 : col_en << 1;       // Enable the next col
            end
          end
          FINALIZE:          col_en <= 0;
        endcase
    end
end

endmodule

/* vim: set syntax=systemverilog: */
