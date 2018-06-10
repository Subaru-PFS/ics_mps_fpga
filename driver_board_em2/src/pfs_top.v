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
`default_nettype none

import PFS::*;

module pfs_top (
    // I/F to motor drivers
    output c3p4_pwm1_h1,
    output c3p4_pwm1_h2,
    output c3p4_pwm1_h3,
    output c3p4_pwm1_h4,
    output c3p4_pwm1_h5,
    output c3p4_pwm1_h6,
    output c3p4_pwm1_h7,
    output c3p4_pwm1_h8,
    output c3p4_pwm1_l1,
    output c3p4_pwm1_l2,
    output c3p4_pwm1_l3,
    output c3p4_pwm1_l4,
    output c3p4_pwm1_l5,
    output c3p4_pwm1_l6,
    output c3p4_pwm1_l7,
    output c3p4_pwm1_l8,
    output c3p4_pwm2_h1,
    output c3p4_pwm2_h2,
    output c3p4_pwm2_h3,
    output c3p4_pwm2_h4,
    output c3p4_pwm2_h5,
    output c3p4_pwm2_h6,
    output c3p4_pwm2_h7,
    output c3p4_pwm2_h8,
    output c3p4_pwm2_l1,
    output c3p4_pwm2_l2,
    output c3p4_pwm2_l3,
    output c3p4_pwm2_l4,
    output c3p4_pwm2_l5,
    output c3p4_pwm2_l6,
    output c3p4_pwm2_l7,
    output c3p4_pwm2_l8,
    output c2p4_pwm1_h1,
    output c2p4_pwm1_h2,
    output c2p4_pwm1_h3,
    output c2p4_pwm1_h4,
    output c2p4_pwm1_h5,
    output c2p4_pwm1_h6,
    output c2p4_pwm1_h7,
    output c2p4_pwm1_h8,
    output c2p4_pwm1_l1,
    output c2p4_pwm1_l2,
    output c2p4_pwm1_l3,
    output c2p4_pwm1_l4,
    output c2p4_pwm1_l5,
    output c2p4_pwm1_l6,
    output c2p4_pwm1_l7,
    output c2p4_pwm1_l8,
    output c2p4_pwm2_h1,
    output c2p4_pwm2_h2,
    output c2p4_pwm2_h3,
    output c2p4_pwm2_h4,
    output c2p4_pwm2_h5,
    output c2p4_pwm2_h6,
    output c2p4_pwm2_h7,
    output c2p4_pwm2_h8,
    output c2p4_pwm2_l1,
    output c2p4_pwm2_l2,
    output c2p4_pwm2_l3,
    output c2p4_pwm2_l4,
    output c2p4_pwm2_l5,
    output c2p4_pwm2_l6,
    output c2p4_pwm2_l7,
    output c2p4_pwm2_l8,


    output sleep_c3p4_a,
    output sleep_c3p4_b,
    output sleep_c3p4_c,
    output sleep_c3p4_d,
    output sleep_c2p4_a,
    output sleep_c2p4_b,
    output sleep_c2p4_c,
    output sleep_c2p4_d,

    // I/F to prv board
    input reset_prv_fpga, // active low
    output rclk_prv,
    input clk_prv,
    input cmd_prv,
    output resp_prv,
    
    // I/F to nxt board
    output reset_nxt_fpga, // active low
    input rclk_nxt,
    output clk_nxt,
    output cmd_nxt,
    input resp_nxt,

    // I/F to ADC 1
    input adc1_out_a,
    input adc1_out_b,
    output adc1_addr2,
    output adc1_addr1,
    output adc1_addr0,
    output adc1_range_sel,
    output adc1_cs,
    output adc1_sclk,
    
    // I/F to ADC 2
    input adc2_out_a,
    input adc2_out_b,
    output adc2_addr2,
    output adc2_addr1,
    output adc2_addr0,
    output adc2_range_sel,
    output adc2_cs,
    output adc2_sclk,

    // I/O for testing
    inout test_io8,
    inout test_io7,
    inout test_io6,
    inout test_io5,
    inout test_io4,
    inout test_io3,
    inout test_io2,
    inout test_io1,

    // Misc
    input  pwr_on_reset, // active low
    output reset_db, // active low  
    output cs_bypass, // high disables power loss/ voltage drop
    output sfw_10,
    output sfw_3p3
);

/*********************************************************/

wire clk_1m;
wire clk_300k;

wire clk_prv_buf;
wire rclk_nxt_buf;
wire rclk_nxt_glob;

wire [2:0] adc1_addr;
wire [2:0] adc2_addr;

wire current_sense;

wire por_rst_buf;
wire swf_rst_n;
wire sys_rst;

// aliveness tests of cmd and tlm
wire cmd_alive;
wire tlm_alive;


logic [MOTOR_ROWS-1:0] ph_a_h;
logic [MOTOR_ROWS-1:0] ph_b_h;
logic [MOTOR_ROWS-1:0] ph_a_l;
logic [MOTOR_ROWS-1:0] ph_b_l;
logic [MOTOR_COLS-1:0] col_en;

/*********************************************************/
// Renaming motor signals
localparam COBRAS_PER_GROUP = MOTOR_ROWS/2;
motor [COBRAS_PER_GROUP-1:0] lrg_motors;
motor [COBRAS_PER_GROUP-1:0] sml_motors;
logic [MOTOR_COLS-1:0] group_en;

assign {c3p4_pwm1_h8, c3p4_pwm1_l8, c3p4_pwm2_h8, c3p4_pwm2_l8} = lrg_motors[7];
assign {c3p4_pwm1_h7, c3p4_pwm1_l7, c3p4_pwm2_h7, c3p4_pwm2_l7} = lrg_motors[6];
assign {c3p4_pwm1_h6, c3p4_pwm1_l6, c3p4_pwm2_h6, c3p4_pwm2_l6} = lrg_motors[5];
assign {c3p4_pwm1_h5, c3p4_pwm1_l5, c3p4_pwm2_h5, c3p4_pwm2_l5} = lrg_motors[4];
assign {c3p4_pwm1_h4, c3p4_pwm1_l4, c3p4_pwm2_h4, c3p4_pwm2_l4} = lrg_motors[3];
assign {c3p4_pwm1_h3, c3p4_pwm1_l3, c3p4_pwm2_h3, c3p4_pwm2_l3} = lrg_motors[2];
assign {c3p4_pwm1_h2, c3p4_pwm1_l2, c3p4_pwm2_h2, c3p4_pwm2_l2} = lrg_motors[1];
assign {c3p4_pwm1_h1, c3p4_pwm1_l1, c3p4_pwm2_h1, c3p4_pwm2_l1} = lrg_motors[0];

assign {c2p4_pwm1_h8, c2p4_pwm1_l8, c2p4_pwm2_h8, c2p4_pwm2_l8} = sml_motors[7];
assign {c2p4_pwm1_h7, c2p4_pwm1_l7, c2p4_pwm2_h7, c2p4_pwm2_l7} = sml_motors[6];
assign {c2p4_pwm1_h6, c2p4_pwm1_l6, c2p4_pwm2_h6, c2p4_pwm2_l6} = sml_motors[5];
assign {c2p4_pwm1_h5, c2p4_pwm1_l5, c2p4_pwm2_h5, c2p4_pwm2_l5} = sml_motors[4];
assign {c2p4_pwm1_h4, c2p4_pwm1_l4, c2p4_pwm2_h4, c2p4_pwm2_l4} = sml_motors[3];
assign {c2p4_pwm1_h3, c2p4_pwm1_l3, c2p4_pwm2_h3, c2p4_pwm2_l3} = sml_motors[2];
assign {c2p4_pwm1_h2, c2p4_pwm1_l2, c2p4_pwm2_h2, c2p4_pwm2_l2} = sml_motors[1];
assign {c2p4_pwm1_h1, c2p4_pwm1_l1, c2p4_pwm2_h1, c2p4_pwm2_l1} = sml_motors[0];
// The sleeps are active low, so they're really just enables
assign sleep_c3p4_a = group_en[0];
assign sleep_c2p4_a = group_en[0];
assign sleep_c3p4_b = group_en[1];
assign sleep_c2p4_b = group_en[1];
assign sleep_c3p4_c = group_en[2];
assign sleep_c2p4_c = group_en[2];
assign sleep_c3p4_d = group_en[3];
assign sleep_c2p4_d = group_en[3];

/*********************************************************/
// Motor Mapping
assign lrg_motors[0] = '{p1h: ph_a_h[0], p1l: ph_a_l[0], p2h: ph_b_h[0], p2l: ph_b_l[0]};
assign lrg_motors[1] = '{p1h: ph_a_h[1], p1l: ph_a_l[1], p2h: ph_b_h[1], p2l: ph_b_l[1]};
assign sml_motors[0] = '{p1h: ph_a_h[2], p1l: ph_a_l[2], p2h: ph_b_h[2], p2l: ph_b_l[2]};
assign sml_motors[1] = '{p1h: ph_a_h[3], p1l: ph_a_l[3], p2h: ph_b_h[3], p2l: ph_b_l[3]};

assign lrg_motors[2] = '{p1h: ph_a_h[4], p1l: ph_a_l[4], p2h: ph_b_h[4], p2l: ph_b_l[4]};
assign lrg_motors[3] = '{p1h: ph_a_h[5], p1l: ph_a_l[5], p2h: ph_b_h[5], p2l: ph_b_l[5]};
assign sml_motors[2] = '{p1h: ph_a_h[6], p1l: ph_a_l[6], p2h: ph_b_h[6], p2l: ph_b_l[6]};
assign sml_motors[3] = '{p1h: ph_a_h[7], p1l: ph_a_l[7], p2h: ph_b_h[7], p2l: ph_b_l[7]};

assign lrg_motors[4] = '{p1h: ph_a_h[8], p1l: ph_a_l[8], p2h: ph_b_h[8], p2l: ph_b_l[8]};
assign lrg_motors[5] = '{p1h: ph_a_h[9], p1l: ph_a_l[9], p2h: ph_b_h[9], p2l: ph_b_l[9]};
assign sml_motors[4] = '{p1h: ph_a_h[10], p1l: ph_a_l[10], p2h: ph_b_h[10], p2l: ph_b_l[10]};
assign sml_motors[5] = '{p1h: ph_a_h[11], p1l: ph_a_l[11], p2h: ph_b_h[11], p2l: ph_b_l[11]};

assign lrg_motors[6] = '{p1h: ph_a_h[12], p1l: ph_a_l[12], p2h: ph_b_h[12], p2l: ph_b_l[12]};
assign lrg_motors[7] = '{p1h: ph_a_h[13], p1l: ph_a_l[13], p2h: ph_b_h[13], p2l: ph_b_l[13]};
assign sml_motors[6] = '{p1h: ph_a_h[14], p1l: ph_a_l[14], p2h: ph_b_h[14], p2l: ph_b_l[14]};
assign sml_motors[7] = '{p1h: ph_a_h[15], p1l: ph_a_l[15], p2h: ph_b_h[15], p2l: ph_b_l[15]};

assign group_en[0] = col_en[0];
assign group_en[1] = col_en[1];
assign group_en[2] = col_en[2];
assign group_en[3] = col_en[3];

/*********************************************************/

assign test_io8 = cmd_alive;
assign test_io7 = resp_prv;
assign test_io6 = cmd_prv;
assign test_io5 = clk_prv_buf;

assign test_io4 = rclk_nxt_buf;
assign test_io3 = resp_nxt;
assign test_io2 = cmd_nxt;
assign test_io1 = tlm_alive;


assign sfw_10 = clk_300k;
assign sfw_3p3 = clk_300k;

assign cs_bypass = ~current_sense;


assign {adc1_addr2, adc1_addr1, adc1_addr0} = adc1_addr;
assign {adc2_addr2, adc2_addr1, adc2_addr0} = adc2_addr;

/*
-these resets are active low but sys_rst is active high, 
    If any of the resets are low, sys_rst = 1
*/
assign sys_rst = ~(reset_prv_fpga & reset_db);

/*********************************************************/

// Power On Reset input buf
CLKBUF por_buffer (
    .PAD(pwr_on_reset),
    .Y(por_rst_buf)
);

// reset_nxt_fpga buffer
BUFD rst_nxt_fpga_buffer (
    .A(reset_prv_fpga),
    .Y(reset_nxt_fpga)
);

// clk_prv buffered, 16 mhz clock for cmdin
CLKBUF clk_prv_buffer (
    .PAD(clk_prv),
    .Y(clk_prv_buf)
);

// rclk_nxt buffered, 16 mhz clock for tlmin
INBUF rclk_nxt_buffer (
    .PAD(rclk_nxt),
    .Y(rclk_nxt_buf)
);

CLKINT rclk_nxt_int (
    .A(rclk_nxt_buf),
    .Y(rclk_nxt_glob)
);

// clk_nxt generated, from 16mhz clock for cmdin
DDR_OUT clk_nxt_bufout (
    .DR(1'b1),
    .DF(1'b0),
    .CLK(clk_prv_buf),
    .CLR(1'b0),
    .Q(clk_nxt)
);

// rclk_prv generated, from 16mhz clock for cmdin
DDR_OUT rclk_prv_bufout (
    .DR(1'b1),
    .DF(1'b0),
    .CLK(clk_prv_buf),
    .CLR(1'b0),
    .Q(rclk_prv)
);


/*********************************************************/


// Power On Reset debouncer 
rst_deb # (
    .IN_FREQ_KHZ(16000),
    .HOLD_TIME_US(20_000)
) por_rst_deb (
    .clkin(clk_prv_buf),
    .rst_n(por_rst_buf),
    .rst_n_deb(reset_db)
);

// Power On Reset debouncer for switching freq
rst_deb # (
    .IN_FREQ_KHZ(16000),
    .HOLD_TIME_US( 4 )
) rst_swf_deb (
    .clkin(clk_prv_buf),
    .rst_n(por_rst_buf),
    .rst_n_deb(swf_rst_n)
);


// 300Khz PSU switch freq gen
clk_counter  #(
    .IN_FREQ_KHZ(16_000),
    .OUT_FREQ_KHZ(300)
) clk_300k_gen (
    .in_clk(clk_prv_buf), 
    .reset( ~swf_rst_n ),
    .out_clk(clk_300k)
);

// 1Mhz clk gen
clk_counter  #(
    .IN_FREQ_KHZ(16_000),
    .OUT_FREQ_KHZ(1_000)
) clk_1m_gen (
    .in_clk(clk_prv_buf), 
    .reset( sys_rst ),
    .out_clk(clk_1m)
);


/*********************************************************/

// Main PFS core
pfs pfs (
    .sin_clock_16mhz(clk_prv_buf),
    .tlmin_clock_16mhz(rclk_nxt_glob),
    .clock_1mhz(clk_1m),
    .reset(sys_rst), 
    .sin(cmd_prv),
    .sout(cmd_nxt),
    
    .ph_a_h(ph_a_h),
    .ph_a_l(ph_a_l),
    .ph_b_h(ph_b_h),
    .ph_b_l(ph_b_l),
    .col_en(col_en),
    
    .current_sense(current_sense),
    
    .cmd_received(cmd_alive),
    .tlm_ready(tlm_alive),
    
    // ADC 1 if
    .adc0_douta(adc1_out_a),
    .adc0_doutb(adc1_out_b),
    .adc0_sclk(adc1_sclk),
    .adc0_addr(adc1_addr),
    .adc0_ncs(adc1_cs),
    .adc0_rng(adc1_range_sel),
    
    // ADC 2 if
    .adc1_douta(adc2_out_a),
    .adc1_doutb(adc2_out_b),
    .adc1_sclk(adc2_sclk),
    .adc1_addr(adc2_addr),
    .adc1_ncs(adc2_cs),
    .adc1_rng(adc2_range_sel),

    .tlm_in(resp_nxt),
    .tlm_out(resp_prv)
);

/*********************************************************/



endmodule

/* vim: set syntax=systemverilog: */
