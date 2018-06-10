// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Tue Sep  5 19:19:29 2017
// Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
// Command     : write_verilog -force -mode funcsim -rename_top block_design_simple_ip_0_0 -prefix
//               block_design_simple_ip_0_0_ block_design_simple_ip_0_0_sim_netlist.v
// Design      : block_design_simple_ip_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "block_design_simple_ip_0_0,simple_ip,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "simple_ip,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module block_design_simple_ip_0_0
   (s00_axi_aclk,
    s00_axi_aresetn,
    s00_axi_awaddr,
    s00_axi_awprot,
    s00_axi_awvalid,
    s00_axi_awready,
    s00_axi_wdata,
    s00_axi_wvalid,
    s00_axi_wready,
    s00_axi_wstrb,
    s00_axi_bresp,
    s00_axi_bvalid,
    s00_axi_bready,
    s00_axi_araddr,
    s00_axi_arprot,
    s00_axi_arvalid,
    s00_axi_arready,
    s00_axi_rdata,
    s00_axi_rresp,
    s00_axi_rvalid,
    s00_axi_rready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s00_axi_aclk CLK" *) input s00_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s00_axi_aresetn RST" *) input s00_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWADDR" *) input [9:0]s00_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWPROT" *) input [2:0]s00_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWVALID" *) input s00_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWREADY" *) output s00_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WDATA" *) input [31:0]s00_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WVALID" *) input s00_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WREADY" *) output s00_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WSTRB" *) input [3:0]s00_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi BRESP" *) output [1:0]s00_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi BVALID" *) output s00_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi BREADY" *) input s00_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARADDR" *) input [9:0]s00_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARPROT" *) input [2:0]s00_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARVALID" *) input s00_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARREADY" *) output s00_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RDATA" *) output [31:0]s00_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RRESP" *) output [1:0]s00_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RVALID" *) output s00_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RREADY" *) input s00_axi_rready;

  wire \<const0> ;
  wire s00_axi_aclk;
  wire [9:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wvalid;

  assign s00_axi_bresp[1] = \<const0> ;
  assign s00_axi_bresp[0] = \<const0> ;
  assign s00_axi_bvalid = s00_axi_awready;
  assign s00_axi_rresp[1] = \<const0> ;
  assign s00_axi_rresp[0] = \<const0> ;
  assign s00_axi_wready = s00_axi_awready;
  GND GND
       (.G(\<const0> ));
  block_design_simple_ip_0_0_simple_ip inst
       (.s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr[3:0]),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arready(s00_axi_arready),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awready(s00_axi_awready),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wvalid(s00_axi_wvalid));
endmodule

module block_design_simple_ip_0_0_simple_ip
   (s00_axi_arready,
    s00_axi_rdata,
    s00_axi_awready,
    s00_axi_rvalid,
    s00_axi_arvalid,
    s00_axi_bready,
    s00_axi_awvalid,
    s00_axi_wvalid,
    s00_axi_aclk,
    s00_axi_araddr,
    s00_axi_wdata,
    s00_axi_rready,
    s00_axi_aresetn);
  output s00_axi_arready;
  output [31:0]s00_axi_rdata;
  output s00_axi_awready;
  output s00_axi_rvalid;
  input s00_axi_arvalid;
  input s00_axi_bready;
  input s00_axi_awvalid;
  input s00_axi_wvalid;
  input s00_axi_aclk;
  input [3:0]s00_axi_araddr;
  input [31:0]s00_axi_wdata;
  input s00_axi_rready;
  input s00_axi_aresetn;

  wire arready_i_1_n_0;
  wire awready0__0;
  wire [3:0]rd_addr;
  wire \rd_addr[3]_i_1_n_0 ;
  wire [31:1]rd_data1;
  wire rd_data1_carry__0_i_1_n_0;
  wire rd_data1_carry__0_i_2_n_0;
  wire rd_data1_carry__0_i_3_n_0;
  wire rd_data1_carry__0_i_4_n_0;
  wire rd_data1_carry__0_n_0;
  wire rd_data1_carry__0_n_1;
  wire rd_data1_carry__0_n_2;
  wire rd_data1_carry__0_n_3;
  wire rd_data1_carry__1_i_1_n_0;
  wire rd_data1_carry__1_i_2_n_0;
  wire rd_data1_carry__1_i_3_n_0;
  wire rd_data1_carry__1_i_4_n_0;
  wire rd_data1_carry__1_n_0;
  wire rd_data1_carry__1_n_1;
  wire rd_data1_carry__1_n_2;
  wire rd_data1_carry__1_n_3;
  wire rd_data1_carry__2_i_1_n_0;
  wire rd_data1_carry__2_i_2_n_0;
  wire rd_data1_carry__2_i_3_n_0;
  wire rd_data1_carry__2_i_4_n_0;
  wire rd_data1_carry__2_n_0;
  wire rd_data1_carry__2_n_1;
  wire rd_data1_carry__2_n_2;
  wire rd_data1_carry__2_n_3;
  wire rd_data1_carry__3_i_1_n_0;
  wire rd_data1_carry__3_i_2_n_0;
  wire rd_data1_carry__3_i_3_n_0;
  wire rd_data1_carry__3_i_4_n_0;
  wire rd_data1_carry__3_n_0;
  wire rd_data1_carry__3_n_1;
  wire rd_data1_carry__3_n_2;
  wire rd_data1_carry__3_n_3;
  wire rd_data1_carry__4_i_1_n_0;
  wire rd_data1_carry__4_i_2_n_0;
  wire rd_data1_carry__4_i_3_n_0;
  wire rd_data1_carry__4_i_4_n_0;
  wire rd_data1_carry__4_n_0;
  wire rd_data1_carry__4_n_1;
  wire rd_data1_carry__4_n_2;
  wire rd_data1_carry__4_n_3;
  wire rd_data1_carry__5_i_1_n_0;
  wire rd_data1_carry__5_i_2_n_0;
  wire rd_data1_carry__5_i_3_n_0;
  wire rd_data1_carry__5_i_4_n_0;
  wire rd_data1_carry__5_n_0;
  wire rd_data1_carry__5_n_1;
  wire rd_data1_carry__5_n_2;
  wire rd_data1_carry__5_n_3;
  wire rd_data1_carry__6_i_1_n_0;
  wire rd_data1_carry__6_i_2_n_0;
  wire rd_data1_carry__6_i_3_n_0;
  wire rd_data1_carry__6_n_2;
  wire rd_data1_carry__6_n_3;
  wire rd_data1_carry_i_1_n_0;
  wire rd_data1_carry_i_2_n_0;
  wire rd_data1_carry_i_3_n_0;
  wire rd_data1_carry_i_4_n_0;
  wire rd_data1_carry_n_0;
  wire rd_data1_carry_n_1;
  wire rd_data1_carry_n_2;
  wire rd_data1_carry_n_3;
  wire \rd_data[0]_i_1_n_0 ;
  wire \rd_data[10]_i_1_n_0 ;
  wire \rd_data[11]_i_1_n_0 ;
  wire \rd_data[12]_i_1_n_0 ;
  wire \rd_data[13]_i_1_n_0 ;
  wire \rd_data[14]_i_1_n_0 ;
  wire \rd_data[15]_i_1_n_0 ;
  wire \rd_data[16]_i_1_n_0 ;
  wire \rd_data[17]_i_1_n_0 ;
  wire \rd_data[18]_i_1_n_0 ;
  wire \rd_data[19]_i_1_n_0 ;
  wire \rd_data[1]_i_1_n_0 ;
  wire \rd_data[20]_i_1_n_0 ;
  wire \rd_data[21]_i_1_n_0 ;
  wire \rd_data[22]_i_1_n_0 ;
  wire \rd_data[23]_i_1_n_0 ;
  wire \rd_data[24]_i_1_n_0 ;
  wire \rd_data[25]_i_1_n_0 ;
  wire \rd_data[26]_i_1_n_0 ;
  wire \rd_data[27]_i_1_n_0 ;
  wire \rd_data[28]_i_1_n_0 ;
  wire \rd_data[29]_i_1_n_0 ;
  wire \rd_data[2]_i_1_n_0 ;
  wire \rd_data[30]_i_1_n_0 ;
  wire \rd_data[31]_i_1_n_0 ;
  wire \rd_data[3]_i_1_n_0 ;
  wire \rd_data[4]_i_1_n_0 ;
  wire \rd_data[5]_i_1_n_0 ;
  wire \rd_data[6]_i_1_n_0 ;
  wire \rd_data[7]_i_1_n_0 ;
  wire \rd_data[8]_i_1_n_0 ;
  wire \rd_data[9]_i_1_n_0 ;
  wire rvalid_i_1_n_0;
  wire s00_axi_aclk;
  wire [3:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wvalid;
  wire [31:0]wr_word;
  wire [3:2]NLW_rd_data1_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_rd_data1_carry__6_O_UNCONNECTED;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h40)) 
    arready_i_1
       (.I0(s00_axi_arready),
        .I1(s00_axi_arvalid),
        .I2(s00_axi_aresetn),
        .O(arready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    arready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(arready_i_1_n_0),
        .Q(s00_axi_arready),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h2000)) 
    awready0
       (.I0(s00_axi_bready),
        .I1(s00_axi_awready),
        .I2(s00_axi_awvalid),
        .I3(s00_axi_wvalid),
        .O(awready0__0));
  FDRE #(
    .INIT(1'b0)) 
    awready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(awready0__0),
        .Q(s00_axi_awready),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    \rd_addr[3]_i_1 
       (.I0(s00_axi_arvalid),
        .I1(s00_axi_arready),
        .O(\rd_addr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rd_addr_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\rd_addr[3]_i_1_n_0 ),
        .D(s00_axi_araddr[0]),
        .Q(rd_addr[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_addr_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\rd_addr[3]_i_1_n_0 ),
        .D(s00_axi_araddr[1]),
        .Q(rd_addr[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_addr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\rd_addr[3]_i_1_n_0 ),
        .D(s00_axi_araddr[2]),
        .Q(rd_addr[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_addr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\rd_addr[3]_i_1_n_0 ),
        .D(s00_axi_araddr[3]),
        .Q(rd_addr[3]),
        .R(1'b0));
  CARRY4 rd_data1_carry
       (.CI(1'b0),
        .CO({rd_data1_carry_n_0,rd_data1_carry_n_1,rd_data1_carry_n_2,rd_data1_carry_n_3}),
        .CYINIT(s00_axi_rdata[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(rd_data1[4:1]),
        .S({rd_data1_carry_i_1_n_0,rd_data1_carry_i_2_n_0,rd_data1_carry_i_3_n_0,rd_data1_carry_i_4_n_0}));
  CARRY4 rd_data1_carry__0
       (.CI(rd_data1_carry_n_0),
        .CO({rd_data1_carry__0_n_0,rd_data1_carry__0_n_1,rd_data1_carry__0_n_2,rd_data1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(rd_data1[8:5]),
        .S({rd_data1_carry__0_i_1_n_0,rd_data1_carry__0_i_2_n_0,rd_data1_carry__0_i_3_n_0,rd_data1_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__0_i_1
       (.I0(s00_axi_rdata[8]),
        .O(rd_data1_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__0_i_2
       (.I0(s00_axi_rdata[7]),
        .O(rd_data1_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__0_i_3
       (.I0(s00_axi_rdata[6]),
        .O(rd_data1_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__0_i_4
       (.I0(s00_axi_rdata[5]),
        .O(rd_data1_carry__0_i_4_n_0));
  CARRY4 rd_data1_carry__1
       (.CI(rd_data1_carry__0_n_0),
        .CO({rd_data1_carry__1_n_0,rd_data1_carry__1_n_1,rd_data1_carry__1_n_2,rd_data1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(rd_data1[12:9]),
        .S({rd_data1_carry__1_i_1_n_0,rd_data1_carry__1_i_2_n_0,rd_data1_carry__1_i_3_n_0,rd_data1_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__1_i_1
       (.I0(s00_axi_rdata[12]),
        .O(rd_data1_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__1_i_2
       (.I0(s00_axi_rdata[11]),
        .O(rd_data1_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__1_i_3
       (.I0(s00_axi_rdata[10]),
        .O(rd_data1_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__1_i_4
       (.I0(s00_axi_rdata[9]),
        .O(rd_data1_carry__1_i_4_n_0));
  CARRY4 rd_data1_carry__2
       (.CI(rd_data1_carry__1_n_0),
        .CO({rd_data1_carry__2_n_0,rd_data1_carry__2_n_1,rd_data1_carry__2_n_2,rd_data1_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(rd_data1[16:13]),
        .S({rd_data1_carry__2_i_1_n_0,rd_data1_carry__2_i_2_n_0,rd_data1_carry__2_i_3_n_0,rd_data1_carry__2_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__2_i_1
       (.I0(s00_axi_rdata[16]),
        .O(rd_data1_carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__2_i_2
       (.I0(s00_axi_rdata[15]),
        .O(rd_data1_carry__2_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__2_i_3
       (.I0(s00_axi_rdata[14]),
        .O(rd_data1_carry__2_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__2_i_4
       (.I0(s00_axi_rdata[13]),
        .O(rd_data1_carry__2_i_4_n_0));
  CARRY4 rd_data1_carry__3
       (.CI(rd_data1_carry__2_n_0),
        .CO({rd_data1_carry__3_n_0,rd_data1_carry__3_n_1,rd_data1_carry__3_n_2,rd_data1_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(rd_data1[20:17]),
        .S({rd_data1_carry__3_i_1_n_0,rd_data1_carry__3_i_2_n_0,rd_data1_carry__3_i_3_n_0,rd_data1_carry__3_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__3_i_1
       (.I0(s00_axi_rdata[20]),
        .O(rd_data1_carry__3_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__3_i_2
       (.I0(s00_axi_rdata[19]),
        .O(rd_data1_carry__3_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__3_i_3
       (.I0(s00_axi_rdata[18]),
        .O(rd_data1_carry__3_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__3_i_4
       (.I0(s00_axi_rdata[17]),
        .O(rd_data1_carry__3_i_4_n_0));
  CARRY4 rd_data1_carry__4
       (.CI(rd_data1_carry__3_n_0),
        .CO({rd_data1_carry__4_n_0,rd_data1_carry__4_n_1,rd_data1_carry__4_n_2,rd_data1_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(rd_data1[24:21]),
        .S({rd_data1_carry__4_i_1_n_0,rd_data1_carry__4_i_2_n_0,rd_data1_carry__4_i_3_n_0,rd_data1_carry__4_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__4_i_1
       (.I0(s00_axi_rdata[24]),
        .O(rd_data1_carry__4_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__4_i_2
       (.I0(s00_axi_rdata[23]),
        .O(rd_data1_carry__4_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__4_i_3
       (.I0(s00_axi_rdata[22]),
        .O(rd_data1_carry__4_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__4_i_4
       (.I0(s00_axi_rdata[21]),
        .O(rd_data1_carry__4_i_4_n_0));
  CARRY4 rd_data1_carry__5
       (.CI(rd_data1_carry__4_n_0),
        .CO({rd_data1_carry__5_n_0,rd_data1_carry__5_n_1,rd_data1_carry__5_n_2,rd_data1_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(rd_data1[28:25]),
        .S({rd_data1_carry__5_i_1_n_0,rd_data1_carry__5_i_2_n_0,rd_data1_carry__5_i_3_n_0,rd_data1_carry__5_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__5_i_1
       (.I0(s00_axi_rdata[28]),
        .O(rd_data1_carry__5_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__5_i_2
       (.I0(s00_axi_rdata[27]),
        .O(rd_data1_carry__5_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__5_i_3
       (.I0(s00_axi_rdata[26]),
        .O(rd_data1_carry__5_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__5_i_4
       (.I0(s00_axi_rdata[25]),
        .O(rd_data1_carry__5_i_4_n_0));
  CARRY4 rd_data1_carry__6
       (.CI(rd_data1_carry__5_n_0),
        .CO({NLW_rd_data1_carry__6_CO_UNCONNECTED[3:2],rd_data1_carry__6_n_2,rd_data1_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_rd_data1_carry__6_O_UNCONNECTED[3],rd_data1[31:29]}),
        .S({1'b0,rd_data1_carry__6_i_1_n_0,rd_data1_carry__6_i_2_n_0,rd_data1_carry__6_i_3_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__6_i_1
       (.I0(s00_axi_rdata[31]),
        .O(rd_data1_carry__6_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__6_i_2
       (.I0(s00_axi_rdata[30]),
        .O(rd_data1_carry__6_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry__6_i_3
       (.I0(s00_axi_rdata[29]),
        .O(rd_data1_carry__6_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry_i_1
       (.I0(s00_axi_rdata[4]),
        .O(rd_data1_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry_i_2
       (.I0(s00_axi_rdata[3]),
        .O(rd_data1_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry_i_3
       (.I0(s00_axi_rdata[2]),
        .O(rd_data1_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    rd_data1_carry_i_4
       (.I0(s00_axi_rdata[1]),
        .O(rd_data1_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000001)) 
    \rd_data[0]_i_1 
       (.I0(s00_axi_rdata[0]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[0]),
        .O(\rd_data[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[10]_i_1 
       (.I0(rd_data1[10]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[10]),
        .O(\rd_data[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[11]_i_1 
       (.I0(rd_data1[11]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[11]),
        .O(\rd_data[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[12]_i_1 
       (.I0(rd_data1[12]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[12]),
        .O(\rd_data[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[13]_i_1 
       (.I0(rd_data1[13]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[13]),
        .O(\rd_data[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[14]_i_1 
       (.I0(rd_data1[14]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[14]),
        .O(\rd_data[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[15]_i_1 
       (.I0(rd_data1[15]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[15]),
        .O(\rd_data[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[16]_i_1 
       (.I0(rd_data1[16]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[16]),
        .O(\rd_data[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[17]_i_1 
       (.I0(rd_data1[17]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[17]),
        .O(\rd_data[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[18]_i_1 
       (.I0(rd_data1[18]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[18]),
        .O(\rd_data[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[19]_i_1 
       (.I0(rd_data1[19]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[19]),
        .O(\rd_data[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[1]_i_1 
       (.I0(rd_data1[1]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[1]),
        .O(\rd_data[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[20]_i_1 
       (.I0(rd_data1[20]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[20]),
        .O(\rd_data[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[21]_i_1 
       (.I0(rd_data1[21]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[21]),
        .O(\rd_data[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[22]_i_1 
       (.I0(rd_data1[22]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[22]),
        .O(\rd_data[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[23]_i_1 
       (.I0(rd_data1[23]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[23]),
        .O(\rd_data[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[24]_i_1 
       (.I0(rd_data1[24]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[24]),
        .O(\rd_data[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[25]_i_1 
       (.I0(rd_data1[25]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[25]),
        .O(\rd_data[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[26]_i_1 
       (.I0(rd_data1[26]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[26]),
        .O(\rd_data[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[27]_i_1 
       (.I0(rd_data1[27]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[27]),
        .O(\rd_data[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[28]_i_1 
       (.I0(rd_data1[28]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[28]),
        .O(\rd_data[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[29]_i_1 
       (.I0(rd_data1[29]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[29]),
        .O(\rd_data[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[2]_i_1 
       (.I0(rd_data1[2]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[2]),
        .O(\rd_data[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[30]_i_1 
       (.I0(rd_data1[30]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[30]),
        .O(\rd_data[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[31]_i_1 
       (.I0(rd_data1[31]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[31]),
        .O(\rd_data[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[3]_i_1 
       (.I0(rd_data1[3]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[3]),
        .O(\rd_data[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[4]_i_1 
       (.I0(rd_data1[4]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[4]),
        .O(\rd_data[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[5]_i_1 
       (.I0(rd_data1[5]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[5]),
        .O(\rd_data[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[6]_i_1 
       (.I0(rd_data1[6]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[6]),
        .O(\rd_data[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[7]_i_1 
       (.I0(rd_data1[7]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[7]),
        .O(\rd_data[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[8]_i_1 
       (.I0(rd_data1[8]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[8]),
        .O(\rd_data[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \rd_data[9]_i_1 
       (.I0(rd_data1[9]),
        .I1(rd_addr[1]),
        .I2(rd_addr[0]),
        .I3(rd_addr[3]),
        .I4(rd_addr[2]),
        .I5(wr_word[9]),
        .O(\rd_data[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[0] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[0]_i_1_n_0 ),
        .Q(s00_axi_rdata[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[10] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[10]_i_1_n_0 ),
        .Q(s00_axi_rdata[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[11] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[11]_i_1_n_0 ),
        .Q(s00_axi_rdata[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[12] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[12]_i_1_n_0 ),
        .Q(s00_axi_rdata[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[13] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[13]_i_1_n_0 ),
        .Q(s00_axi_rdata[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[14] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[14]_i_1_n_0 ),
        .Q(s00_axi_rdata[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[15] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[15]_i_1_n_0 ),
        .Q(s00_axi_rdata[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[16] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[16]_i_1_n_0 ),
        .Q(s00_axi_rdata[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[17] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[17]_i_1_n_0 ),
        .Q(s00_axi_rdata[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[18] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[18]_i_1_n_0 ),
        .Q(s00_axi_rdata[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[19] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[19]_i_1_n_0 ),
        .Q(s00_axi_rdata[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[1] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[1]_i_1_n_0 ),
        .Q(s00_axi_rdata[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[20] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[20]_i_1_n_0 ),
        .Q(s00_axi_rdata[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[21] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[21]_i_1_n_0 ),
        .Q(s00_axi_rdata[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[22] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[22]_i_1_n_0 ),
        .Q(s00_axi_rdata[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[23] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[23]_i_1_n_0 ),
        .Q(s00_axi_rdata[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[24] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[24]_i_1_n_0 ),
        .Q(s00_axi_rdata[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[25] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[25]_i_1_n_0 ),
        .Q(s00_axi_rdata[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[26] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[26]_i_1_n_0 ),
        .Q(s00_axi_rdata[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[27] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[27]_i_1_n_0 ),
        .Q(s00_axi_rdata[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[28] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[28]_i_1_n_0 ),
        .Q(s00_axi_rdata[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[29] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[29]_i_1_n_0 ),
        .Q(s00_axi_rdata[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[2] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[2]_i_1_n_0 ),
        .Q(s00_axi_rdata[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[30] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[30]_i_1_n_0 ),
        .Q(s00_axi_rdata[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rd_data_reg[31] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[31]_i_1_n_0 ),
        .Q(s00_axi_rdata[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[3] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[3]_i_1_n_0 ),
        .Q(s00_axi_rdata[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[4] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[4]_i_1_n_0 ),
        .Q(s00_axi_rdata[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[5] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[5]_i_1_n_0 ),
        .Q(s00_axi_rdata[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[6] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[6]_i_1_n_0 ),
        .Q(s00_axi_rdata[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[7] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[7]_i_1_n_0 ),
        .Q(s00_axi_rdata[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[8] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[8]_i_1_n_0 ),
        .Q(s00_axi_rdata[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[9] 
       (.C(s00_axi_aclk),
        .CE(s00_axi_arready),
        .D(\rd_data[9]_i_1_n_0 ),
        .Q(s00_axi_rdata[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hF200)) 
    rvalid_i_1
       (.I0(s00_axi_rvalid),
        .I1(s00_axi_rready),
        .I2(s00_axi_arready),
        .I3(s00_axi_aresetn),
        .O(rvalid_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    rvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(rvalid_i_1_n_0),
        .Q(s00_axi_rvalid),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[0] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[0]),
        .Q(wr_word[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[10] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[10]),
        .Q(wr_word[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[11] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[11]),
        .Q(wr_word[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[12] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[12]),
        .Q(wr_word[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[13] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[13]),
        .Q(wr_word[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[14] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[14]),
        .Q(wr_word[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[15] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[15]),
        .Q(wr_word[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[16] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[16]),
        .Q(wr_word[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[17] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[17]),
        .Q(wr_word[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[18] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[18]),
        .Q(wr_word[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[19] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[19]),
        .Q(wr_word[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[1] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[1]),
        .Q(wr_word[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[20] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[20]),
        .Q(wr_word[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[21] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[21]),
        .Q(wr_word[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[22] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[22]),
        .Q(wr_word[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[23] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[23]),
        .Q(wr_word[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[24] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[24]),
        .Q(wr_word[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[25] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[25]),
        .Q(wr_word[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[26] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[26]),
        .Q(wr_word[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[27] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[27]),
        .Q(wr_word[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[28] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[28]),
        .Q(wr_word[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[29] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[29]),
        .Q(wr_word[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[2] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[2]),
        .Q(wr_word[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[30] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[30]),
        .Q(wr_word[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[31] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[31]),
        .Q(wr_word[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[3] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[3]),
        .Q(wr_word[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[4] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[4]),
        .Q(wr_word[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[5] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[5]),
        .Q(wr_word[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[6] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[6]),
        .Q(wr_word[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[7] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[7]),
        .Q(wr_word[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[8] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[8]),
        .Q(wr_word[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_word_reg[9] 
       (.C(s00_axi_aclk),
        .CE(awready0__0),
        .D(s00_axi_wdata[9]),
        .Q(wr_word[9]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
