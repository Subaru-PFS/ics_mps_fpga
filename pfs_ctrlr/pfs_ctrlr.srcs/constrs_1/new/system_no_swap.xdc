set_property BITSTREAM.CONFIG.BPI_SYNC_MODE Type2 [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN div-2 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]
set_property CONFIG_MODE BPI16 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 2.5 [current_design]

## DAUGHTERCARD
set_property LOC F20 [ get_ports pfs_rst_nxt\[0\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rst_nxt\[0\]]

set_property LOC E20 [ get_ports pfs_rst_nxt\[1\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rst_nxt\[1\]]

set_property LOC B22 [ get_ports pfs_rst_nxt\[2\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rst_nxt\[2\]]

set_property LOC A22 [ get_ports pfs_rst_nxt\[3\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rst_nxt\[3\]]

set_property LOC A18 [ get_ports pfs_rst_nxt\[4\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rst_nxt\[4\]]

set_property LOC D12 [ get_ports pfs_rst_nxt\[5\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rst_nxt\[5\]]


set_property LOC E11 [ get_ports pfs_cmd_nxt\[0\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_cmd_nxt\[0\]]

set_property LOC E15 [ get_ports pfs_cmd_nxt\[1\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_cmd_nxt\[1\]]

set_property LOC G30 [ get_ports pfs_cmd_nxt\[2\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_cmd_nxt\[2\]]

set_property LOC C30 [ get_ports pfs_cmd_nxt\[3\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_cmd_nxt\[3\]]

set_property LOC F21 [ get_ports pfs_cmd_nxt\[4\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_cmd_nxt\[4\]]

set_property LOC C19 [ get_ports pfs_cmd_nxt\[5\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_cmd_nxt\[5\]]


set_property LOC E14 [ get_ports pfs_clk_nxt\[0\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_clk_nxt\[0\]]

set_property LOC H30 [ get_ports pfs_clk_nxt\[1\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_clk_nxt\[1\]]

set_property LOC D29 [ get_ports pfs_clk_nxt\[2\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_clk_nxt\[2\]]

set_property LOC B28 [ get_ports pfs_clk_nxt\[3\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_clk_nxt\[3\]]

set_property LOC E21 [ get_ports pfs_clk_nxt\[4\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_clk_nxt\[4\]]

set_property LOC B19 [ get_ports pfs_clk_nxt\[5\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_clk_nxt\[5\]]


set_property LOC H14 [ get_ports pfs_resp_nxt\[0\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_resp_nxt\[0\]]

set_property LOC G14 [ get_ports pfs_resp_nxt\[1\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_resp_nxt\[1\]]

set_property LOC F15 [ get_ports pfs_resp_nxt\[2\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_resp_nxt\[2\]]

set_property LOC E16 [ get_ports pfs_resp_nxt\[3\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_resp_nxt\[3\]]

set_property LOC F12 [ get_ports pfs_resp_nxt\[4\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_resp_nxt\[4\]]

set_property LOC E13 [ get_ports pfs_resp_nxt\[5\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_resp_nxt\[5\]]


set_property LOC L16 [ get_ports pfs_rclk_nxt\[0\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rclk_nxt\[0\]]

set_property LOC K16 [ get_ports pfs_rclk_nxt\[1\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rclk_nxt\[1\]]

set_property LOC L15 [ get_ports pfs_rclk_nxt\[2\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rclk_nxt\[2\]]

set_property LOC K15 [ get_ports pfs_rclk_nxt\[3\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rclk_nxt\[3\]]

set_property LOC K13 [ get_ports pfs_rclk_nxt\[4\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rclk_nxt\[4\]]

set_property LOC J13 [ get_ports pfs_rclk_nxt\[5\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rclk_nxt\[5\]]


set_property LOC D26 [ get_ports pfs_psu_en\[0\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_psu_en\[0\]]

set_property LOC C26 [ get_ports pfs_psu_en\[1\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_psu_en\[1\]]

set_property LOC G29 [ get_ports pfs_psu_en\[2\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_psu_en\[2\]]

set_property LOC F30 [ get_ports pfs_psu_en\[3\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_psu_en\[3\]]

set_property LOC B30 [ get_ports pfs_psu_en\[4\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_psu_en\[4\]]

set_property LOC A30 [ get_ports pfs_psu_en\[5\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_psu_en\[5\]]

# LEDS used to show rx_errs
set_property PACKAGE_PIN AB8 [ get_ports pfs_rx_err\[0\]]
set_property IOSTANDARD LVCMOS15 [ get_ports pfs_rx_err\[0\]]

set_property PACKAGE_PIN AA8 [ get_ports pfs_rx_err\[1\]]
set_property IOSTANDARD LVCMOS15 [ get_ports pfs_rx_err\[1\]]

set_property PACKAGE_PIN AC9 [ get_ports pfs_rx_err\[2\]]
set_property IOSTANDARD LVCMOS15 [ get_ports pfs_rx_err\[2\]]

set_property PACKAGE_PIN AB9 [ get_ports pfs_rx_err\[3\]]
set_property IOSTANDARD LVCMOS15 [ get_ports pfs_rx_err\[3\]]

set_property PACKAGE_PIN AE26 [ get_ports pfs_rx_err\[4\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rx_err\[4\]]

set_property PACKAGE_PIN G19 [ get_ports pfs_rx_err\[5\]]
set_property IOSTANDARD LVCMOS25 [ get_ports pfs_rx_err\[5\]]