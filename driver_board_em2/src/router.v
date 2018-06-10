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

module router (
    input   logic       clock,          ///< Input clock
    input   logic       reset,          ///< Active-high reset
    input   rem_cmd_t   cmd_in,         ///< Received command
    input   logic       new_cmd_in,     ///< Flag indicating a new command was received
    output  rem_cmd_t   cmd_route,      ///< Output command to be routed
    output  logic       new_cmd_route,  ///< Flag indicating a command needs to be routed
    output  cmd_t       cmd_local,      ///< Local command to handle
    output  logic       new_cmd_local   ///< Flag indicating a local command needs to be handled
);

always_ff @(posedge clock) begin
    if (reset) begin
        cmd_local       <= def_cmd;
        cmd_route       <= '{target: 0, payload: def_cmd};
        new_cmd_local   <= 0;
        new_cmd_route   <= 0;
    end else begin
        new_cmd_local <= 0;
        new_cmd_route <= 0;
        if (new_cmd_in) begin
            // We've received a command...
            if (cmd_in.target == 0) begin
                // The target is 0, which is "me".  Copy the payload into the
                // local command port and set the flag
                cmd_local <= cmd_in.payload;
                new_cmd_local <= 1;
            end else begin
                // The target is not 0, so we just forward.  Copy the payload,
                // decrement the target count, and set the flag
                cmd_route.target <= (cmd_in.target - 1);
                cmd_route.payload <= cmd_in.payload;
                new_cmd_route <= 1;
            end
        end
    end
end

endmodule

/* vim: set syntax=systemverilog: */
