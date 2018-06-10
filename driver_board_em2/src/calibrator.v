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

/*******************************************************************************
 * Module declaration
 ******************************************************************************/

module calibrator #(
    parameter BUS_ADDR = 0
) (
    pfs_bus.slave bus,
    input         logic soft_reset,
    input logic [15:0]  adc_val,
    input         logic mux_ready,
    input         logic col_finished,
    output        logic current_sense,
    
    output logic [ROW_AWIDTH-1:0] cal_row
);

/*******************************************************************************
 * Local signal declarations
 ******************************************************************************/

// Current period, min/max allowable, and period delta
pfs_reg_t period, period_min, period_max, period_stp;

// How many cycles to wait before sampling the adc
pfs_reg_t cal_sleep;

// Cache the STEP_LEN_REG
pfs_reg_t step_len;

// Which motors to calibrate
logic [63:0] enabled_motors;

// Maximum ADC value and the corresponding period
logic [15:0] peak_adc_val;
pfs_reg_t peak_period;

// Local ADC control register value
pfs_reg_t adc_ctrl;

// Iterating over this table will calibrate all
// the 3.4mm motors in order (first two text rows), then all the 2.4mm
// motors in order (last two rows of text).  The final motor is the control
// "motor", which is a sentinel in the control FSM.

localparam motor_addr_t MOTOR_LUT[MAX_MOTORS_PER_BOARD+1] = {
     6'd  0, 6'd  1, 6'd  4, 6'd  5, 6'd  8, 6'd  9, 6'd 12, 6'd 13, 6'd 16, 6'd 17, 6'd 20, 6'd 21, 6'd 24, 6'd 25, 6'd 28, 6'd 29, 
     6'd 32, 6'd 33, 6'd 36, 6'd 37, 6'd 40, 6'd 41, 6'd 44, 6'd 45, 6'd 48, 6'd 49, 6'd 52, 6'd 53, 6'd 56,
     6'd  2, 6'd  3, 6'd  6, 6'd  7, 6'd 10, 6'd 11, 6'd 14, 6'd 15, 6'd 18, 6'd 19, 6'd 22, 6'd 23, 6'd 26, 6'd 27, 6'd 30, 6'd 31,
     6'd 34, 6'd 35, 6'd 38, 6'd 39, 6'd 42, 6'd 43, 6'd 46, 6'd 47, 6'd 50, 6'd 51, 6'd 54, 6'd 55, 6'd 58,
     CONTROL_MTR};

// Selected motor index
logic [MTR_AWIDTH-1:0] motor_count;
wire [MTR_AWIDTH-1:0] sel_motor_idx = MOTOR_LUT[motor_count];

// Pick off the row and column for the selected motor
wire [ROW_AWIDTH-1:0] row = sel_motor_idx[0 +: ROW_AWIDTH];
wire [COL_AWIDTH-1:0] col = sel_motor_idx[ROW_AWIDTH +: COL_AWIDTH];

// Count the number of pulses of "finishing" from the motor mux
logic [COL_AWIDTH-1:0] col_finished_cnt;

// bringing the calibrate row outside module
assign cal_row = row;

/*******************************************************************************
 * State machine state declaration
 ******************************************************************************/

enum {
    RESET,
    IDLE,
    GET_SETUP_REGS,
    CHOOSE_MOTOR,
    GET_MOTOR_REGS,
    LOAD_PARAMS,
    START_MOTOR,
    RUN_MOTOR,
    INCR_PERIOD,
    CONTINUE,
    UPDATE_RESULTS,
    FINALIZE
} state, next_state, z1_state;

/*******************************************************************************
 * Register bank declarations
 *
 * Several of the FSM states need to read or write a collection of register
 * values.  Instead of breaking each separate read/write into a distinct state,
 * they are collected into groups, and each group has three components:
 * 1) The number of registers (NUM_*_REGS)
 * 2) The actual register addresses (reg_addr_t *_REGS [NUM_*_REGS]
 * 3) The registers themselves (pfs_reg_t *_regs [NUM_*_REGS])
 *
 * Within each of these states in the state machine, attempt to read/write
 * NUM_*_REGS times.  The current register number is held in bus_txn_idx.  When
 * that counter hits the last register number *AND* the correct rd/wr_gnt
 * occurs, transition to the next state.
 ******************************************************************************/

// Setup registers---read once when a calibration is requested
localparam NUM_SETUP_REGS = 6;
localparam reg_addr_t SETUP_REGS [NUM_SETUP_REGS] = {
    MOTOR_ENABLE_REG0,
    MOTOR_ENABLE_REG1,
    MOTOR_ENABLE_REG2,
    MOTOR_ENABLE_REG3,
    CAL_SLEEP_REG,
    STEP_LEN_REG
};

pfs_reg_t setup_regs [NUM_SETUP_REGS];

assign enabled_motors = {setup_regs[3], setup_regs[2], setup_regs[1], setup_regs[0]};
assign cal_sleep = setup_regs[4];
assign step_len = setup_regs[5];

/******************************************************************************/

// Motor registers---read for each motor
localparam NUM_MOTOR_REGS = 3;
localparam reg_addr_t MOTOR_REGS [NUM_MOTOR_REGS] = {
    PERIOD_MIN_REG,
    PERIOD_MAX_REG,
    PERIOD_STP_REG
};

pfs_reg_t motor_regs [NUM_MOTOR_REGS];

// Local aliases
assign period_min = motor_regs[0],
       period_max = motor_regs[1],
       period_stp = motor_regs[2];

/******************************************************************************/

// Results registers---written for each motor
localparam NUM_RESULT_REGS = 3;
localparam reg_addr_t RESULT_REGS [NUM_RESULT_REGS] = {
    RES_PERIOD_REG,
    PULSE_PERIOD_REG,
    RES_PERIOD_ADC_REG
};

// Write back the max ADC value and the corresponding period.  Also, load
// that period into the pulse period register
pfs_reg_t result_regs [NUM_RESULT_REGS];
assign result_regs = '{peak_period, peak_period, peak_adc_val};

/******************************************************************************/

// Motor parameters---written for each motor
localparam NUM_LOAD_PARAMS_REGS = 10;
localparam reg_addr_t LOAD_PARAMS_REGS [NUM_LOAD_PARAMS_REGS] = {
    PULSE_PERIOD_REG,
    PULSE_LEN_REG,
    STEP_LEN_REG,
    NUM_STEPS_REG,
    ADC0_CTRL_REG,
    MOTOR_ENABLE_REG0,
    MOTOR_ENABLE_REG1,
    MOTOR_ENABLE_REG2,
    MOTOR_ENABLE_REG3,
    CONTROL_REG
};

pfs_reg_t load_params_regs [NUM_LOAD_PARAMS_REGS];

assign  load_params_regs[0] = period,
        load_params_regs[1] = cal_sleep,
        load_params_regs[2] = 0,
        load_params_regs[3] = 1,
        load_params_regs[4] = adc_ctrl,
        load_params_regs[9] = 1 << RUN_BIT;

assign  {load_params_regs[8], load_params_regs[7], load_params_regs[6],
    load_params_regs[5]} = 1 << sel_motor_idx;

/******************************************************************************/

// Finalization parameters---written once at the end
localparam NUM_FINALIZE_REGS = 6;
localparam reg_addr_t FINALIZE_REGS [NUM_FINALIZE_REGS] = {
    MOTOR_ENABLE_REG0,
    MOTOR_ENABLE_REG1,
    MOTOR_ENABLE_REG2,
    MOTOR_ENABLE_REG3,
    STEP_LEN_REG,
    CONTROL_REG
};

pfs_reg_t finalize_regs [NUM_FINALIZE_REGS];
assign finalize_regs = '{
    setup_regs[0],
    setup_regs[1],
    setup_regs[2],
    setup_regs[3],
    step_len,
    0};

/******************************************************************************/

// Maximum number of bus transactions
localparam MAX_BUS_TXNS = NUM_LOAD_PARAMS_REGS;

// Bus transaction count, and its value delayed by one cycle.  Used as an index
// into the register banks above.
logic [$clog2(MAX_BUS_TXNS)-1:0] bus_txn_idx, z1_bus_txn_idx;


/*******************************************************************************
 * Bus signal aliases
 *
 * Bring the bus.* signals into a local namespace
 ******************************************************************************/

// Signals from the bus
wire clock = bus.clock;
wire wr_gnt = bus.wr_gnt[BUS_ADDR];
wire rd_gnt = bus.rd_gnt[BUS_ADDR];

// Reset if we are signaled from the bus (a hard reset) *OR* we get a soft reaset
wire reset = bus.reset | soft_reset;

rd_data_t rd_data;

// Signals to the bus
logic wr_req;
logic rd_req;

rd_addr_t rd_addr;

wr_addr_t wr_addr;
wr_data_t wr_data;

assign bus.wr_req[BUS_ADDR] = wr_req;
assign bus.wr_addr[BUS_ADDR] = wr_addr;
assign bus.wr_data[BUS_ADDR] = wr_data;

assign bus.rd_req[BUS_ADDR] = rd_req;
assign bus.rd_addr[BUS_ADDR] = rd_addr;
assign rd_data = bus.rd_data;


////////////////////////////////////////////////////////////////////////////////

wire state_transition = (state != next_state);

////////////////////////////////////////////////////////////////////////////////

// Delayed signals
logic z1_rd_gnt;

// Start the motor mux when the run bit goes high
wire run_bit = rd_data[CONTROL_ROW][CAL_BIT];


// Sample the ADC when the mux notifies us that a group is finished and it's
// the column we're driving.
wire sample_adc = (col_finished && (col == col_finished_cnt));

// delay sample adc
logic z1_sample_adc;

// Enable adc to sense current only when we are running a CAL
assign current_sense = (state != IDLE) && (state != RESET);

////////////////////////////////////////////////////////////////////////////////

// State transition
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= RESET;
    end else begin
        state <= next_state;
    end
end

always_ff @(posedge clock or posedge reset) begin
    z1_state <= reset ? RESET : state;
    z1_rd_gnt <= reset ? 0 : rd_gnt;
    z1_sample_adc <= reset ? 0 : sample_adc;
end

// Next state decoder
always_comb begin
    next_state = state;
    
    case (state)
      RESET:          next_state = IDLE;
      IDLE:           next_state = (z1_rd_gnt && run_bit)                              ? GET_SETUP_REGS : state;
      GET_SETUP_REGS: next_state = (rd_gnt && (bus_txn_idx == NUM_SETUP_REGS-1))       ? CHOOSE_MOTOR   : state;
      CHOOSE_MOTOR:   begin
        if (enabled_motors[sel_motor_idx]) next_state = GET_MOTOR_REGS;
        if (sel_motor_idx == CONTROL_MTR)  next_state = FINALIZE;
      end
      GET_MOTOR_REGS: next_state = (rd_gnt && (bus_txn_idx == NUM_MOTOR_REGS-1))       ? LOAD_PARAMS    : state;
      LOAD_PARAMS:    next_state = (wr_gnt && (bus_txn_idx == NUM_LOAD_PARAMS_REGS-1)) ? START_MOTOR    : state;
      START_MOTOR:    next_state = (mux_ready == 0)                                    ? RUN_MOTOR      : state;
      RUN_MOTOR:      next_state = (mux_ready)                                         ? INCR_PERIOD    : state;
      INCR_PERIOD:    next_state = CONTINUE;
      CONTINUE:       next_state = (period >= period_max)                              ? UPDATE_RESULTS : LOAD_PARAMS;
      UPDATE_RESULTS: next_state = (wr_gnt && (bus_txn_idx == NUM_RESULT_REGS-1))      ? CHOOSE_MOTOR   : state;
      FINALIZE:       next_state = (wr_gnt && (bus_txn_idx == NUM_FINALIZE_REGS-1))    ? IDLE           : state;
    endcase
end

////////////////////////////////////////////////////////////////////////////////
/*
 normalization of the current peak adc value for comparison, we give a lower
 weight to the previous adc value which had a lower period, meaning it had a 
 higher frequency. The reason for this is that higher frequencies naturally use
 more current, and can interfere with attempts to find the local maximum in 
 a given period window.
*/

wire [15:0] norm_adc_val;

cal_norm cal_norm (
    .rst(reset),
    .clk(clock),
    
    .go(z1_sample_adc),
    .curr(peak_adc_val),
    .per(peak_period),
    
    .curr_norm(norm_adc_val)
);

////////////////////////////////////////////////////////////////////////////////

// Logic to examine ADC value
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        peak_period <= 0;
        peak_adc_val <= 0;
        col_finished_cnt <= 0;
    end else begin
        // Before driving a motor, initialize the peak adc value to 0 so that any
        // subsequent sample with real data will override
        if (state == GET_MOTOR_REGS) begin
            peak_period <= 0;
            peak_adc_val <= 0;
        end
        // Wait for a "column finished" pulse from the multiplexer.  When that
        // signal appears, increment a counter and check to see if we're at the
        // currently driven column.  If so, grab the current adc value and
        // compare it against the current max.  If new > current, save new.
        // Otherwise, save current.
        if (col_finished) begin
            if (sample_adc) begin
                if (adc_val > norm_adc_val) begin
                    peak_adc_val <= adc_val;
                    peak_period <= period;
                end
            end

            col_finished_cnt <= col_finished_cnt + 1;
        end

        if (state == IDLE) begin
            col_finished_cnt <= 0;
        end
    end
end

////////////////////////////////////////////////////////////////////////////////

// Logic to set the current period
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        period <= 0;
    end else begin
        if ((state == GET_MOTOR_REGS) && (state_transition)) begin
            // If we're transitioning out of the GET_MOTOR_REGS state, then the
            // minimum period has been collected.  Store it as the initial
            // value for period.
            period <= period_min;
        end
        if (state == INCR_PERIOD) begin
            // We've completed a period loop, select the next period
            // value.  By default, just add the period step.
            period <= period + period_stp;

            if (period_stp == 0) begin
                // if the input was dumb (step value == 0), just increment the
                // period value.
                period <= period + 1;
            end
            if (period + period_stp < period) begin
                // If the period step causes a wrap, saturate.
                period <= period_max;
            end
        end
    end
end

////////////////////////////////////////////////////////////////////////////////

// Motor selection logic.  If we're entering the CHOOSE_MOTOR state, increment
// the motor number UNLESS we're coming in for the first time (i.e. from
// GET_SETUP_REGS).  In that case, keep it at 0.
always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        motor_count <= 0;
    end else begin
        if (next_state == CHOOSE_MOTOR) begin
            motor_count <= motor_count + 1;
            if (state == GET_SETUP_REGS) begin
                motor_count <= 0;
            end
        end
    end
end

////////////////////////////////////////////////////////////////////////////////

// Memory write control
always_comb begin
    if (reset) begin
        wr_req = 0;
        wr_addr = 0;
        wr_data = 0;
    end else begin
        wr_req = 0;
        wr_addr = 0;
        wr_data = 0;
        case (state)
          LOAD_PARAMS: begin
            wr_req = 1;
            if (bus_txn_idx < 4)
                wr_addr = make_wr_addr_t(row, col, LOAD_PARAMS_REGS[bus_txn_idx]);
            else if (bus_txn_idx == 4) 
                wr_addr = make_wr_addr_t(ADC_ROW, ADC_COL, LOAD_PARAMS_REGS[bus_txn_idx]);
            else
                wr_addr = make_wr_addr_t(CONTROL_ROW, CONTROL_COL, LOAD_PARAMS_REGS[bus_txn_idx]);

            wr_data = load_params_regs[bus_txn_idx];
          end
          UPDATE_RESULTS: begin
            wr_req = 1;
            wr_addr = make_wr_addr_t(row, col, RESULT_REGS[bus_txn_idx]);
            wr_data = result_regs[bus_txn_idx];
          end
          FINALIZE: begin
            wr_req = 1;
            wr_addr = make_wr_addr_t(CONTROL_ROW, CONTROL_COL, FINALIZE_REGS[bus_txn_idx]);
            wr_data = finalize_regs[bus_txn_idx];
          end
        endcase
    end
end

////////////////////////////////////////////////////////////////////////////////

// Memory read control
always_comb begin
    if (reset) begin
        rd_req = 0;
        rd_addr = 0;
    end else begin
        rd_req = 0;
        rd_addr = 0;
        case (state)
          IDLE: begin
            rd_req = 1;
            rd_addr = make_rd_addr_t(CONTROL_COL, CONTROL_REG);
          end
          GET_SETUP_REGS: begin
            rd_req = 1;
            rd_addr = make_rd_addr_t(CONTROL_COL, SETUP_REGS[bus_txn_idx]);
          end
          GET_MOTOR_REGS: begin
            rd_req = 1;
            rd_addr = make_rd_addr_t(col, MOTOR_REGS[bus_txn_idx]);
          end
        endcase
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
            motor_regs[z1_bus_txn_idx] <= rd_data[row];
          end
        endcase
    end
end

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock) begin
    if (reset) begin
        z1_bus_txn_idx <= 0;
        bus_txn_idx <= 0;
    end else begin
        z1_bus_txn_idx <= bus_txn_idx;

        if (state_transition) begin
            bus_txn_idx <= 0;
        end else if (wr_gnt | rd_gnt) begin
            if ((state == GET_SETUP_REGS) || (state == GET_MOTOR_REGS) ||
                (state == UPDATE_RESULTS) || (state == FINALIZE) ||
                (state == LOAD_PARAMS)) begin
                bus_txn_idx <= bus_txn_idx + 1;
            end
        end
    end
end

/******************************************************************************/

// ADC control value (A/B + channel) selector
always_comb begin
    if (reset) begin
        adc_ctrl = 0;
    end else begin
        case ({col, row[3]})
          0: adc_ctrl = {1'b1, 3'd2};   // Group A, 1st Half => B2
          1: adc_ctrl = {1'b1, 3'd3};   // Group A, 2nd Half => B3
          2: adc_ctrl = {1'b1, 3'd5};   // Group B, 1st Half => B5
          3: adc_ctrl = {1'b0, 3'd6};   // Group B, 2nd Half => A6
          4: adc_ctrl = {1'b0, 3'd4};   // Group C, 1st Half => A4
          5: adc_ctrl = {1'b0, 3'd3};   // Group C, 2nd Half => A3
          6: adc_ctrl = {1'b0, 3'd2};   // Group D, 1st Half => A2
          7: adc_ctrl = {1'b0, 3'd2};   // Group D, 2nd Half => A2
        endcase
    end
end

endmodule

/* vim: set syntax=systemverilog: */
