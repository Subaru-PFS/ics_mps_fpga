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

import MM_STATES::*;
import PFS::*;

module motor_mux #(
    parameter BUS_ADDR = 0
) (
    pfs_bus.slave bus,
    input  logic soft_reset,
    input  logic clock_1mhz,
    output logic ready,
    output logic col_finished,
    
    // flags for whether each motor driver is ready
    output logic [MOTOR_ROWS-1:0] row_ready,

    output logic [MOTOR_ROWS-1:0] ph_a_h,   //% Drivers for high side, phase A
    output logic [MOTOR_ROWS-1:0] ph_b_h,   //% Drivers for low  side, phase A
    output logic [MOTOR_ROWS-1:0] ph_a_l,   //% Drivers for high side, phase B
    output logic [MOTOR_ROWS-1:0] ph_b_l,   //% Drivers for low  side, phase B
    output logic [MOTOR_COLS-1:0] col_en    //% Column enables
);

////////////////////////////////////////////////////////////////////////////////
// Signal declarations
////////////////////////////////////////////////////////////////////////////////

wire clock_16mhz = bus.clock;
wire reset = bus.reset | soft_reset;

mm_state_t state, next_state;

////////////////////////////////////////////////////////////////////////////////

// Single-cycle pulse to start a row of motor drivers
logic start_motors;

// The active row of motor drivers
col_addr_t col;


// Holding variables
rd_data_t pulse_periods;
rd_data_t pulse_lens;
rd_data_t num_steps;
rd_data_t num_sleeps;

pfs_reg_t     step_len;
pfs_reg_t [4] enables;
pfs_reg_t [4] dirs;

logic start_mux;
logic get_setup_regs_done;
logic get_motor_regs_done;
logic update_counts_done;
logic finalize_done;
logic move_finished;
logic throttle_done;

////////////////////////////////////////////////////////////////////////////////

logic [1:0] subcol_idx;

logic subcol_done;

// Bus-and the "driver ready" signals so we know when they're all ready.
wire col_done = (subcol_idx == 3) && subcol_done;

// Mark when we're on the last col
wire last_col = (col == MOTOR_COLS - 1);

// Motor mux only accepts a "go" when in the IDLE state
assign ready = (state == IDLE);

////////////////////////////////////////////////////////////////////////////////
// FSM Logic
////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock_16mhz or posedge reset) begin
    if (reset) begin
        state <= RESET;
    end else begin
        state <= next_state;
    end
end

////////////////////////////////////////////////////////////////////////////////

// Next state decoder
always_comb begin
    next_state = state;

    case (state)
      RESET:                next_state = IDLE;
      IDLE:                 next_state = start_mux ? START_MUX : state;
      START_MUX:            next_state = GET_SETUP_REGS;
      GET_SETUP_REGS:       next_state = get_setup_regs_done ? GET_MOTOR_REGS : state;
      GET_MOTOR_REGS:       next_state = get_motor_regs_done ? FINISH_SETUP : state;
      FINISH_SETUP:         next_state = START_MOTOR;
      START_MOTOR:          next_state = DRIVE;
      DRIVE: begin
        if (subcol_done) begin
            next_state = WAIT_FOR_THROTTLE;
        end
      end
      WAIT_FOR_THROTTLE:    begin
        if (throttle_done) begin
            next_state = col_done ? UPDATE_COUNTS : START_MOTOR;
        end
      end
	  UPDATE_COUNTS: begin
		if(update_counts_done) begin
			next_state = last_col ? CHECK_IF_FINISHED : GET_MOTOR_REGS;
		end
	  end
      CHECK_IF_FINISHED:    next_state = move_finished ? FINALIZE : GET_MOTOR_REGS;
      FINALIZE:             next_state = finalize_done ? IDLE : state;
    endcase
end

////////////////////////////////////////////////////////////////////////////////

always_comb begin
    if (reset) begin
        start_motors = 0;
    end else begin
        start_motors = (state == START_MOTOR);
    end
end

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock_16mhz or posedge reset) begin
    if (reset) begin
        subcol_idx <= 0;
    end else begin
        if (state == FINISH_SETUP) begin
            subcol_idx <= 0;
        end
        if ((state == WAIT_FOR_THROTTLE) && (state != next_state)) begin
            subcol_idx <= subcol_idx + 1;
        end
    end
end

////////////////////////////////////////////////////////////////////////////////

always_comb begin
    if (reset) begin
        subcol_done = 0;
    end else begin
        case (subcol_idx)
            0: subcol_done = &row_ready[3:0];
            1: subcol_done = &row_ready[7:4];
            2: subcol_done = &row_ready[11:8];
            3: subcol_done = &row_ready[15:12];
        endcase
    end
end
/*******************************************************************************
 * Submodule instantiation
 ******************************************************************************/

mm_bus_read mm_bus_read (
    .clock(clock_16mhz),
    .reset(reset),

    .state(state),
    .next_state(next_state),
    .col(col),

    .rd_gnt(bus.rd_gnt[BUS_ADDR]),
    .rd_data(bus.rd_data),
    .rd_addr(bus.rd_addr[BUS_ADDR]),
    .rd_req(bus.rd_req[BUS_ADDR]),
    
    .step_len(step_len),
    .enables(enables),
    .dirs(dirs),

    .pulse_periods(pulse_periods),
    .pulse_lens(pulse_lens),
    .num_steps(num_steps),
	.num_sleeps(num_sleeps),

    .start(start_mux),
    .get_setup_regs_done(get_setup_regs_done),
    .get_motor_regs_done(get_motor_regs_done)
);

////////////////////////////////////////////////////////////////////////////////

mm_col_control mm_col_control (
    .clock(clock_16mhz),
    .reset(reset),

    .state(state),
    .update_counts_done(update_counts_done),
    .col_done(col_done),
    .last_col(last_col),

    .col(col),
    .col_en(col_en),
    .col_finished(col_finished)
);

////////////////////////////////////////////////////////////////////////////////

mm_bus_write mm_bus_write (
    .clock(clock_16mhz),
    .reset(reset),

    .state(state),
    .next_state(next_state),
    .col(col),

    .num_steps(num_steps),
	.num_sleeps(num_sleeps),
    .enables(enables),

    .wr_gnt(bus.wr_gnt[BUS_ADDR]),
    .wr_data(bus.wr_data[BUS_ADDR]),
    .wr_addr(bus.wr_addr[BUS_ADDR]),
    .wr_req(bus.wr_req[BUS_ADDR]),

    .move_finished(move_finished),
    .update_counts_done(update_counts_done),
    .finalize_done(finalize_done)
);

////////////////////////////////////////////////////////////////////////////////

// Step length throttle
mm_throttle mm_throttle (
    .clock_16mhz(clock_16mhz),
    .clock_1mhz(clock_1mhz),
    .reset(reset),
    .state(state),
    .step_len(step_len),
    .done(throttle_done)
);

////////////////////////////////////////////////////////////////////////////////

// The motor drivers
genvar row;
generate for (row = 0; row < MOTOR_ROWS; row = row + 1) begin: DRIVERS
    // Only run the motor if:
    // - The ### steps is nonzero
    // - The motor is enabled
	// - The ### sleeps is zero
    // - This is in the right "sub row"
    wire enabled = (num_steps[row] != 0) &&
                   (enables[col][row]) && 
				   (num_sleeps[row] == 0) &&
                   (subcol_idx == row[3:2]);

    motor_driver motor_driver (
        .clock_16mhz(clock_16mhz),
        .clock_1mhz(clock_1mhz),
        .reset(reset),
        .pulse_period(pulse_periods[row]),
        .pulse_len(pulse_lens[row]),
        .dir(dirs[col][row]),
        .start(enabled & start_motors),
        .ready(row_ready[row]),
        .ph_a_h(ph_a_h[row]),
        .ph_a_l(ph_a_l[row]),
        .ph_b_h(ph_b_l[row]),
        .ph_b_l(ph_b_h[row])
    );
end
endgenerate

endmodule

/* vim: set syntax=systemverilog: */
