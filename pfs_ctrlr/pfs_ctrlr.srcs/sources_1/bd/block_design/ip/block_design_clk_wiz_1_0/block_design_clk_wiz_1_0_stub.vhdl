-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Aug 29 13:47:30 2017
-- Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top block_design_clk_wiz_1_0 -prefix
--               block_design_clk_wiz_1_0_ block_design_clk_wiz_1_0_stub.vhdl
-- Design      : block_design_clk_wiz_1_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity block_design_clk_wiz_1_0 is
  Port ( 
    pfs_ser_clk : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end block_design_clk_wiz_1_0;

architecture stub of block_design_clk_wiz_1_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "pfs_ser_clk,clk_in1";
begin
end;
