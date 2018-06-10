-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Sep  5 19:19:30 2017
-- Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top block_design_simple_ip_0_0 -prefix
--               block_design_simple_ip_0_0_ block_design_simple_ip_0_0_sim_netlist.vhdl
-- Design      : block_design_simple_ip_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity block_design_simple_ip_0_0_simple_ip is
  port (
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_awready : out STD_LOGIC;
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rready : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC
  );
end block_design_simple_ip_0_0_simple_ip;

architecture STRUCTURE of block_design_simple_ip_0_0_simple_ip is
  signal arready_i_1_n_0 : STD_LOGIC;
  signal \awready0__0\ : STD_LOGIC;
  signal rd_addr : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \rd_addr[3]_i_1_n_0\ : STD_LOGIC;
  signal rd_data1 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \rd_data1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__0_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__0_n_1\ : STD_LOGIC;
  signal \rd_data1_carry__0_n_2\ : STD_LOGIC;
  signal \rd_data1_carry__0_n_3\ : STD_LOGIC;
  signal \rd_data1_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__1_n_1\ : STD_LOGIC;
  signal \rd_data1_carry__1_n_2\ : STD_LOGIC;
  signal \rd_data1_carry__1_n_3\ : STD_LOGIC;
  signal \rd_data1_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__2_n_1\ : STD_LOGIC;
  signal \rd_data1_carry__2_n_2\ : STD_LOGIC;
  signal \rd_data1_carry__2_n_3\ : STD_LOGIC;
  signal \rd_data1_carry__3_i_1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__3_i_2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__3_i_3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__3_i_4_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__3_n_1\ : STD_LOGIC;
  signal \rd_data1_carry__3_n_2\ : STD_LOGIC;
  signal \rd_data1_carry__3_n_3\ : STD_LOGIC;
  signal \rd_data1_carry__4_i_1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__4_i_2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__4_i_3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__4_i_4_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__4_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__4_n_1\ : STD_LOGIC;
  signal \rd_data1_carry__4_n_2\ : STD_LOGIC;
  signal \rd_data1_carry__4_n_3\ : STD_LOGIC;
  signal \rd_data1_carry__5_i_1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__5_i_2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__5_i_3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__5_i_4_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__5_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__5_n_1\ : STD_LOGIC;
  signal \rd_data1_carry__5_n_2\ : STD_LOGIC;
  signal \rd_data1_carry__5_n_3\ : STD_LOGIC;
  signal \rd_data1_carry__6_i_1_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__6_i_2_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__6_i_3_n_0\ : STD_LOGIC;
  signal \rd_data1_carry__6_n_2\ : STD_LOGIC;
  signal \rd_data1_carry__6_n_3\ : STD_LOGIC;
  signal rd_data1_carry_i_1_n_0 : STD_LOGIC;
  signal rd_data1_carry_i_2_n_0 : STD_LOGIC;
  signal rd_data1_carry_i_3_n_0 : STD_LOGIC;
  signal rd_data1_carry_i_4_n_0 : STD_LOGIC;
  signal rd_data1_carry_n_0 : STD_LOGIC;
  signal rd_data1_carry_n_1 : STD_LOGIC;
  signal rd_data1_carry_n_2 : STD_LOGIC;
  signal rd_data1_carry_n_3 : STD_LOGIC;
  signal \rd_data[0]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[10]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[11]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[12]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[13]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[14]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[15]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[16]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[17]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[18]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[19]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[1]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[20]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[21]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[22]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[23]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[24]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[25]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[26]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[27]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[28]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[29]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[2]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[30]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[31]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[3]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[4]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[5]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[6]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[8]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[9]_i_1_n_0\ : STD_LOGIC;
  signal rvalid_i_1_n_0 : STD_LOGIC;
  signal \^s00_axi_arready\ : STD_LOGIC;
  signal \^s00_axi_awready\ : STD_LOGIC;
  signal \^s00_axi_rdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^s00_axi_rvalid\ : STD_LOGIC;
  signal wr_word : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_rd_data1_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_rd_data1_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of arready_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of rvalid_i_1 : label is "soft_lutpair0";
begin
  s00_axi_arready <= \^s00_axi_arready\;
  s00_axi_awready <= \^s00_axi_awready\;
  s00_axi_rdata(31 downto 0) <= \^s00_axi_rdata\(31 downto 0);
  s00_axi_rvalid <= \^s00_axi_rvalid\;
arready_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \^s00_axi_arready\,
      I1 => s00_axi_arvalid,
      I2 => s00_axi_aresetn,
      O => arready_i_1_n_0
    );
arready_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => arready_i_1_n_0,
      Q => \^s00_axi_arready\,
      R => '0'
    );
awready0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2000"
    )
        port map (
      I0 => s00_axi_bready,
      I1 => \^s00_axi_awready\,
      I2 => s00_axi_awvalid,
      I3 => s00_axi_wvalid,
      O => \awready0__0\
    );
awready_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \awready0__0\,
      Q => \^s00_axi_awready\,
      R => '0'
    );
\rd_addr[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^s00_axi_arready\,
      O => \rd_addr[3]_i_1_n_0\
    );
\rd_addr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \rd_addr[3]_i_1_n_0\,
      D => s00_axi_araddr(0),
      Q => rd_addr(0),
      R => '0'
    );
\rd_addr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \rd_addr[3]_i_1_n_0\,
      D => s00_axi_araddr(1),
      Q => rd_addr(1),
      R => '0'
    );
\rd_addr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \rd_addr[3]_i_1_n_0\,
      D => s00_axi_araddr(2),
      Q => rd_addr(2),
      R => '0'
    );
\rd_addr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \rd_addr[3]_i_1_n_0\,
      D => s00_axi_araddr(3),
      Q => rd_addr(3),
      R => '0'
    );
rd_data1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => rd_data1_carry_n_0,
      CO(2) => rd_data1_carry_n_1,
      CO(1) => rd_data1_carry_n_2,
      CO(0) => rd_data1_carry_n_3,
      CYINIT => \^s00_axi_rdata\(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => rd_data1(4 downto 1),
      S(3) => rd_data1_carry_i_1_n_0,
      S(2) => rd_data1_carry_i_2_n_0,
      S(1) => rd_data1_carry_i_3_n_0,
      S(0) => rd_data1_carry_i_4_n_0
    );
\rd_data1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => rd_data1_carry_n_0,
      CO(3) => \rd_data1_carry__0_n_0\,
      CO(2) => \rd_data1_carry__0_n_1\,
      CO(1) => \rd_data1_carry__0_n_2\,
      CO(0) => \rd_data1_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => rd_data1(8 downto 5),
      S(3) => \rd_data1_carry__0_i_1_n_0\,
      S(2) => \rd_data1_carry__0_i_2_n_0\,
      S(1) => \rd_data1_carry__0_i_3_n_0\,
      S(0) => \rd_data1_carry__0_i_4_n_0\
    );
\rd_data1_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(8),
      O => \rd_data1_carry__0_i_1_n_0\
    );
\rd_data1_carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(7),
      O => \rd_data1_carry__0_i_2_n_0\
    );
\rd_data1_carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(6),
      O => \rd_data1_carry__0_i_3_n_0\
    );
\rd_data1_carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(5),
      O => \rd_data1_carry__0_i_4_n_0\
    );
\rd_data1_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \rd_data1_carry__0_n_0\,
      CO(3) => \rd_data1_carry__1_n_0\,
      CO(2) => \rd_data1_carry__1_n_1\,
      CO(1) => \rd_data1_carry__1_n_2\,
      CO(0) => \rd_data1_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => rd_data1(12 downto 9),
      S(3) => \rd_data1_carry__1_i_1_n_0\,
      S(2) => \rd_data1_carry__1_i_2_n_0\,
      S(1) => \rd_data1_carry__1_i_3_n_0\,
      S(0) => \rd_data1_carry__1_i_4_n_0\
    );
\rd_data1_carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(12),
      O => \rd_data1_carry__1_i_1_n_0\
    );
\rd_data1_carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(11),
      O => \rd_data1_carry__1_i_2_n_0\
    );
\rd_data1_carry__1_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(10),
      O => \rd_data1_carry__1_i_3_n_0\
    );
\rd_data1_carry__1_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(9),
      O => \rd_data1_carry__1_i_4_n_0\
    );
\rd_data1_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \rd_data1_carry__1_n_0\,
      CO(3) => \rd_data1_carry__2_n_0\,
      CO(2) => \rd_data1_carry__2_n_1\,
      CO(1) => \rd_data1_carry__2_n_2\,
      CO(0) => \rd_data1_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => rd_data1(16 downto 13),
      S(3) => \rd_data1_carry__2_i_1_n_0\,
      S(2) => \rd_data1_carry__2_i_2_n_0\,
      S(1) => \rd_data1_carry__2_i_3_n_0\,
      S(0) => \rd_data1_carry__2_i_4_n_0\
    );
\rd_data1_carry__2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(16),
      O => \rd_data1_carry__2_i_1_n_0\
    );
\rd_data1_carry__2_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(15),
      O => \rd_data1_carry__2_i_2_n_0\
    );
\rd_data1_carry__2_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(14),
      O => \rd_data1_carry__2_i_3_n_0\
    );
\rd_data1_carry__2_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(13),
      O => \rd_data1_carry__2_i_4_n_0\
    );
\rd_data1_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \rd_data1_carry__2_n_0\,
      CO(3) => \rd_data1_carry__3_n_0\,
      CO(2) => \rd_data1_carry__3_n_1\,
      CO(1) => \rd_data1_carry__3_n_2\,
      CO(0) => \rd_data1_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => rd_data1(20 downto 17),
      S(3) => \rd_data1_carry__3_i_1_n_0\,
      S(2) => \rd_data1_carry__3_i_2_n_0\,
      S(1) => \rd_data1_carry__3_i_3_n_0\,
      S(0) => \rd_data1_carry__3_i_4_n_0\
    );
\rd_data1_carry__3_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(20),
      O => \rd_data1_carry__3_i_1_n_0\
    );
\rd_data1_carry__3_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(19),
      O => \rd_data1_carry__3_i_2_n_0\
    );
\rd_data1_carry__3_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(18),
      O => \rd_data1_carry__3_i_3_n_0\
    );
\rd_data1_carry__3_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(17),
      O => \rd_data1_carry__3_i_4_n_0\
    );
\rd_data1_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \rd_data1_carry__3_n_0\,
      CO(3) => \rd_data1_carry__4_n_0\,
      CO(2) => \rd_data1_carry__4_n_1\,
      CO(1) => \rd_data1_carry__4_n_2\,
      CO(0) => \rd_data1_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => rd_data1(24 downto 21),
      S(3) => \rd_data1_carry__4_i_1_n_0\,
      S(2) => \rd_data1_carry__4_i_2_n_0\,
      S(1) => \rd_data1_carry__4_i_3_n_0\,
      S(0) => \rd_data1_carry__4_i_4_n_0\
    );
\rd_data1_carry__4_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(24),
      O => \rd_data1_carry__4_i_1_n_0\
    );
\rd_data1_carry__4_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(23),
      O => \rd_data1_carry__4_i_2_n_0\
    );
\rd_data1_carry__4_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(22),
      O => \rd_data1_carry__4_i_3_n_0\
    );
\rd_data1_carry__4_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(21),
      O => \rd_data1_carry__4_i_4_n_0\
    );
\rd_data1_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \rd_data1_carry__4_n_0\,
      CO(3) => \rd_data1_carry__5_n_0\,
      CO(2) => \rd_data1_carry__5_n_1\,
      CO(1) => \rd_data1_carry__5_n_2\,
      CO(0) => \rd_data1_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => rd_data1(28 downto 25),
      S(3) => \rd_data1_carry__5_i_1_n_0\,
      S(2) => \rd_data1_carry__5_i_2_n_0\,
      S(1) => \rd_data1_carry__5_i_3_n_0\,
      S(0) => \rd_data1_carry__5_i_4_n_0\
    );
\rd_data1_carry__5_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(28),
      O => \rd_data1_carry__5_i_1_n_0\
    );
\rd_data1_carry__5_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(27),
      O => \rd_data1_carry__5_i_2_n_0\
    );
\rd_data1_carry__5_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(26),
      O => \rd_data1_carry__5_i_3_n_0\
    );
\rd_data1_carry__5_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(25),
      O => \rd_data1_carry__5_i_4_n_0\
    );
\rd_data1_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \rd_data1_carry__5_n_0\,
      CO(3 downto 2) => \NLW_rd_data1_carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \rd_data1_carry__6_n_2\,
      CO(0) => \rd_data1_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_rd_data1_carry__6_O_UNCONNECTED\(3),
      O(2 downto 0) => rd_data1(31 downto 29),
      S(3) => '0',
      S(2) => \rd_data1_carry__6_i_1_n_0\,
      S(1) => \rd_data1_carry__6_i_2_n_0\,
      S(0) => \rd_data1_carry__6_i_3_n_0\
    );
\rd_data1_carry__6_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(31),
      O => \rd_data1_carry__6_i_1_n_0\
    );
\rd_data1_carry__6_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(30),
      O => \rd_data1_carry__6_i_2_n_0\
    );
\rd_data1_carry__6_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(29),
      O => \rd_data1_carry__6_i_3_n_0\
    );
rd_data1_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(4),
      O => rd_data1_carry_i_1_n_0
    );
rd_data1_carry_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(3),
      O => rd_data1_carry_i_2_n_0
    );
rd_data1_carry_i_3: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(2),
      O => rd_data1_carry_i_3_n_0
    );
rd_data1_carry_i_4: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^s00_axi_rdata\(1),
      O => rd_data1_carry_i_4_n_0
    );
\rd_data[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFD00000001"
    )
        port map (
      I0 => \^s00_axi_rdata\(0),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(0),
      O => \rd_data[0]_i_1_n_0\
    );
\rd_data[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(10),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(10),
      O => \rd_data[10]_i_1_n_0\
    );
\rd_data[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(11),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(11),
      O => \rd_data[11]_i_1_n_0\
    );
\rd_data[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(12),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(12),
      O => \rd_data[12]_i_1_n_0\
    );
\rd_data[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(13),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(13),
      O => \rd_data[13]_i_1_n_0\
    );
\rd_data[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(14),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(14),
      O => \rd_data[14]_i_1_n_0\
    );
\rd_data[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(15),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(15),
      O => \rd_data[15]_i_1_n_0\
    );
\rd_data[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(16),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(16),
      O => \rd_data[16]_i_1_n_0\
    );
\rd_data[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(17),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(17),
      O => \rd_data[17]_i_1_n_0\
    );
\rd_data[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(18),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(18),
      O => \rd_data[18]_i_1_n_0\
    );
\rd_data[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(19),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(19),
      O => \rd_data[19]_i_1_n_0\
    );
\rd_data[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(1),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(1),
      O => \rd_data[1]_i_1_n_0\
    );
\rd_data[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(20),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(20),
      O => \rd_data[20]_i_1_n_0\
    );
\rd_data[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(21),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(21),
      O => \rd_data[21]_i_1_n_0\
    );
\rd_data[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(22),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(22),
      O => \rd_data[22]_i_1_n_0\
    );
\rd_data[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(23),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(23),
      O => \rd_data[23]_i_1_n_0\
    );
\rd_data[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(24),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(24),
      O => \rd_data[24]_i_1_n_0\
    );
\rd_data[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(25),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(25),
      O => \rd_data[25]_i_1_n_0\
    );
\rd_data[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(26),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(26),
      O => \rd_data[26]_i_1_n_0\
    );
\rd_data[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(27),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(27),
      O => \rd_data[27]_i_1_n_0\
    );
\rd_data[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(28),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(28),
      O => \rd_data[28]_i_1_n_0\
    );
\rd_data[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(29),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(29),
      O => \rd_data[29]_i_1_n_0\
    );
\rd_data[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(2),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(2),
      O => \rd_data[2]_i_1_n_0\
    );
\rd_data[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(30),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(30),
      O => \rd_data[30]_i_1_n_0\
    );
\rd_data[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(31),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(31),
      O => \rd_data[31]_i_1_n_0\
    );
\rd_data[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(3),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(3),
      O => \rd_data[3]_i_1_n_0\
    );
\rd_data[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(4),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(4),
      O => \rd_data[4]_i_1_n_0\
    );
\rd_data[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(5),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(5),
      O => \rd_data[5]_i_1_n_0\
    );
\rd_data[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(6),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(6),
      O => \rd_data[6]_i_1_n_0\
    );
\rd_data[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(7),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(7),
      O => \rd_data[7]_i_1_n_0\
    );
\rd_data[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(8),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(8),
      O => \rd_data[8]_i_1_n_0\
    );
\rd_data[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => rd_data1(9),
      I1 => rd_addr(1),
      I2 => rd_addr(0),
      I3 => rd_addr(3),
      I4 => rd_addr(2),
      I5 => wr_word(9),
      O => \rd_data[9]_i_1_n_0\
    );
\rd_data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[0]_i_1_n_0\,
      Q => \^s00_axi_rdata\(0),
      R => '0'
    );
\rd_data_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[10]_i_1_n_0\,
      Q => \^s00_axi_rdata\(10),
      R => '0'
    );
\rd_data_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[11]_i_1_n_0\,
      Q => \^s00_axi_rdata\(11),
      R => '0'
    );
\rd_data_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[12]_i_1_n_0\,
      Q => \^s00_axi_rdata\(12),
      R => '0'
    );
\rd_data_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[13]_i_1_n_0\,
      Q => \^s00_axi_rdata\(13),
      R => '0'
    );
\rd_data_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[14]_i_1_n_0\,
      Q => \^s00_axi_rdata\(14),
      R => '0'
    );
\rd_data_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[15]_i_1_n_0\,
      Q => \^s00_axi_rdata\(15),
      R => '0'
    );
\rd_data_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[16]_i_1_n_0\,
      Q => \^s00_axi_rdata\(16),
      R => '0'
    );
\rd_data_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[17]_i_1_n_0\,
      Q => \^s00_axi_rdata\(17),
      R => '0'
    );
\rd_data_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[18]_i_1_n_0\,
      Q => \^s00_axi_rdata\(18),
      R => '0'
    );
\rd_data_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[19]_i_1_n_0\,
      Q => \^s00_axi_rdata\(19),
      R => '0'
    );
\rd_data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[1]_i_1_n_0\,
      Q => \^s00_axi_rdata\(1),
      R => '0'
    );
\rd_data_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[20]_i_1_n_0\,
      Q => \^s00_axi_rdata\(20),
      R => '0'
    );
\rd_data_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[21]_i_1_n_0\,
      Q => \^s00_axi_rdata\(21),
      R => '0'
    );
\rd_data_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[22]_i_1_n_0\,
      Q => \^s00_axi_rdata\(22),
      R => '0'
    );
\rd_data_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[23]_i_1_n_0\,
      Q => \^s00_axi_rdata\(23),
      R => '0'
    );
\rd_data_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[24]_i_1_n_0\,
      Q => \^s00_axi_rdata\(24),
      R => '0'
    );
\rd_data_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[25]_i_1_n_0\,
      Q => \^s00_axi_rdata\(25),
      R => '0'
    );
\rd_data_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[26]_i_1_n_0\,
      Q => \^s00_axi_rdata\(26),
      R => '0'
    );
\rd_data_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[27]_i_1_n_0\,
      Q => \^s00_axi_rdata\(27),
      R => '0'
    );
\rd_data_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[28]_i_1_n_0\,
      Q => \^s00_axi_rdata\(28),
      R => '0'
    );
\rd_data_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[29]_i_1_n_0\,
      Q => \^s00_axi_rdata\(29),
      R => '0'
    );
\rd_data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[2]_i_1_n_0\,
      Q => \^s00_axi_rdata\(2),
      R => '0'
    );
\rd_data_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[30]_i_1_n_0\,
      Q => \^s00_axi_rdata\(30),
      R => '0'
    );
\rd_data_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[31]_i_1_n_0\,
      Q => \^s00_axi_rdata\(31),
      R => '0'
    );
\rd_data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[3]_i_1_n_0\,
      Q => \^s00_axi_rdata\(3),
      R => '0'
    );
\rd_data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[4]_i_1_n_0\,
      Q => \^s00_axi_rdata\(4),
      R => '0'
    );
\rd_data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[5]_i_1_n_0\,
      Q => \^s00_axi_rdata\(5),
      R => '0'
    );
\rd_data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[6]_i_1_n_0\,
      Q => \^s00_axi_rdata\(6),
      R => '0'
    );
\rd_data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[7]_i_1_n_0\,
      Q => \^s00_axi_rdata\(7),
      R => '0'
    );
\rd_data_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[8]_i_1_n_0\,
      Q => \^s00_axi_rdata\(8),
      R => '0'
    );
\rd_data_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \^s00_axi_arready\,
      D => \rd_data[9]_i_1_n_0\,
      Q => \^s00_axi_rdata\(9),
      R => '0'
    );
rvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F200"
    )
        port map (
      I0 => \^s00_axi_rvalid\,
      I1 => s00_axi_rready,
      I2 => \^s00_axi_arready\,
      I3 => s00_axi_aresetn,
      O => rvalid_i_1_n_0
    );
rvalid_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => '1',
      D => rvalid_i_1_n_0,
      Q => \^s00_axi_rvalid\,
      R => '0'
    );
\wr_word_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(0),
      Q => wr_word(0),
      R => '0'
    );
\wr_word_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(10),
      Q => wr_word(10),
      R => '0'
    );
\wr_word_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(11),
      Q => wr_word(11),
      R => '0'
    );
\wr_word_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(12),
      Q => wr_word(12),
      R => '0'
    );
\wr_word_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(13),
      Q => wr_word(13),
      R => '0'
    );
\wr_word_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(14),
      Q => wr_word(14),
      R => '0'
    );
\wr_word_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(15),
      Q => wr_word(15),
      R => '0'
    );
\wr_word_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(16),
      Q => wr_word(16),
      R => '0'
    );
\wr_word_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(17),
      Q => wr_word(17),
      R => '0'
    );
\wr_word_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(18),
      Q => wr_word(18),
      R => '0'
    );
\wr_word_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(19),
      Q => wr_word(19),
      R => '0'
    );
\wr_word_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(1),
      Q => wr_word(1),
      R => '0'
    );
\wr_word_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(20),
      Q => wr_word(20),
      R => '0'
    );
\wr_word_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(21),
      Q => wr_word(21),
      R => '0'
    );
\wr_word_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(22),
      Q => wr_word(22),
      R => '0'
    );
\wr_word_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(23),
      Q => wr_word(23),
      R => '0'
    );
\wr_word_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(24),
      Q => wr_word(24),
      R => '0'
    );
\wr_word_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(25),
      Q => wr_word(25),
      R => '0'
    );
\wr_word_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(26),
      Q => wr_word(26),
      R => '0'
    );
\wr_word_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(27),
      Q => wr_word(27),
      R => '0'
    );
\wr_word_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(28),
      Q => wr_word(28),
      R => '0'
    );
\wr_word_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(29),
      Q => wr_word(29),
      R => '0'
    );
\wr_word_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(2),
      Q => wr_word(2),
      R => '0'
    );
\wr_word_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(30),
      Q => wr_word(30),
      R => '0'
    );
\wr_word_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(31),
      Q => wr_word(31),
      R => '0'
    );
\wr_word_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(3),
      Q => wr_word(3),
      R => '0'
    );
\wr_word_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(4),
      Q => wr_word(4),
      R => '0'
    );
\wr_word_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(5),
      Q => wr_word(5),
      R => '0'
    );
\wr_word_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(6),
      Q => wr_word(6),
      R => '0'
    );
\wr_word_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(7),
      Q => wr_word(7),
      R => '0'
    );
\wr_word_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(8),
      Q => wr_word(8),
      R => '0'
    );
\wr_word_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s00_axi_aclk,
      CE => \awready0__0\,
      D => s00_axi_wdata(9),
      Q => wr_word(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity block_design_simple_ip_0_0 is
  port (
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
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
    s00_axi_rready : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of block_design_simple_ip_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of block_design_simple_ip_0_0 : entity is "block_design_simple_ip_0_0,simple_ip,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of block_design_simple_ip_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of block_design_simple_ip_0_0 : entity is "simple_ip,Vivado 2017.2";
end block_design_simple_ip_0_0;

architecture STRUCTURE of block_design_simple_ip_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^s00_axi_awready\ : STD_LOGIC;
begin
  s00_axi_awready <= \^s00_axi_awready\;
  s00_axi_bresp(1) <= \<const0>\;
  s00_axi_bresp(0) <= \<const0>\;
  s00_axi_bvalid <= \^s00_axi_awready\;
  s00_axi_rresp(1) <= \<const0>\;
  s00_axi_rresp(0) <= \<const0>\;
  s00_axi_wready <= \^s00_axi_awready\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.block_design_simple_ip_0_0_simple_ip
     port map (
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_araddr(3 downto 0) => s00_axi_araddr(3 downto 0),
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_arready => s00_axi_arready,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_awready => \^s00_axi_awready\,
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_rdata(31 downto 0) => s00_axi_rdata(31 downto 0),
      s00_axi_rready => s00_axi_rready,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_wdata(31 downto 0) => s00_axi_wdata(31 downto 0),
      s00_axi_wvalid => s00_axi_wvalid
    );
end STRUCTURE;
