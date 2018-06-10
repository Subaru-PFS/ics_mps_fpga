// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Fri Aug 25 11:22:53 2017
// Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
// Command     : write_verilog -force -mode funcsim -rename_top bd_f793_c_shift_ram_0_0 -prefix
//               bd_f793_c_shift_ram_0_0_ bd_f793_c_shift_ram_0_0_sim_netlist.v
// Design      : bd_f793_c_shift_ram_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bd_f793_c_shift_ram_0_0,c_shift_ram_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_10,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module bd_f793_c_shift_ram_0_0
   (D,
    CLK,
    CE,
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [0:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [0:0]Q;

  wire CE;
  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire SCLR;

  (* C_AINIT_VAL = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "1" *) 
  (* c_addr_width = "4" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  bd_f793_c_shift_ram_0_0_c_shift_ram_v12_0_10 U0
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADDR_WIDTH = "4" *) (* C_AINIT_VAL = "0" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DEPTH = "1" *) (* C_ELABORATION_DIR = "./" *) (* C_HAS_A = "0" *) 
(* C_HAS_CE = "1" *) (* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_OPT_GOAL = "0" *) 
(* C_PARSER_TYPE = "0" *) (* C_READ_MIF = "0" *) (* C_REG_LAST_BIT = "1" *) 
(* C_SHIFT_TYPE = "0" *) (* C_SINIT_VAL = "0" *) (* C_SYNC_ENABLE = "0" *) 
(* C_SYNC_PRIORITY = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "1" *) 
(* C_XDEVICEFAMILY = "kintex7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module bd_f793_c_shift_ram_0_0_c_shift_ram_v12_0_10
   (A,
    D,
    CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [3:0]A;
  input [0:0]D;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  output [0:0]Q;

  wire CE;
  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire SCLR;

  (* C_AINIT_VAL = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "1" *) 
  (* c_addr_width = "4" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  bd_f793_c_shift_ram_0_0_c_shift_ram_v12_0_10_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
ZPVr6gPhgA50m5jEg/cloU5pPzs5ur+MQW36xOcR8MdF8wWaUr8zIKTkcmQ2+yydX1fZ4Dyi3sIY
TpR8Ac269Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
m4q9MtEWGVJ85SvGPq9Dz0jIl7zWLDc7qOxdMPlcTg9T1T9M5FPPiGgkxREX6nE7+9JKkFDwnsA9
8+fSm6Oi0bE3MkKI9FO2ZXM7K+4Rk8vDA92zhdLKaJ34nA7vjScrX2b/LBmzP8q6nQDO40WeaUg8
L807mVHk8Be+E1biF6U=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aatvZnYN0uh5k7QSlNnnB6bvhD3FbME0tc3JI5aMmMGgeBi70uOFdm+jeJ/aiZunLfXWyCxoMCdc
dBKB//l+xg2I91pEyCdzuoUrT048IsBLQwoZokH799mJgNx9daihUGv5ybbWk1i/wA12WcjDOJJC
Er52KQagyjyU7tEBN74=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dJns6s7QA8cdhO4jfiphF7PmkVvVC6Dhh0L6aFNskwPuc6Jos8rWXR3Jsgb9Qh/ak0KSbr9NkeLv
RgWhqRWe6LELfKQmcczmKfG1JTRag1Ex4E/VjixkGn64jC/UtyXNaVM5yfO4VMr/fepoyu097gcT
77pUFtteJrLFft6+LFiCSz1u1409YDqqA4/3ehiUO5JOTCVkxneqaqe+aoE9AvaxJhXMmJbXxuX2
8tKWpWklIhCC6AmEZ6vWD2uWzR5I+9OwtvmDMR4Kdzhy9mgzB/ud3Zwi7GCYMIYw3y7JpPsofCgb
v7QgaSwvHIaUuArSLJSXzaiJo+vv2cUDfF7Kbw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
D2SIfMgicSOsDpsKHm+y5JCS0B9zepyfPIW5qstyEt9dSu53QxJ8dnCG/hq1rHPPNh7Ynj1WE5Vr
omRCeZE+4pAJd56hxgT6gDGsB9CWHv564ekGt+/ni622rk32WJgUuR1+z1V93RmKfyOTETzifJzW
c87TjOtsORPS4hAn8ZDvknAumyZPKMcIx2qqbUG6HkU0plfnmrKVtvmQFuscX/So3RuqQmaVrgEV
NxM86dJR4oU66dzjwOUynRyBsQ6WtLWtBkJ2Q58nTXYozeEQ2np76d0RpZpbLNyp0May2HmzXMGV
nCucai8VYz/d2AjP0bysze55WqGsL+qEO8jKzQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
tMh7AxjNYMBJGMu4nT7+MUezQs9H8HlH2v9U7UVzGDM33uFa169W7t3PYXdwUnixdASrg4Ii+jDe
wcKq5RtvD55ebjKBFk+AJkdG5+4o0RsJmF8MRdgGUjYsu+yc0E70kG7GISyz5If8VZRuf5sfEebp
MAVhUoIklYMjXV0641B+WCQ851H+VAB7G65Z3dPbNwkIDySVa6ZdOY8Mh7SSRTyPs2u1iaLTACcr
cNLUc3i16RbKgf7QG7DMwDeInwsRMlfNO7eZeGEpaTeNPJNGd4TDVZJBkI1mLP8U6MFEOk+3GROr
H6jgeyhRsDgX3tTSgmba6DM90HFy2Y2meS+LLw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
mf8zhFNi34vJwYcVCq0ZOXeT9FD00Yx0UcgN05vANVSd4tPRnMtB3mheddk0KKnIJLfSyxue1AUO
PX9rW9uKURTiKhJKcsx5olivM1ud6kXdFa1rIBTII/Bazs1ip3TQh45GDRE5Rx7A3Xm+DnUzCb3Y
ozP64oidLuy+OBoIYEOW0uEXzA/nPHNcVeuOGkxJJAElqgd56dFlMIC3j38Xf2s0sekYRnENBCL9
SSjJY4tAsShCKwRJ8J3nyqFqZyJAO+RNtaTed66uKsfAuVHVQCNpqFm7vJjRf+/ioq4PYbD0Un1a
bWvByxuKWRvOyRbD2eg5QL9kZLMqbR9AwRgBLQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
JjZnr6cIEcOXBZNFTClkR7RluaGrCtSOXGGSWTX367yYm2X5SD3rkseQTwLAt1hrXtDn/QFNlf7M
1CyHr64QUJx0NrwvSFnbr8Q5OB65fXJIaV38vYYRIsYIJJEZ9Jo+/IWF6oiUiytm4HP2FaxJ1Fy/
GlrwT38eMMogf6O9lFxyfuKVuxGOjik4esAQfmSGzjugBWcBvqfYRS7Tw7wpGyELhLT7kxhPhW1P
3OhUqATv1TXD/3xP6lYYxBxbJ3b5Kj47WNxxg+x5GxHu7gOAcds13DIyReYgKApXzihjELnCy8+t
UAwNIiOkyUyDMBgyZNAYrS3JHTQsD1QizphmZw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 4592)
`pragma protect data_block
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
`pragma protect end_protected
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
