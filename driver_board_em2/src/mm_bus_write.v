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

module mm_bus_write (
    input  logic clock,
    input  logic reset,

    input  mm_state_t state,
    input  mm_state_t next_state,
    input  col_addr_t col,

    input  rd_data_t num_steps,
    input  rd_data_t num_sleeps,
    input  pfs_reg_t [4] enables,

    input  logic     wr_gnt,
    output wr_data_t wr_data,
    output wr_addr_t wr_addr,
    output logic     wr_req,

    output logic move_finished,
    output logic update_counts_done,
    output logic finalize_done
);

////////////////////////////////////////////////////////////////////////////////

localparam NUM_FINALIZE_REGS = 5;
localparam reg_addr_t FINALIZE_REGS [NUM_FINALIZE_REGS] = {
    MOTOR_ENABLE_REG0,
    MOTOR_ENABLE_REG1,
    MOTOR_ENABLE_REG2,
    MOTOR_ENABLE_REG3,
    CONTROL_REG
};

// We have to write back the # steps back into the register bank, one per row.
// That's the maximum number of bus transactions.
localparam MAX_BUS_TXNS = MOTOR_ROWS;

////////////////////////////////////////////////////////////////////////////////

logic [$clog2(MAX_BUS_TXNS)-1:0] bus_txn_idx, row;

logic motor_en;
logic motor_has_sleeps;
logic motor_has_steps;
logic more_sleeps;
logic more_steps;


wire state_transition = (state != next_state);

////////////////////////////////////////////////////////////////////////////////

assign row = bus_txn_idx;

assign motor_en = enables[col][row];

assign motor_has_sleeps = (num_sleeps[row] != 0);

assign motor_has_steps = (num_steps[row] != 0);

assign more_steps = (num_steps[row] > 1);

assign more_sleeps = (num_sleeps[row] > 1);

assign finalize_done = ((state == FINALIZE) && wr_gnt && 
    (bus_txn_idx == NUM_FINALIZE_REGS-1));

assign update_counts_done = ((state == UPDATE_COUNTS) && wr_gnt &&
    (bus_txn_idx == MOTOR_ROWS-1));

////////////////////////////////////////////////////////////////////////////////

// Register write decoder
always_comb begin
    if (reset) begin
        wr_addr = 0;
        wr_data = 0;
        wr_req = 0;
    end else begin
        wr_addr = 0;
        wr_data = 0;
        wr_req = 0;
        
        case (state)
          UPDATE_COUNTS: begin
            wr_req = 1;
            
            // If this motor ran (enabled, no sleep, and had steps)
            if(motor_en && !motor_has_sleeps && motor_has_steps) begin
                wr_addr = make_wr_addr_t(row, col, NUM_STEPS_REG);
                // then decrement the number of steps.
                wr_data = num_steps[row] - 1;
            end
            // If the motor was enabled but is still sleeping
            else if(motor_en && motor_has_sleeps) begin //
                wr_addr = make_wr_addr_t(row, col, NUM_SLEEPS_REG);
                // then decrement the number of sleeps.
                wr_data = num_sleeps[row] - 1;
            end
            else begin
                // Otherwise, save the previous value.  So, if it was disabled,
                // keep the previous value, and if there is no steps, keep 0
                wr_addr = make_wr_addr_t(row, col, NUM_STEPS_REG);
                wr_data = num_steps[row];
            end
          end
          
          FINALIZE: begin
            wr_addr = make_wr_addr_t(CONTROL_ROW, CONTROL_COL, FINALIZE_REGS[bus_txn_idx]);
            wr_req = 1;
            wr_data = 0;
          end
        endcase
    end
end

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        bus_txn_idx <= 0;
    end else begin

        // If a write is granted, increment the transaction index
        if (wr_gnt) begin
            bus_txn_idx <= bus_txn_idx + 1;
        end

        // If we're entering a new state, then reset the transaction count.
        // This overrides the increment above.
        if (state_transition) begin
            bus_txn_idx <= 0;
        end
    end
end

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        move_finished <= 1;
    end else begin
        case (state)
          UPDATE_COUNTS: begin
          // must be enabled, wr_gnt, num_steps must have been larger than 1,
            if(wr_gnt &&  motor_en && (more_steps || more_sleeps) ) begin
                move_finished <= 0;
            end
          end
          CHECK_IF_FINISHED:  begin
            move_finished <= 1;
          end
        endcase
    end
end

endmodule

/* vim: set syntax=systemverilog: */
