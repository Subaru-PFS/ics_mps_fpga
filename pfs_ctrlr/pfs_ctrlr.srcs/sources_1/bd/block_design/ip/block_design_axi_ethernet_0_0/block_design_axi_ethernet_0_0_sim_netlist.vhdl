-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Wed Sep  6 18:22:14 2017
-- Host        : rumney-LMC-062144 running 64-bit Ubuntu 16.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/sources_1/bd/block_design/ip/block_design_axi_ethernet_0_0/block_design_axi_ethernet_0_0_sim_netlist.vhdl
-- Design      : block_design_axi_ethernet_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity block_design_axi_ethernet_0_0_bd_f793 is
  port (
    axi_rxd_arstn : in STD_LOGIC;
    axi_rxs_arstn : in STD_LOGIC;
    axi_txc_arstn : in STD_LOGIC;
    axi_txd_arstn : in STD_LOGIC;
    axis_clk : in STD_LOGIC;
    gmii_gtx_clk : out STD_LOGIC;
    gmii_rx_clk : in STD_LOGIC;
    gmii_rx_dv : in STD_LOGIC;
    gmii_rx_er : in STD_LOGIC;
    gmii_rxd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_clk : in STD_LOGIC;
    gmii_tx_en : out STD_LOGIC;
    gmii_tx_er : out STD_LOGIC;
    gmii_txd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gtx_clk : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    m_axis_rxd_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxd_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxd_tlast : out STD_LOGIC;
    m_axis_rxd_tready : in STD_LOGIC;
    m_axis_rxd_tvalid : out STD_LOGIC;
    m_axis_rxs_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxs_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxs_tlast : out STD_LOGIC;
    m_axis_rxs_tready : in STD_LOGIC;
    m_axis_rxs_tvalid : out STD_LOGIC;
    mac_irq : out STD_LOGIC;
    mdio_mdc : out STD_LOGIC;
    mdio_mdio_i : in STD_LOGIC;
    mdio_mdio_o : out STD_LOGIC;
    mdio_mdio_t : out STD_LOGIC;
    phy_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ref_clk : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_lite_clk : in STD_LOGIC;
    s_axi_lite_resetn : in STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axis_txc_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txc_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txc_tlast : in STD_LOGIC;
    s_axis_txc_tready : out STD_LOGIC;
    s_axis_txc_tvalid : in STD_LOGIC;
    s_axis_txd_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txd_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txd_tlast : in STD_LOGIC;
    s_axis_txd_tready : out STD_LOGIC;
    s_axis_txd_tvalid : in STD_LOGIC
  );
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of block_design_axi_ethernet_0_0_bd_f793 : entity is "block_design_axi_ethernet_0_0.hwdef";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of block_design_axi_ethernet_0_0_bd_f793 : entity is "bd_f793";
end block_design_axi_ethernet_0_0_bd_f793;

architecture STRUCTURE of block_design_axi_ethernet_0_0_bd_f793 is
  component block_design_axi_ethernet_0_0_bd_f793_c_counter_binary_0_0 is
  port (
    CLK : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    THRESH0 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component block_design_axi_ethernet_0_0_bd_f793_c_counter_binary_0_0;
  component block_design_axi_ethernet_0_0_bd_f793_c_shift_ram_0_0 is
  port (
    D : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component block_design_axi_ethernet_0_0_bd_f793_c_shift_ram_0_0;
  component block_design_axi_ethernet_0_0_bd_f793_eth_buf_0 is
  port (
    INTERRUPT : out STD_LOGIC;
    S_AXI_ACLK : in STD_LOGIC;
    S_AXI_ARESETN : in STD_LOGIC;
    S_AXI_AWADDR : in STD_LOGIC_VECTOR ( 17 downto 0 );
    S_AXI_AWVALID : in STD_LOGIC;
    S_AXI_AWREADY : out STD_LOGIC;
    S_AXI_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_WVALID : in STD_LOGIC;
    S_AXI_WREADY : out STD_LOGIC;
    S_AXI_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BVALID : out STD_LOGIC;
    S_AXI_BREADY : in STD_LOGIC;
    S_AXI_ARADDR : in STD_LOGIC_VECTOR ( 17 downto 0 );
    S_AXI_ARVALID : in STD_LOGIC;
    S_AXI_ARREADY : out STD_LOGIC;
    S_AXI_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_RVALID : out STD_LOGIC;
    S_AXI_RREADY : in STD_LOGIC;
    EMAC_CLIENT_AUTONEG_INT : in STD_LOGIC;
    EMAC_RESET_DONE_INT : in STD_LOGIC;
    EMAC_RX_DCM_LOCKED_INT : in STD_LOGIC;
    PCSPMA_STATUS_VECTOR : in STD_LOGIC_VECTOR ( 15 downto 0 );
    AXI_STR_TXD_ACLK : in STD_LOGIC;
    AXI_STR_TXD_ARESETN : in STD_LOGIC;
    AXI_STR_TXD_TVALID : in STD_LOGIC;
    AXI_STR_TXD_TREADY : out STD_LOGIC;
    AXI_STR_TXD_TLAST : in STD_LOGIC;
    AXI_STR_TXD_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_TXD_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_STR_TXC_ACLK : in STD_LOGIC;
    AXI_STR_TXC_ARESETN : in STD_LOGIC;
    AXI_STR_TXC_TVALID : in STD_LOGIC;
    AXI_STR_TXC_TREADY : out STD_LOGIC;
    AXI_STR_TXC_TLAST : in STD_LOGIC;
    AXI_STR_TXC_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_TXC_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_STR_RXD_ACLK : in STD_LOGIC;
    AXI_STR_RXD_ARESETN : in STD_LOGIC;
    AXI_STR_RXD_VALID : out STD_LOGIC;
    AXI_STR_RXD_READY : in STD_LOGIC;
    AXI_STR_RXD_LAST : out STD_LOGIC;
    AXI_STR_RXD_KEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_RXD_DATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_STR_RXS_ACLK : in STD_LOGIC;
    AXI_STR_RXS_ARESETN : in STD_LOGIC;
    AXI_STR_RXS_VALID : out STD_LOGIC;
    AXI_STR_RXS_READY : in STD_LOGIC;
    AXI_STR_RXS_LAST : out STD_LOGIC;
    AXI_STR_RXS_KEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_RXS_DATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pause_req : out STD_LOGIC;
    pause_val : out STD_LOGIC_VECTOR ( 16 to 31 );
    S_AXI_2TEMAC_AWADDR : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_2TEMAC_AWVALID : out STD_LOGIC;
    S_AXI_2TEMAC_AWREADY : in STD_LOGIC;
    S_AXI_2TEMAC_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2TEMAC_WVALID : out STD_LOGIC;
    S_AXI_2TEMAC_WREADY : in STD_LOGIC;
    S_AXI_2TEMAC_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2TEMAC_BVALID : in STD_LOGIC;
    S_AXI_2TEMAC_BREADY : out STD_LOGIC;
    S_AXI_2TEMAC_ARADDR : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_2TEMAC_ARVALID : out STD_LOGIC;
    S_AXI_2TEMAC_ARREADY : in STD_LOGIC;
    S_AXI_2TEMAC_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2TEMAC_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2TEMAC_RVALID : in STD_LOGIC;
    S_AXI_2TEMAC_RREADY : out STD_LOGIC;
    RX_CLK_ENABLE_IN : in STD_LOGIC;
    rx_statistics_vector : in STD_LOGIC_VECTOR ( 27 downto 0 );
    rx_statistics_valid : in STD_LOGIC;
    rx_mac_aclk : in STD_LOGIC;
    rx_reset : in STD_LOGIC;
    rx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : in STD_LOGIC;
    rx_axis_mac_tlast : in STD_LOGIC;
    rx_axis_mac_tuser : in STD_LOGIC;
    tx_ifg_delay : out STD_LOGIC_VECTOR ( 24 to 31 );
    tx_mac_aclk : in STD_LOGIC;
    tx_reset : in STD_LOGIC;
    tx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_mac_tvalid : out STD_LOGIC;
    tx_axis_mac_tlast : out STD_LOGIC;
    tx_axis_mac_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    tx_axis_mac_tready : in STD_LOGIC;
    speed_is_10_100 : in STD_LOGIC;
    RESET2PCSPMA : out STD_LOGIC;
    RESET2TEMACn : out STD_LOGIC;
    PHY_RST_N : out STD_LOGIC;
    mdio_i_top : in STD_LOGIC;
    mdio_o_top : out STD_LOGIC;
    mdio_t_top : out STD_LOGIC;
    mdc_top : out STD_LOGIC;
    mdio_t_pcspma : in STD_LOGIC;
    mdio_o_pcspma : in STD_LOGIC;
    mdio_i_temac : out STD_LOGIC;
    mdio_o_temac : in STD_LOGIC;
    mdio_t_temac : in STD_LOGIC;
    mdc_temac : in STD_LOGIC;
    GTX_CLK : in STD_LOGIC
  );
  end component block_design_axi_ethernet_0_0_bd_f793_eth_buf_0;
  component block_design_axi_ethernet_0_0_bd_f793_mac_0 is
  port (
    gtx_clk : in STD_LOGIC;
    refclk : in STD_LOGIC;
    glbl_rstn : in STD_LOGIC;
    rx_axi_rstn : in STD_LOGIC;
    tx_axi_rstn : in STD_LOGIC;
    rx_enable : out STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 27 downto 0 );
    rx_statistics_valid : out STD_LOGIC;
    rx_mac_aclk : out STD_LOGIC;
    rx_reset : out STD_LOGIC;
    rx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : out STD_LOGIC;
    rx_axis_mac_tlast : out STD_LOGIC;
    rx_axis_mac_tuser : out STD_LOGIC;
    rx_axis_filter_tuser : out STD_LOGIC_VECTOR ( 4 downto 0 );
    tx_enable : out STD_LOGIC;
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 31 downto 0 );
    tx_statistics_valid : out STD_LOGIC;
    tx_mac_aclk : out STD_LOGIC;
    tx_reset : out STD_LOGIC;
    tx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_mac_tvalid : in STD_LOGIC;
    tx_axis_mac_tlast : in STD_LOGIC;
    tx_axis_mac_tuser : in STD_LOGIC;
    tx_axis_mac_tready : out STD_LOGIC;
    pause_req : in STD_LOGIC;
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    speedis100 : out STD_LOGIC;
    speedis10100 : out STD_LOGIC;
    gmii_txd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en : out STD_LOGIC;
    gmii_tx_er : out STD_LOGIC;
    gmii_tx_clk : out STD_LOGIC;
    gmii_rxd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv : in STD_LOGIC;
    gmii_rx_er : in STD_LOGIC;
    gmii_rx_clk : in STD_LOGIC;
    mii_tx_clk : in STD_LOGIC;
    mdio_i : in STD_LOGIC;
    mdio_o : out STD_LOGIC;
    mdio_t : out STD_LOGIC;
    mdc : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_resetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    mac_irq : out STD_LOGIC
  );
  end component block_design_axi_ethernet_0_0_bd_f793_mac_0;
  component block_design_axi_ethernet_0_0_bd_f793_util_vector_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component block_design_axi_ethernet_0_0_bd_f793_util_vector_logic_0_0;
  component block_design_axi_ethernet_0_0_bd_f793_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component block_design_axi_ethernet_0_0_bd_f793_xlconstant_0_0;
  signal c_counter_binary_0_THRESH0 : STD_LOGIC;
  signal eth_buf_RESET2TEMACn : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_ARADDR : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_ARREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_ARVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_AWADDR : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_AWREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_AWVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_BREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_BVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_RREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_RVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_WREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_WVALID : STD_LOGIC;
  signal eth_buf_TX_AXIS_MAC_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal eth_buf_TX_AXIS_MAC_TLAST : STD_LOGIC;
  signal eth_buf_TX_AXIS_MAC_TREADY : STD_LOGIC;
  signal eth_buf_TX_AXIS_MAC_TUSER : STD_LOGIC;
  signal eth_buf_TX_AXIS_MAC_TVALID : STD_LOGIC;
  signal eth_buf_pause_req : STD_LOGIC;
  signal eth_buf_pause_val : STD_LOGIC_VECTOR ( 16 to 31 );
  signal eth_buf_tx_ifg_delay : STD_LOGIC_VECTOR ( 24 to 31 );
  signal mac_m_axis_rx_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal mac_m_axis_rx_TLAST : STD_LOGIC;
  signal mac_m_axis_rx_TUSER : STD_LOGIC;
  signal mac_m_axis_rx_TVALID : STD_LOGIC;
  signal mac_rx_enable : STD_LOGIC;
  signal mac_rx_mac_aclk : STD_LOGIC;
  signal mac_rx_reset : STD_LOGIC;
  signal mac_rx_statistics_valid : STD_LOGIC;
  signal mac_rx_statistics_vector : STD_LOGIC_VECTOR ( 27 downto 0 );
  signal mac_speedis10100 : STD_LOGIC;
  signal mac_tx_mac_aclk : STD_LOGIC;
  signal mac_tx_reset : STD_LOGIC;
  signal util_vector_logic_0_Res : STD_LOGIC;
  signal xlconstant_0_dout : STD_LOGIC;
  signal NLW_c_counter_binary_0_Q_UNCONNECTED : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal NLW_eth_buf_PHY_RST_N_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_RESET2PCSPMA_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdc_top_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdio_i_temac_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdio_o_top_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdio_t_top_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_speedis100_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_tx_enable_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_tx_statistics_valid_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_rx_axis_filter_tuser_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_mac_tx_statistics_vector_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute x_core_info : string;
  attribute x_core_info of c_counter_binary_0 : label is "c_counter_binary_v12_0_10,Vivado 2017.2";
  attribute x_core_info of c_shift_ram_0 : label is "c_shift_ram_v12_0_10,Vivado 2017.2";
  attribute x_core_info of eth_buf : label is "axi_ethernet_buffer_v2_0_15,Vivado 2017.2";
  attribute x_core_info of mac : label is "bd_f793_mac_0_support,Vivado 2017.2";
  attribute x_core_info of util_vector_logic_0 : label is "util_vector_logic_v2_0_1_util_vector_logic,Vivado 2017.2";
  attribute x_core_info of xlconstant_0 : label is "xlconstant_v1_1_3_xlconstant,Vivado 2017.2";
begin
c_counter_binary_0: component block_design_axi_ethernet_0_0_bd_f793_c_counter_binary_0_0
     port map (
      CLK => s_axi_lite_clk,
      Q(23 downto 0) => NLW_c_counter_binary_0_Q_UNCONNECTED(23 downto 0),
      SCLR => util_vector_logic_0_Res,
      THRESH0 => c_counter_binary_0_THRESH0
    );
c_shift_ram_0: component block_design_axi_ethernet_0_0_bd_f793_c_shift_ram_0_0
     port map (
      CE => c_counter_binary_0_THRESH0,
      CLK => s_axi_lite_clk,
      D(0) => xlconstant_0_dout,
      Q(0) => phy_rst_n(0),
      SCLR => util_vector_logic_0_Res
    );
eth_buf: component block_design_axi_ethernet_0_0_bd_f793_eth_buf_0
     port map (
      AXI_STR_RXD_ACLK => axis_clk,
      AXI_STR_RXD_ARESETN => axi_rxd_arstn,
      AXI_STR_RXD_DATA(31 downto 0) => m_axis_rxd_tdata(31 downto 0),
      AXI_STR_RXD_KEEP(3 downto 0) => m_axis_rxd_tkeep(3 downto 0),
      AXI_STR_RXD_LAST => m_axis_rxd_tlast,
      AXI_STR_RXD_READY => m_axis_rxd_tready,
      AXI_STR_RXD_VALID => m_axis_rxd_tvalid,
      AXI_STR_RXS_ACLK => axis_clk,
      AXI_STR_RXS_ARESETN => axi_rxs_arstn,
      AXI_STR_RXS_DATA(31 downto 0) => m_axis_rxs_tdata(31 downto 0),
      AXI_STR_RXS_KEEP(3 downto 0) => m_axis_rxs_tkeep(3 downto 0),
      AXI_STR_RXS_LAST => m_axis_rxs_tlast,
      AXI_STR_RXS_READY => m_axis_rxs_tready,
      AXI_STR_RXS_VALID => m_axis_rxs_tvalid,
      AXI_STR_TXC_ACLK => axis_clk,
      AXI_STR_TXC_ARESETN => axi_txc_arstn,
      AXI_STR_TXC_TDATA(31 downto 0) => s_axis_txc_tdata(31 downto 0),
      AXI_STR_TXC_TKEEP(3 downto 0) => s_axis_txc_tkeep(3 downto 0),
      AXI_STR_TXC_TLAST => s_axis_txc_tlast,
      AXI_STR_TXC_TREADY => s_axis_txc_tready,
      AXI_STR_TXC_TVALID => s_axis_txc_tvalid,
      AXI_STR_TXD_ACLK => axis_clk,
      AXI_STR_TXD_ARESETN => axi_txd_arstn,
      AXI_STR_TXD_TDATA(31 downto 0) => s_axis_txd_tdata(31 downto 0),
      AXI_STR_TXD_TKEEP(3 downto 0) => s_axis_txd_tkeep(3 downto 0),
      AXI_STR_TXD_TLAST => s_axis_txd_tlast,
      AXI_STR_TXD_TREADY => s_axis_txd_tready,
      AXI_STR_TXD_TVALID => s_axis_txd_tvalid,
      EMAC_CLIENT_AUTONEG_INT => '0',
      EMAC_RESET_DONE_INT => '1',
      EMAC_RX_DCM_LOCKED_INT => '1',
      GTX_CLK => gtx_clk,
      INTERRUPT => interrupt,
      PCSPMA_STATUS_VECTOR(15 downto 0) => B"0000000000000000",
      PHY_RST_N => NLW_eth_buf_PHY_RST_N_UNCONNECTED,
      RESET2PCSPMA => NLW_eth_buf_RESET2PCSPMA_UNCONNECTED,
      RESET2TEMACn => eth_buf_RESET2TEMACn,
      RX_CLK_ENABLE_IN => mac_rx_enable,
      S_AXI_2TEMAC_ARADDR(11 downto 0) => eth_buf_S_AXI_2TEMAC_ARADDR(11 downto 0),
      S_AXI_2TEMAC_ARREADY => eth_buf_S_AXI_2TEMAC_ARREADY,
      S_AXI_2TEMAC_ARVALID => eth_buf_S_AXI_2TEMAC_ARVALID,
      S_AXI_2TEMAC_AWADDR(11 downto 0) => eth_buf_S_AXI_2TEMAC_AWADDR(11 downto 0),
      S_AXI_2TEMAC_AWREADY => eth_buf_S_AXI_2TEMAC_AWREADY,
      S_AXI_2TEMAC_AWVALID => eth_buf_S_AXI_2TEMAC_AWVALID,
      S_AXI_2TEMAC_BREADY => eth_buf_S_AXI_2TEMAC_BREADY,
      S_AXI_2TEMAC_BRESP(1 downto 0) => eth_buf_S_AXI_2TEMAC_BRESP(1 downto 0),
      S_AXI_2TEMAC_BVALID => eth_buf_S_AXI_2TEMAC_BVALID,
      S_AXI_2TEMAC_RDATA(31 downto 0) => eth_buf_S_AXI_2TEMAC_RDATA(31 downto 0),
      S_AXI_2TEMAC_RREADY => eth_buf_S_AXI_2TEMAC_RREADY,
      S_AXI_2TEMAC_RRESP(1 downto 0) => eth_buf_S_AXI_2TEMAC_RRESP(1 downto 0),
      S_AXI_2TEMAC_RVALID => eth_buf_S_AXI_2TEMAC_RVALID,
      S_AXI_2TEMAC_WDATA(31 downto 0) => eth_buf_S_AXI_2TEMAC_WDATA(31 downto 0),
      S_AXI_2TEMAC_WREADY => eth_buf_S_AXI_2TEMAC_WREADY,
      S_AXI_2TEMAC_WVALID => eth_buf_S_AXI_2TEMAC_WVALID,
      S_AXI_ACLK => s_axi_lite_clk,
      S_AXI_ARADDR(17 downto 0) => s_axi_araddr(17 downto 0),
      S_AXI_ARESETN => s_axi_lite_resetn,
      S_AXI_ARREADY => s_axi_arready,
      S_AXI_ARVALID => s_axi_arvalid,
      S_AXI_AWADDR(17 downto 0) => s_axi_awaddr(17 downto 0),
      S_AXI_AWREADY => s_axi_awready,
      S_AXI_AWVALID => s_axi_awvalid,
      S_AXI_BREADY => s_axi_bready,
      S_AXI_BRESP(1 downto 0) => s_axi_bresp(1 downto 0),
      S_AXI_BVALID => s_axi_bvalid,
      S_AXI_RDATA(31 downto 0) => s_axi_rdata(31 downto 0),
      S_AXI_RREADY => s_axi_rready,
      S_AXI_RRESP(1 downto 0) => s_axi_rresp(1 downto 0),
      S_AXI_RVALID => s_axi_rvalid,
      S_AXI_WDATA(31 downto 0) => s_axi_wdata(31 downto 0),
      S_AXI_WREADY => s_axi_wready,
      S_AXI_WSTRB(3 downto 0) => s_axi_wstrb(3 downto 0),
      S_AXI_WVALID => s_axi_wvalid,
      mdc_temac => '1',
      mdc_top => NLW_eth_buf_mdc_top_UNCONNECTED,
      mdio_i_temac => NLW_eth_buf_mdio_i_temac_UNCONNECTED,
      mdio_i_top => '1',
      mdio_o_pcspma => '0',
      mdio_o_temac => '1',
      mdio_o_top => NLW_eth_buf_mdio_o_top_UNCONNECTED,
      mdio_t_pcspma => '0',
      mdio_t_temac => '1',
      mdio_t_top => NLW_eth_buf_mdio_t_top_UNCONNECTED,
      pause_req => eth_buf_pause_req,
      pause_val(16 to 31) => eth_buf_pause_val(16 to 31),
      rx_axis_mac_tdata(7 downto 0) => mac_m_axis_rx_TDATA(7 downto 0),
      rx_axis_mac_tlast => mac_m_axis_rx_TLAST,
      rx_axis_mac_tuser => mac_m_axis_rx_TUSER,
      rx_axis_mac_tvalid => mac_m_axis_rx_TVALID,
      rx_mac_aclk => mac_rx_mac_aclk,
      rx_reset => mac_rx_reset,
      rx_statistics_valid => mac_rx_statistics_valid,
      rx_statistics_vector(27 downto 0) => mac_rx_statistics_vector(27 downto 0),
      speed_is_10_100 => mac_speedis10100,
      tx_axis_mac_tdata(7 downto 0) => eth_buf_TX_AXIS_MAC_TDATA(7 downto 0),
      tx_axis_mac_tlast => eth_buf_TX_AXIS_MAC_TLAST,
      tx_axis_mac_tready => eth_buf_TX_AXIS_MAC_TREADY,
      tx_axis_mac_tuser(0) => eth_buf_TX_AXIS_MAC_TUSER,
      tx_axis_mac_tvalid => eth_buf_TX_AXIS_MAC_TVALID,
      tx_ifg_delay(24 to 31) => eth_buf_tx_ifg_delay(24 to 31),
      tx_mac_aclk => mac_tx_mac_aclk,
      tx_reset => mac_tx_reset
    );
mac: component block_design_axi_ethernet_0_0_bd_f793_mac_0
     port map (
      glbl_rstn => eth_buf_RESET2TEMACn,
      gmii_rx_clk => gmii_rx_clk,
      gmii_rx_dv => gmii_rx_dv,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0),
      gmii_tx_clk => gmii_gtx_clk,
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0),
      gtx_clk => gtx_clk,
      mac_irq => mac_irq,
      mdc => mdio_mdc,
      mdio_i => mdio_mdio_i,
      mdio_o => mdio_mdio_o,
      mdio_t => mdio_mdio_t,
      mii_tx_clk => gmii_tx_clk,
      pause_req => eth_buf_pause_req,
      pause_val(15) => eth_buf_pause_val(16),
      pause_val(14) => eth_buf_pause_val(17),
      pause_val(13) => eth_buf_pause_val(18),
      pause_val(12) => eth_buf_pause_val(19),
      pause_val(11) => eth_buf_pause_val(20),
      pause_val(10) => eth_buf_pause_val(21),
      pause_val(9) => eth_buf_pause_val(22),
      pause_val(8) => eth_buf_pause_val(23),
      pause_val(7) => eth_buf_pause_val(24),
      pause_val(6) => eth_buf_pause_val(25),
      pause_val(5) => eth_buf_pause_val(26),
      pause_val(4) => eth_buf_pause_val(27),
      pause_val(3) => eth_buf_pause_val(28),
      pause_val(2) => eth_buf_pause_val(29),
      pause_val(1) => eth_buf_pause_val(30),
      pause_val(0) => eth_buf_pause_val(31),
      refclk => ref_clk,
      rx_axi_rstn => eth_buf_RESET2TEMACn,
      rx_axis_filter_tuser(4 downto 0) => NLW_mac_rx_axis_filter_tuser_UNCONNECTED(4 downto 0),
      rx_axis_mac_tdata(7 downto 0) => mac_m_axis_rx_TDATA(7 downto 0),
      rx_axis_mac_tlast => mac_m_axis_rx_TLAST,
      rx_axis_mac_tuser => mac_m_axis_rx_TUSER,
      rx_axis_mac_tvalid => mac_m_axis_rx_TVALID,
      rx_enable => mac_rx_enable,
      rx_mac_aclk => mac_rx_mac_aclk,
      rx_reset => mac_rx_reset,
      rx_statistics_valid => mac_rx_statistics_valid,
      rx_statistics_vector(27 downto 0) => mac_rx_statistics_vector(27 downto 0),
      s_axi_aclk => s_axi_lite_clk,
      s_axi_araddr(11 downto 0) => eth_buf_S_AXI_2TEMAC_ARADDR(11 downto 0),
      s_axi_arready => eth_buf_S_AXI_2TEMAC_ARREADY,
      s_axi_arvalid => eth_buf_S_AXI_2TEMAC_ARVALID,
      s_axi_awaddr(11 downto 0) => eth_buf_S_AXI_2TEMAC_AWADDR(11 downto 0),
      s_axi_awready => eth_buf_S_AXI_2TEMAC_AWREADY,
      s_axi_awvalid => eth_buf_S_AXI_2TEMAC_AWVALID,
      s_axi_bready => eth_buf_S_AXI_2TEMAC_BREADY,
      s_axi_bresp(1 downto 0) => eth_buf_S_AXI_2TEMAC_BRESP(1 downto 0),
      s_axi_bvalid => eth_buf_S_AXI_2TEMAC_BVALID,
      s_axi_rdata(31 downto 0) => eth_buf_S_AXI_2TEMAC_RDATA(31 downto 0),
      s_axi_resetn => s_axi_lite_resetn,
      s_axi_rready => eth_buf_S_AXI_2TEMAC_RREADY,
      s_axi_rresp(1 downto 0) => eth_buf_S_AXI_2TEMAC_RRESP(1 downto 0),
      s_axi_rvalid => eth_buf_S_AXI_2TEMAC_RVALID,
      s_axi_wdata(31 downto 0) => eth_buf_S_AXI_2TEMAC_WDATA(31 downto 0),
      s_axi_wready => eth_buf_S_AXI_2TEMAC_WREADY,
      s_axi_wvalid => eth_buf_S_AXI_2TEMAC_WVALID,
      speedis100 => NLW_mac_speedis100_UNCONNECTED,
      speedis10100 => mac_speedis10100,
      tx_axi_rstn => eth_buf_RESET2TEMACn,
      tx_axis_mac_tdata(7 downto 0) => eth_buf_TX_AXIS_MAC_TDATA(7 downto 0),
      tx_axis_mac_tlast => eth_buf_TX_AXIS_MAC_TLAST,
      tx_axis_mac_tready => eth_buf_TX_AXIS_MAC_TREADY,
      tx_axis_mac_tuser => eth_buf_TX_AXIS_MAC_TUSER,
      tx_axis_mac_tvalid => eth_buf_TX_AXIS_MAC_TVALID,
      tx_enable => NLW_mac_tx_enable_UNCONNECTED,
      tx_ifg_delay(7) => eth_buf_tx_ifg_delay(24),
      tx_ifg_delay(6) => eth_buf_tx_ifg_delay(25),
      tx_ifg_delay(5) => eth_buf_tx_ifg_delay(26),
      tx_ifg_delay(4) => eth_buf_tx_ifg_delay(27),
      tx_ifg_delay(3) => eth_buf_tx_ifg_delay(28),
      tx_ifg_delay(2) => eth_buf_tx_ifg_delay(29),
      tx_ifg_delay(1) => eth_buf_tx_ifg_delay(30),
      tx_ifg_delay(0) => eth_buf_tx_ifg_delay(31),
      tx_mac_aclk => mac_tx_mac_aclk,
      tx_reset => mac_tx_reset,
      tx_statistics_valid => NLW_mac_tx_statistics_valid_UNCONNECTED,
      tx_statistics_vector(31 downto 0) => NLW_mac_tx_statistics_vector_UNCONNECTED(31 downto 0)
    );
util_vector_logic_0: component block_design_axi_ethernet_0_0_bd_f793_util_vector_logic_0_0
     port map (
      Op1(0) => s_axi_lite_resetn,
      Res(0) => util_vector_logic_0_Res
    );
xlconstant_0: component block_design_axi_ethernet_0_0_bd_f793_xlconstant_0_0
     port map (
      dout(0) => xlconstant_0_dout
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity block_design_axi_ethernet_0_0 is
  port (
    s_axi_lite_resetn : in STD_LOGIC;
    s_axi_lite_clk : in STD_LOGIC;
    mac_irq : out STD_LOGIC;
    axis_clk : in STD_LOGIC;
    axi_txd_arstn : in STD_LOGIC;
    axi_txc_arstn : in STD_LOGIC;
    axi_rxd_arstn : in STD_LOGIC;
    axi_rxs_arstn : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    phy_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ref_clk : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axis_txc_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txc_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txc_tlast : in STD_LOGIC;
    s_axis_txc_tready : out STD_LOGIC;
    s_axis_txc_tvalid : in STD_LOGIC;
    s_axis_txd_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txd_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txd_tlast : in STD_LOGIC;
    s_axis_txd_tready : out STD_LOGIC;
    s_axis_txd_tvalid : in STD_LOGIC;
    m_axis_rxd_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxd_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxd_tlast : out STD_LOGIC;
    m_axis_rxd_tready : in STD_LOGIC;
    m_axis_rxd_tvalid : out STD_LOGIC;
    m_axis_rxs_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxs_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxs_tlast : out STD_LOGIC;
    m_axis_rxs_tready : in STD_LOGIC;
    m_axis_rxs_tvalid : out STD_LOGIC;
    gmii_gtx_clk : out STD_LOGIC;
    gmii_rx_clk : in STD_LOGIC;
    gmii_rx_dv : in STD_LOGIC;
    gmii_rx_er : in STD_LOGIC;
    gmii_rxd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_clk : in STD_LOGIC;
    gmii_tx_en : out STD_LOGIC;
    gmii_tx_er : out STD_LOGIC;
    gmii_txd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    mdio_mdc : out STD_LOGIC;
    mdio_mdio_i : in STD_LOGIC;
    mdio_mdio_o : out STD_LOGIC;
    mdio_mdio_t : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of block_design_axi_ethernet_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of block_design_axi_ethernet_0_0 : entity is "block_design_axi_ethernet_0_0,bd_f793,{tri_mode_eth_mac=bought,eth_avb_endpoint=design_linking}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of block_design_axi_ethernet_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of block_design_axi_ethernet_0_0 : entity is "bd_f793,Vivado 2017.2";
end block_design_axi_ethernet_0_0;

architecture STRUCTURE of block_design_axi_ethernet_0_0 is
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of inst : label is "block_design_axi_ethernet_0_0.hwdef";
begin
inst: entity work.block_design_axi_ethernet_0_0_bd_f793
     port map (
      axi_rxd_arstn => axi_rxd_arstn,
      axi_rxs_arstn => axi_rxs_arstn,
      axi_txc_arstn => axi_txc_arstn,
      axi_txd_arstn => axi_txd_arstn,
      axis_clk => axis_clk,
      gmii_gtx_clk => gmii_gtx_clk,
      gmii_rx_clk => gmii_rx_clk,
      gmii_rx_dv => gmii_rx_dv,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0),
      gmii_tx_clk => gmii_tx_clk,
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0),
      gtx_clk => gtx_clk,
      interrupt => interrupt,
      m_axis_rxd_tdata(31 downto 0) => m_axis_rxd_tdata(31 downto 0),
      m_axis_rxd_tkeep(3 downto 0) => m_axis_rxd_tkeep(3 downto 0),
      m_axis_rxd_tlast => m_axis_rxd_tlast,
      m_axis_rxd_tready => m_axis_rxd_tready,
      m_axis_rxd_tvalid => m_axis_rxd_tvalid,
      m_axis_rxs_tdata(31 downto 0) => m_axis_rxs_tdata(31 downto 0),
      m_axis_rxs_tkeep(3 downto 0) => m_axis_rxs_tkeep(3 downto 0),
      m_axis_rxs_tlast => m_axis_rxs_tlast,
      m_axis_rxs_tready => m_axis_rxs_tready,
      m_axis_rxs_tvalid => m_axis_rxs_tvalid,
      mac_irq => mac_irq,
      mdio_mdc => mdio_mdc,
      mdio_mdio_i => mdio_mdio_i,
      mdio_mdio_o => mdio_mdio_o,
      mdio_mdio_t => mdio_mdio_t,
      phy_rst_n(0) => phy_rst_n(0),
      ref_clk => ref_clk,
      s_axi_araddr(17 downto 0) => s_axi_araddr(17 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(17 downto 0) => s_axi_awaddr(17 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_lite_clk => s_axi_lite_clk,
      s_axi_lite_resetn => s_axi_lite_resetn,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid,
      s_axis_txc_tdata(31 downto 0) => s_axis_txc_tdata(31 downto 0),
      s_axis_txc_tkeep(3 downto 0) => s_axis_txc_tkeep(3 downto 0),
      s_axis_txc_tlast => s_axis_txc_tlast,
      s_axis_txc_tready => s_axis_txc_tready,
      s_axis_txc_tvalid => s_axis_txc_tvalid,
      s_axis_txd_tdata(31 downto 0) => s_axis_txd_tdata(31 downto 0),
      s_axis_txd_tkeep(3 downto 0) => s_axis_txd_tkeep(3 downto 0),
      s_axis_txd_tlast => s_axis_txd_tlast,
      s_axis_txd_tready => s_axis_txd_tready,
      s_axis_txd_tvalid => s_axis_txd_tvalid
    );
end STRUCTURE;
