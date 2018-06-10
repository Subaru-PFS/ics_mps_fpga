// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Wed Sep  6 18:21:36 2017
// Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/sources_1/bd/block_design/ip/block_design_pfs_daughtercard_0_0/block_design_pfs_daughtercard_0_0_stub.v
// Design      : block_design_pfs_daughtercard_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "pfs_daughtercard,Vivado 2017.2" *)
module block_design_pfs_daughtercard_0_0(s00_axi_aclk, s00_axi_aresetn, 
  s00_axi_awaddr, s00_axi_awvalid, s00_axi_awready, s00_axi_wdata, s00_axi_wvalid, 
  s00_axi_wready, s00_axi_wstrb, s00_axi_awprot, s00_axi_bresp, s00_axi_bvalid, 
  s00_axi_bready, s00_axi_araddr, s00_axi_arprot, s00_axi_arvalid, s00_axi_arready, 
  s00_axi_rdata, s00_axi_rresp, s00_axi_rvalid, s00_axi_rready, ser_clk, rst_nxt, cmd_nxt, 
  clk_nxt, resp_nxt, rclk_nxt, psu_en, rx_err)
/* synthesis syn_black_box black_box_pad_pin="s00_axi_aclk,s00_axi_aresetn,s00_axi_awaddr[9:0],s00_axi_awvalid,s00_axi_awready,s00_axi_wdata[31:0],s00_axi_wvalid,s00_axi_wready,s00_axi_wstrb[3:0],s00_axi_awprot[2:0],s00_axi_bresp[1:0],s00_axi_bvalid,s00_axi_bready,s00_axi_araddr[9:0],s00_axi_arprot[2:0],s00_axi_arvalid,s00_axi_arready,s00_axi_rdata[31:0],s00_axi_rresp[1:0],s00_axi_rvalid,s00_axi_rready,ser_clk,rst_nxt[5:0],cmd_nxt[5:0],clk_nxt[5:0],resp_nxt[5:0],rclk_nxt[5:0],psu_en[5:0],rx_err[5:0]" */;
  input s00_axi_aclk;
  input s00_axi_aresetn;
  input [9:0]s00_axi_awaddr;
  input s00_axi_awvalid;
  output s00_axi_awready;
  input [31:0]s00_axi_wdata;
  input s00_axi_wvalid;
  output s00_axi_wready;
  input [3:0]s00_axi_wstrb;
  input [2:0]s00_axi_awprot;
  output [1:0]s00_axi_bresp;
  output s00_axi_bvalid;
  input s00_axi_bready;
  input [9:0]s00_axi_araddr;
  input [2:0]s00_axi_arprot;
  input s00_axi_arvalid;
  output s00_axi_arready;
  output [31:0]s00_axi_rdata;
  output [1:0]s00_axi_rresp;
  output s00_axi_rvalid;
  input s00_axi_rready;
  input ser_clk;
  output [5:0]rst_nxt;
  output [5:0]cmd_nxt;
  output [5:0]clk_nxt;
  input [5:0]resp_nxt;
  input [5:0]rclk_nxt;
  output [5:0]psu_en;
  output [5:0]rx_err;
endmodule
