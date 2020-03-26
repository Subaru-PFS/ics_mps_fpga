puts stderr "connecting to hw_server at HW_HOST=$env(HW_HOST)"
connect -url tcp:$env(HW_HOST):3121

puts "found on JTAG bus:"
puts [targets]

puts "uploading hardware design: $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/block_design_wrapper_hw_platform_0/download.bit"
targets -set -filter {level==0} -index 0
fpga -file $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/block_design_wrapper_hw_platform_0/download.bit

puts "resetting processor...."
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"} -index 0
rst -processor

puts stderr "uploading HLS image: $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/pfs_ctrlr/Release/pfs_ctrlr.elf"
dow $env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk/pfs_ctrlr/Release/pfs_ctrlr.elf
con
