# Top Level Design Parameters

# Clocks

create_clock -name {clk_prv} -period 62.500000 -waveform {0.000000 31.250000} clk_prv
create_clock -name {rclk_nxt} -period 62.500000 -waveform {0.000000 31.250000} rclk_nxt
create_clock -name {clk_1m} -period 1000.000000 -waveform {0.000000 500.000000} clk_1m_gen/out_clk:Q

# False Paths Between Clocks


# False Path Constraints


# Maximum Delay Constraints


# Multicycle Constraints


# Virtual Clocks
# Output Load Constraints
# Driving Cell Constraints
# Wire Loads
# set_wire_load_mode top

# Other Constraints
