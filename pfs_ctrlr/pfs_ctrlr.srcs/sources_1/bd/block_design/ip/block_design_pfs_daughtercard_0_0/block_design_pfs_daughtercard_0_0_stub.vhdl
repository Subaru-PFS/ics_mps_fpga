-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Wed Sep  6 18:21:36 2017
-- Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/sources_1/bd/block_design/ip/block_design_pfs_daughtercard_0_0/block_design_pfs_daughtercard_0_0_stub.vhdl
-- Design      : block_design_pfs_daughtercard_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity block_design_pfs_daughtercard_0_0 is
  Port ( 
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    ser_clk : in STD_LOGIC;
    rst_nxt : out STD_LOGIC_VECTOR ( 5 downto 0 );
    cmd_nxt : out STD_LOGIC_VECTOR ( 5 downto 0 );
    clk_nxt : out STD_LOGIC_VECTOR ( 5 downto 0 );
    resp_nxt : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rclk_nxt : in STD_LOGIC_VECTOR ( 5 downto 0 );
    psu_en : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rx_err : out STD_LOGIC_VECTOR ( 5 downto 0 )
  );

end block_design_pfs_daughtercard_0_0;

architecture stub of block_design_pfs_daughtercard_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s00_axi_aclk,s00_axi_aresetn,s00_axi_awaddr[9:0],s00_axi_awvalid,s00_axi_awready,s00_axi_wdata[31:0],s00_axi_wvalid,s00_axi_wready,s00_axi_wstrb[3:0],s00_axi_awprot[2:0],s00_axi_bresp[1:0],s00_axi_bvalid,s00_axi_bready,s00_axi_araddr[9:0],s00_axi_arprot[2:0],s00_axi_arvalid,s00_axi_arready,s00_axi_rdata[31:0],s00_axi_rresp[1:0],s00_axi_rvalid,s00_axi_rready,ser_clk,rst_nxt[5:0],cmd_nxt[5:0],clk_nxt[5:0],resp_nxt[5:0],rclk_nxt[5:0],psu_en[5:0],rx_err[5:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "pfs_daughtercard,Vivado 2017.2";
begin
end;
