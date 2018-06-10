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

module mm_bus_read (
    input  logic      clock,
    input  logic      reset,

    // FSM states
    input  mm_state_t state,
    input  mm_state_t next_state,
    input  col_addr_t col,

    // Bus signals
    input  logic      rd_gnt,
    input  rd_data_t  rd_data,
    output rd_addr_t  rd_addr,
    output logic      rd_req,

    // Output setup registers
    output pfs_reg_t     step_len,
    output pfs_reg_t [4] enables,
    output pfs_reg_t [4] dirs,

    // Output motor registers
    output rd_data_t pulse_periods,
    output rd_data_t pulse_lens,
    output rd_data_t num_steps,
    output rd_data_t num_sleeps,

    // State control signals
    output logic      start,
    output logic      get_setup_regs_done,
    output logic      get_motor_regs_done
);

////////////////////////////////////////////////////////////////////////////////

localparam NUM_SETUP_REGS = 9;
localparam reg_addr_t SETUP_REGS [NUM_SETUP_REGS] = {
    STEP_LEN_REG,
    MOTOR_ENABLE_REG0,
    MOTOR_ENABLE_REG1,
    MOTOR_ENABLE_REG2,
    MOTOR_ENABLE_REG3,
    MOTOR_DIR_REG0,
    MOTOR_DIR_REG1,
    MOTOR_DIR_REG2,
    MOTOR_DIR_REG3
};

localparam NUM_MOTOR_REGS = 4;
localparam reg_addr_t MOTOR_REGS [NUM_MOTOR_REGS] = {
    PULSE_PERIOD_REG,
    PULSE_LEN_REG,
    NUM_STEPS_REG,
    NUM_SLEEPS_REG
};

// Maximum number of bus transactions required
localparam MAX_BUS_TXNS = NUM_SETUP_REGS;

////////////////////////////////////////////////////////////////////////////////

logic z1_rd_gnt;
mm_state_t z1_state;

logic [$clog2(MAX_BUS_TXNS)-1:0] bus_txn_idx, z1_bus_txn_idx;

pfs_reg_t [NUM_SETUP_REGS] setup_regs;
rd_data_t [NUM_MOTOR_REGS] motor_regs;

wire state_transition = (state != next_state);

wire run_bit = rd_data[CONTROL_ROW][RUN_BIT];

////////////////////////////////////////////////////////////////////////////////

// Aliases into the setup registers
assign step_len = setup_regs[0];
assign enables = setup_regs[1:4];
assign dirs = setup_regs[5:8];

// Aliases into the motor registers
assign pulse_periods = motor_regs[0];
assign pulse_lens = motor_regs[1];
assign num_steps = motor_regs[2];
assign num_sleeps = motor_regs[3];

////////////////////////////////////////////////////////////////////////////////

// Define the state done signals
assign start = ((state == IDLE) && z1_rd_gnt && run_bit);
assign get_setup_regs_done = ((state == GET_SETUP_REGS) && rd_gnt &&
    (bus_txn_idx == NUM_SETUP_REGS-1));
assign get_motor_regs_done = ((state == GET_MOTOR_REGS) && rd_gnt &&
    (bus_txn_idx == NUM_MOTOR_REGS-1));

/*******************************************************************************
 * Register read decoder
 *
 * In some states (IDLE, GET_SETUP_REGS, GET_MOTOR_REGS), the FSM needs to
 * read registers from memory.  This block handles that logic.
 ******************************************************************************/

always_comb begin
    if (reset) begin
        rd_addr = 0;
        rd_req = 0;
    end else begin
        // By default, don't request a read
        rd_addr = 0;
        rd_req = 0;

        case(state)
          IDLE: begin
            // In the IDLE state, just keep reading out the control register and
            // wait for the RUN bit to be set.
            rd_req = 1;
            rd_addr = make_rd_addr_t(CONTROL_COL, CONTROL_REG);
          end
          GET_SETUP_REGS: begin
            // In the GET_SETUP_REGS state, read out each control register in
            // the SETUP_REGS array.
            rd_req = 1;
            rd_addr = make_rd_addr_t(CONTROL_COL, SETUP_REGS[bus_txn_idx]);
          end
          GET_MOTOR_REGS: begin
            // In the GET_MOTOR_REGS state, read out each motor register in
            // the RD_MOTOR_REGS array for the current col
            rd_req = 1;
            rd_addr = make_rd_addr_t(col, MOTOR_REGS[bus_txn_idx]);
          end
        endcase
    end
end

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock) begin
    z1_state <= state;
    z1_rd_gnt <= rd_gnt;
    z1_bus_txn_idx <= bus_txn_idx;
end

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        bus_txn_idx <= 0;
    end else begin

        // If a read is granted, increment the transaction index
        if (rd_gnt) begin
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

// The bus responds with read back data a cycle after you request it, so we use
// a delayed version of the state and the transaction index to load data into
// the setup and motor registers.
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        setup_regs <= '{default: 0};
        motor_regs <= '{default: 0};
    end else begin
        case (z1_state)
          GET_SETUP_REGS: begin
            setup_regs[z1_bus_txn_idx] <= rd_data[CONTROL_ROW];
          end
          GET_MOTOR_REGS: begin
            motor_regs[z1_bus_txn_idx] <= rd_data;
          end
        endcase
    end
end

endmodule

/* vim: set syntax=systemverilog: */
