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

package PFS;

parameter N_BOARDS = 84;
parameter MOTOR_ROWS = 16;
parameter MOTOR_COLS = 4;
parameter REGS_PER_MOTOR = 16;
parameter MAX_MOTORS_PER_BOARD = 58;

parameter BOARDS_AWIDTH = $clog2(N_BOARDS);
parameter ROW_AWIDTH = $clog2(MOTOR_ROWS);
parameter COL_AWIDTH = $clog2(MOTOR_COLS);
parameter REG_AWIDTH = $clog2(REGS_PER_MOTOR);

parameter WR_AWIDTH  = ROW_AWIDTH + COL_AWIDTH + REG_AWIDTH;
parameter RD_AWIDTH  =              COL_AWIDTH + REG_AWIDTH;
parameter MTR_AWIDTH = ROW_AWIDTH + COL_AWIDTH;

parameter DWIDTH = 16;

/*******************************************************************************/

typedef logic [DWIDTH-1:0]    pfs_reg_t;

typedef logic [BOARDS_AWIDTH-1:0] board_addr_t;
typedef logic [MTR_AWIDTH-1:0] motor_addr_t;
typedef logic [WR_AWIDTH-1:0] wr_addr_t;
typedef logic [RD_AWIDTH-1:0] rd_addr_t;

typedef logic [ROW_AWIDTH-1:0] row_addr_t;
typedef logic [COL_AWIDTH-1:0] col_addr_t;
typedef logic [REG_AWIDTH-1:0] reg_addr_t;

typedef pfs_reg_t wr_data_t;
typedef pfs_reg_t [MOTOR_ROWS] rd_data_t;

/*******************************************************************************/

// Core control registers
parameter reg_addr_t VERSION_REG        = 0,
                     SANDBOX_REG        = 1,
                     CONTROL_REG        = 2,
                     STATUS_REG         = 3,
                     MOTOR_ENABLE_REG0  = 4,
                     MOTOR_ENABLE_REG1  = 5,
                     MOTOR_ENABLE_REG2  = 6,
                     MOTOR_ENABLE_REG3  = 7,
                     MOTOR_DIR_REG0     = 8,
                     MOTOR_DIR_REG1     = 9,
                     MOTOR_DIR_REG2     = 10,
                     MOTOR_DIR_REG3     = 11,
                     STEP_LEN_REG       = 12,
                     CAL_SLEEP_REG      = 13;
                     
// ADC registers
parameter reg_addr_t ADC0_CTRL_REG      = 0,
                     ADC0_VAL_REG       = 1,
                     TEMP0_REG          = 2,
                     TEMP1_REG          = 3,
                     VOLTAGE_REG        = 4;
                     

// Per motor register offset
parameter reg_addr_t PULSE_PERIOD_REG   = 0,
                     PULSE_LEN_REG      = 1,
                     NUM_STEPS_REG      = 2,
                     PERIOD_MIN_REG     = 3,
                     PERIOD_MAX_REG     = 4,
                     PERIOD_STP_REG     = 5,
                     RES_PERIOD_REG     = 6,
                     RES_PERIOD_ADC_REG = 7,
					 NUM_SLEEPS_REG     = 8;

parameter motor_addr_t CONTROL_MTR = 63;
parameter row_addr_t   CONTROL_ROW = 15;
parameter col_addr_t   CONTROL_COL = 3;

parameter motor_addr_t ADC_MTR = 59;
parameter row_addr_t   ADC_ROW = 14;
parameter col_addr_t   ADC_COL = 3;

parameter   RUN_BIT = 0,
            CAL_BIT = 1,
            SOFT_RESET_BIT = 15;

parameter SOFT_RESET_DUR = 3;

/*******************************************************************************/

function wr_addr_t make_wr_addr_t;
    input row_addr_t row;
    input col_addr_t col;
    input reg_addr_t idx;
begin
    make_wr_addr_t = {row, col, idx};
end
endfunction

/*******************************************************************************/

function wr_addr_t wr_addr_from_rd_addr;
    input rd_addr_t addr;
    input row_addr_t row;
begin
    col_addr_t col;
    reg_addr_t idx;
    {col, idx} = addr;
    wr_addr_from_rd_addr = {row, col, idx};
end
endfunction

/*******************************************************************************/

function rd_addr_t make_rd_addr_t;
    input col_addr_t col;
    input reg_addr_t idx;
begin
    make_rd_addr_t = {col, idx};
end
endfunction

/*******************************************************************************/

typedef struct packed {
    logic running;
} mux_status_t;

/*******************************************************************************/

typedef struct packed {
    logic     rnw;   ///< Read-not-write
    wr_addr_t regno; ///< Register number
    pfs_reg_t value; ///< Value to write
} cmd_t;    ///< Command to execute

/*******************************************************************************/

typedef struct packed {
    board_addr_t target; ///< Board ID
    cmd_t payload;         ///< Command payload
} rem_cmd_t;                   ///< A remote command

/*******************************************************************************/

typedef struct packed {
    // NOTE: Ordering of values matter
    logic p1h;
    logic p1l;
    logic p2h;
    logic p2l;
} motor;

/*******************************************************************************/

/// Default command (for use during reset)
cmd_t def_cmd = '{rnw: 1, regno: 0, value: 0};

endpackage: PFS

/* vim: set syntax=systemverilog: */
