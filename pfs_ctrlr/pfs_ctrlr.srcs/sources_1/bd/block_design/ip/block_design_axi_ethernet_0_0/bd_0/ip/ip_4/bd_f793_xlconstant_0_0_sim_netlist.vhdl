-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Fri Aug 25 11:20:40 2017
-- Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top bd_f793_xlconstant_0_0 -prefix
--               bd_f793_xlconstant_0_0_ bd_f793_xlconstant_0_0_sim_netlist.vhdl
-- Design      : bd_f793_xlconstant_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_f793_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of bd_f793_xlconstant_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of bd_f793_xlconstant_0_0 : entity is "bd_f793_xlconstant_0_0,xlconstant_v1_1_3_xlconstant,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of bd_f793_xlconstant_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of bd_f793_xlconstant_0_0 : entity is "xlconstant_v1_1_3_xlconstant,Vivado 2017.2";
end bd_f793_xlconstant_0_0;

architecture STRUCTURE of bd_f793_xlconstant_0_0 is
  signal \<const1>\ : STD_LOGIC;
begin
  dout(0) <= \<const1>\;
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
end STRUCTURE;
