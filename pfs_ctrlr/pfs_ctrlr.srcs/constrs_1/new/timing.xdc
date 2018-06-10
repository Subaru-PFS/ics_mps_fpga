set_false_path -from [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/serializer/tx_cnt_reg[*]/C}] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/rd_data_reg[*]/D}]

#set_false_path -from [get_pins {block_design_i/proc_sys_reset_0/U0/ACTIVE_LOW_PR_OUT_DFF[0].peripheral_aresetn_reg[0]/C}] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/rst_pipe_reg[0]/D}]

set_false_path -from [get_pins block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/*] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/counter_roll_z_reg[0]/D}]

set_false_path -from [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/tx_fifo/FIFO_DUALCLOCK_MACRO_inst/genblk5_0.fifo_36_bl.fifo_36_bl/RDCLK}] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/status_reg_reg[*]/D}]

set_false_path -from [get_pins {block_design_i/proc_sys_reset_0/U0/ACTIVE_LOW_PR_OUT_DFF[0].peripheral_aresetn_reg[0]/C}] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/rst_pipe_reg[0]/S}]

set_false_path -from [get_pins {block_design_i/proc_sys_reset_0/U0/ACTIVE_LOW_PR_OUT_DFF[0].peripheral_aresetn_reg[0]/C}] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/rst_pipe_reg[0]/D}]

set_false_path -from [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/ser_rst_reg/C}] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/tx_fifo/FIFO_DUALCLOCK_MACRO_inst/genblk5_0.fifo_36_bl.fifo_36_bl/RST}]

set_false_path -from [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/ctrl_reg_reg[0]/C}] -to [get_pins {block_design_i/pfs_daughtercard_0/inst/genblk1[*].i_pfs_sector/rst_pipe_reg[0]/D}]