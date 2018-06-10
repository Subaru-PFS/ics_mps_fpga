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

module calibrator_tb();

localparam  CLK16M_2 = 31.2,
            CLK16M = 2*CLK16M_2,
            CLK1M_2 = 500.0,
            RESET = 50*CLK16M,
            START = RESET + 3000*CLK16M,
            STOP = START + 64'd30_000_000;

logic clk_16m = 0;
logic clk_1m = 0;
logic start = 0;
logic rst = 1;

initial begin
    fork
        forever #CLK16M_2 clk_16m = ~clk_16m;
        forever #CLK1M_2  clk_1m = ~clk_1m;
        #RESET rst = 0;
        #START start = 1;
        #STOP $stop();
    join
end


/*****************************************************************************/
wire soft_rst;

wire current_sense;

wire [MOTOR_ROWS-1:0] phase_a_h;
wire [MOTOR_ROWS-1:0] phase_a_l;
wire [MOTOR_ROWS-1:0] phase_b_h;
wire [MOTOR_ROWS-1:0] phase_b_l;
wire [MOTOR_COLS-1:0] col_en;

logic [11:0] adc_inputs_a [0:7];
logic [11:0] adc_inputs_b [0:7];


/*****************************************************************************/

// The register bank
pfs_bus #(
    .NSLV(3)
) bus (
    .clock(clk_16m),
    .reset(rst)
);

pfs_bus_master #(
    .NSLV(3)
) bus_master (
    .bus(bus),
    .soft_reset(soft_rst)
);

/*****************************************************************************/

wire [15:0] adc_val;
wire mux_ready;
wire col_finished;
wire [ROW_AWIDTH-1:0] cal_row;


wire [MOTOR_ROWS-1:0] row_rdy;

calibrator #(
    .BUS_ADDR(0)
) calib (
    .bus(bus),
    .soft_reset(soft_rst),
    .adc_val(adc_val),
    .mux_ready(mux_ready),
    .col_finished(col_finished),
    .current_sense(current_sense),
    
    .cal_row(cal_row)
);


motor_mux #(
    .BUS_ADDR(1)
) mmux (
    .bus(bus),
    .soft_reset(soft_rst),
    .clock_1mhz(clk_1m),
    .ready(mux_ready),
    .col_finished(col_finished),
    
    .row_ready(row_rdy),
    
    .ph_a_h(phase_a_h),
    .ph_b_h(phase_b_h),
    .ph_a_l(phase_a_l),
    .ph_b_l(phase_b_l),
    .col_en(col_en)   
);

wire adc_douta,
     adc_doutb,
     adc_sclk_en,
     adc_ncs,
     adc_rng,
     adc_sgl;
     
wire [2:0] adc_addr;

wire data_a_del, data_b_del;

assign #1 data_a_del = adc_douta;
assign #1 data_b_del = adc_doutb;

adc_current_if #(
    .BUS_ADDR(2)
) current_if (
    .bus(bus),
    .soft_reset(soft_rst),
    .adc_sum(adc_val),
    
    .cal_row(cal_row),
    .row_rdy(row_rdy),
    
    .douta(data_a_del),
    .doutb(data_b_del),
    .adc_sclk_en(adc_sclk_en),
    .adc_addr(adc_addr),
    .ncs(adc_ncs),
    .rng(adc_rng),
    .sgl(adc_sgl)
);


ad7265_sim simulator (
    .din_a(adc_inputs_a),
    .din_b(adc_inputs_b),
    .adc_sclk(adc_sclk_en ? clk_16m : 1'b1),
    .douta(adc_douta),
    .doutb(adc_doutb),
    .adc_addr(adc_addr),
    .ncs(adc_ncs),
    .rng(adc_rng),
    .sgl(adc_sgl)
);

/*****************************************************************************/

/*
 when the column is enabled and we see the motor is not ready (aka running),
 give the adc simulator a non-zero value, otherwise keep it at 0.
*/

// a reasonable fixed value for current from a motor
logic [11:0] adc_current = 3360;

// group, A=0, B=1, C=2, D=3
logic [1:0] grp;
always_comb begin
    case (col_en[3:0])
    4'b1???:    grp = 3;
    4'b01??:    grp = 2;
    4'b001?:    grp = 1;
    4'b000?:    grp = 0;
    default:    grp = 0;
    endcase
end

// if we are in the 1st or 2nd half of the group (where a group consist of 8 cobras)
wire [1:0] subgrp;
// if any motors in the 2nd half of the row are not ready (aka running)
assign subgrp[1] = (row_rdy[15:8] != 8'hFF);
// if any motors in the 1st half of the row are not ready (aka running)
assign subgrp[0] = (row_rdy[7:0] != 8'hFF);

always_comb begin
    adc_inputs_a[0] = 0;
    adc_inputs_a[1] = 0;
    adc_inputs_a[2] = ((grp==3)) ?             adc_current:0;
    adc_inputs_a[3] = ((grp==2) & subgrp[1]) ? adc_current:0;
    adc_inputs_a[4] = ((grp==2) & subgrp[0]) ? adc_current:0;
    adc_inputs_a[5] = 0;
    adc_inputs_a[6] = ((grp==1) & subgrp[1]) ? adc_current:0;
    adc_inputs_a[7] = 0;
    
    adc_inputs_b[0] = 0;
    adc_inputs_b[1] = 0;
    adc_inputs_b[2] = ((grp==0) & subgrp[0]) ? adc_current:0;
    adc_inputs_b[3] = ((grp==0) & subgrp[1]) ? adc_current:0;
    adc_inputs_b[4] = 0;
    adc_inputs_b[5] = ((grp==1) & subgrp[0]) ? adc_current:0;
    adc_inputs_b[6] = 0;
    adc_inputs_b[7] = 0;
end


/*****************************************************************************/

col_addr_t col;
row_addr_t row;

initial begin
    @(posedge start);
    
    row = 0; col = 0;
    bus_master.regbank[make_wr_addr_t(row, col, PERIOD_MIN_REG)] = 100;
    bus_master.regbank[make_wr_addr_t(row, col, PERIOD_MAX_REG)] = 120;
    bus_master.regbank[make_wr_addr_t(row, col, PERIOD_STP_REG)] = 1;
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, MOTOR_ENABLE_REG0)] = 16'h0001;
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, CAL_SLEEP_REG)] = 16'd64;
    
    @(posedge clk_16m);
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, CONTROL_REG)] = 1 << CAL_BIT;
    
    #(20*CLK16M);
    @(posedge clk_16m);
    bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, CONTROL_REG)] = 0;

end


endmodule

/* vim: set syntax=systemverilog: */
