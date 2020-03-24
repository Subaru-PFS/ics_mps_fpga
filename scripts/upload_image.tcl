puts stderr "connecting to hw_server at HW_HOST=$env(HW_HOST)"
connect -url tcp:$env(HW_HOST):3121

puts "uploading hardware design: $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/block_design_wrapper_hw_platform_0/download.bit"
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-SMT1 210203A030DEA" && level==0} -index 0
fpga -file $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/block_design_wrapper_hw_platform_0/download.bit
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent JTAG-SMT1 210203A030DEA"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent JTAG-SMT1 210203A030DEA"} -index 0

puts stderr "uploading HLS image: $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/pfs_ctrlr/Release/pfs_ctrlr.elf"
dow $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/pfs_ctrlr/Release/pfs_ctrlr.elf
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent JTAG-SMT1 210203A030DEA"} -index 0
con
