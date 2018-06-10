// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Tue Aug 29 13:47:30 2017
// Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top block_design_clk_wiz_0_0 -prefix
//               block_design_clk_wiz_0_0_ block_design_clk_wiz_0_0_stub.v
// Design      : block_design_clk_wiz_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module block_design_clk_wiz_0_0(clk_eth_gtx, clk_eth_ref, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_eth_gtx,clk_eth_ref,clk_in1" */;
  output clk_eth_gtx;
  output clk_eth_ref;
  input clk_in1;
endmodule
