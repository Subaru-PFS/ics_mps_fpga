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

module motor_mux_tb ();

localparam  CLK_2 = 50,
            CLK = 2*CLK_2,
            RESET = 100*CLK,
            START = RESET + 1500*CLK,
            DONE = 400_000*CLK,
            SWITCH = DONE/2;

logic clock_16mhz = 0;
logic clock_1mhz = 0;
logic reset = 1;
logic soft_reset;
logic ready;
logic run = 0;
logic [MOTOR_ROWS-1:0] ph_a_h;
logic [MOTOR_ROWS-1:0] ph_b_h;
logic [MOTOR_ROWS-1:0] ph_a_l;
logic [MOTOR_ROWS-1:0] ph_b_l;
logic [MOTOR_COLS-1:0] col_en;
logic col_finished;

// The register bank
pfs_bus #(
    .NSLV(1)
) bus (
    .clock(clock_16mhz),
    .reset(reset)
);

pfs_bus_master bus_master (
    .bus(bus),
    .soft_reset(soft_reset)
);

motor_mux DUT (
    .clock_1mhz(clock_1mhz),
    .bus(bus),
    .soft_reset(soft_reset),
    .ready(ready),
    .col_finished(col_finished),
    .ph_a_h(ph_a_h),
    .ph_b_h(ph_b_h),
    .ph_a_l(ph_a_l),
    .ph_b_l(ph_b_l),
    .col_en(col_en)
);

col_addr_t col;
row_addr_t row;

initial begin
    bus_master.regbank = '{default: '{default: 0}};
    #START;

    row = 0; col = 0;
    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 270;
    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 300;
    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 4;
    bus_master.regbank[make_wr_addr_t(row, col, NUM_SLEEPS_REG)] = 1;

//    row = 0; col = 1;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 20;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 8;
//    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 6;
//
//    row = 1; col = 1;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 20;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 10;
//    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 8;
//
//    row = 2; col = 0;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 8;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 5;
//    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 9;
//
//    row = 2; col = 2;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 8;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 5;
//    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 10;
//
//    row = 2; col = 3;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 8;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 5;
//    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 9;
//
//    row = 3; col = 3;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 8;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 5;
//    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 3;
//
//    row = 3; col = 4;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_PERIOD_REG)] = 7;
//    bus_master.regbank[make_wr_addr_t(row, col, PULSE_LEN_REG)] = 5;
//    bus_master.regbank[make_wr_addr_t(row, col, NUM_STEPS_REG)] = 3;

    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, STEP_LEN_REG)] = 300;
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, MOTOR_ENABLE_REG0)] = -1;
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, MOTOR_DIR_REG1)] = -1;
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, MOTOR_ENABLE_REG1)] = -1;
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, MOTOR_ENABLE_REG2)] = -1;
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, MOTOR_ENABLE_REG3)] = -1;

    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, CONTROL_REG)] = 1;
end

initial begin
    fork
        forever #CLK_2 clock_16mhz = ~clock_16mhz;
        forever #(16*CLK_2) clock_1mhz = ~clock_1mhz;
        #RESET reset = 0;
        #DONE $stop;
    join
end

endmodule

/* vim: set syntax=systemverilog: */
