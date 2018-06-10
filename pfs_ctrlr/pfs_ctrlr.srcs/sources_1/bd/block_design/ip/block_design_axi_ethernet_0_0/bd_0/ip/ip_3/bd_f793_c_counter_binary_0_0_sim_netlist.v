// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Fri Aug 25 11:23:31 2017
// Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
// Command     : write_verilog -force -mode funcsim -rename_top bd_f793_c_counter_binary_0_0 -prefix
//               bd_f793_c_counter_binary_0_0_ bd_f793_c_counter_binary_0_0_sim_netlist.v
// Design      : bd_f793_c_counter_binary_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bd_f793_c_counter_binary_0_0,c_counter_binary_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_10,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module bd_f793_c_counter_binary_0_0
   (CLK,
    SCLR,
    THRESH0,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 thresh0_intf DATA" *) output THRESH0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [23:0]Q;

  wire CLK;
  wire [23:0]Q;
  wire SCLR;
  wire THRESH0;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "24" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1100000000000000000000" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "1100000000000000000000" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  bd_f793_c_counter_binary_0_0_c_counter_binary_v12_0_10 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1100000000000000000000" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "1" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "1" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1100000000000000000000" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "24" *) 
(* C_XDEVICEFAMILY = "kintex7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module bd_f793_c_counter_binary_0_0_c_counter_binary_v12_0_10
   (CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    UP,
    LOAD,
    L,
    THRESH0,
    Q);
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  input UP;
  input LOAD;
  input [23:0]L;
  output THRESH0;
  output [23:0]Q;

  wire CLK;
  wire [23:0]Q;
  wire SCLR;
  wire THRESH0;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "24" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1100000000000000000000" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "1100000000000000000000" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  bd_f793_c_counter_binary_0_0_c_counter_binary_v12_0_10_viv i_synth
       (.CE(1'b0),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
l1NG3g81+vM8a/OECNXckQ6Ih+534PcHu9If3GBzfNiHrQt4ZqWyOCmUfR9HBrKJ6dazleZpBLLQ
VkjiEZOvOw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Z0LH98ijrG2zSKQ428sLNLNN8LOYW53zGTr9NWQ16ZrFJS/8H+Sypz2sLY7sCYpj+gN48UB+J20x
PvOEIxFZVPZNmhrcvIxztIiTduaVtyypOS3Jx8r3YE6fOwVJrfZ9eXRQUIdKvbN0bVZFUcjZ2HOu
2IHyG/UIDoelWrgO0GY=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
QNC1y7mnDIW3BeoEUG5xtIOyuA9VVC6sNeWDOT6S5qoB4e5s9LHwLIGpByH8Fz0PGaafc2Pp1LqC
lzXnevLntdeO+Pz1NMCI4Ojicg8oWhR3msMyGBNzheYZMtUoYnT2zC0eafrxC+G2D8yNbUPHtf++
Y0MP0FYlKg8jJhDSX3w=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bRemsiwW6AApgQWC90BqiBlMFD2jEWM37Ph/oR3/T151pMQpEWD3gu3SGbUebLL6tc97cE/PgSCy
KS0n/kkTjP8yz3D6tbz01kj9QAWvzzWfukcjy4U1p/TuuIIUFcvoH/P+MznfeFrHL11ZwDgOg40p
h2VhrJPIbdfbr6mfhPFTBuWKYDGmQfgZeWyn7BSTLS+wvNUS+AvTJnaPj6O9Szcq/v+sphPqX1F0
wfrQOmRJVSa2EfFZxZ1m3+2NmDfYPFsxF203jiTh4pJ8JuezHfzsaK6jbmB9h7QKD6yMUsYRx/O3
idyz3Inko4ZzfMIyZuEPWm6TSA5xk5DeltwcSw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QxSXl52RB2cLbPW8z4SvG8lZpaZT78HIOf6Q3fEiSBBQziVQn5oJPSJW8PdmH2pB/aVZpPeDnm2a
hpp7ddkUsyA+NHykeuxUJfwhWYhyemZLGnSdZXVpbaOhu0TLJiOtAVsDmRdPFs7q6CpwvvPImbuY
YK29r9Mw8w6ATmDgWgWs+wefEAeKjvUWKQmUr9SKi88H0j+hCCdtMoYZnO8+mjtjWlqm6U7NqCPr
K58IyvSojGlh7czWW8xHzOdgUBj872QexFBFCXAZ3caYI+I5tgzbPak7R4g1nHKG2e2HAjefrx2S
bXb3PhWqaTkKbnVCol5mWJuxPclCBxrEtqSjug==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cz5g65hbB8shmQPsohjzVr+SPRr5lrGQqqziYjnrsCWqDM27xVRVWn5/2voSXHOso9pm8+P7GN+L
Mz6Nn/qXS+pi/muryE2WEZ1r1ya1OKX8h7vIWuyvbtfcgSkvPQb+oNRpZXNONTBmmBFus8k0rin2
VJPxBV5qCpoPGWDVS1QCTJ852TyqzdEMM2h/x7mD8lHifZIkjoWi+O8HkWSf1j2JrYg2fikk0O71
heaF0CkbjGmy7ezg8wpLUywMgWUhCjFFanO1rqzaTEvWYxCjx+FFJRXRyfP3qUeBqMaTvZsGSDDl
/9EG0TehdoOmg4VPXawJiGfiqr2sBbg7f0zlow==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
CJVFj+xHzoAodHcmIDPRzXBPSsLCO3BiDHpy7rQfOKGA9tUuzzaEKcFz2Tj1qtIwUzwIzT4rR4Vq
DFeMxbEgwpNYrZZMsWzP0B0rTgxo+zYFKF3UiQPynX9HYl0G1Fh4b5T+nd+RMzS1MGnHtnnPVda5
mU7Nq2ho+CQqv11f9jxI2oClqBAoGQdgsMGokl05hIni2WOSe9uR6iq3NzMUZ2dhHbUMj9ChCcdT
zOyr4tCB7cS/KpRiapEFfR3iqxTFnUr8pL2eOfQAzni9hTksCC9gblo5wR6pu6O2hPghpSQsgNgk
KdX7tt5I6H9P2nxshLjNsZNYqxQ6BA692Ih+lw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
nd8PAHcNuV4KXknGLLG7jEPLzKkC8ubics29/webcl2ODXvv6gKqdsZXgZIWIFWbkQNM+hdOAMIm
+3QwnR6UyZZJ2Lok/heK0ifJpZxX7saqLBzHdrwa8hTXqzVk1DduqwDSDmkVFhmmodvPRPOU1H7Y
tiNu7zEl/HAOZyOsn5FY/cyuxS64UG7pVLuG01JR52i42kNoXlTNSF0aZuyeZ/ROFrna4mtt1cnk
GkxCU1tebhW7b2M2vYa/zLQUisfujedCE407k10vt1BMi+QvCdAQsywakJIiH8JT797Rqtxsk7ng
3YrtM0Tpda7l8NTPcH0xl4yVz4iLR0LXz0Z/8w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 15392)
`pragma protect data_block
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
OV0Q1/gao1ijuIuLw8kNMYLDkC2iDUhuctOIDCY=
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
