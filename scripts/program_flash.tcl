#-------------------------------------------------------------------------------
#-- Program download.bit file in a FLASH memory
#--
#-- Steps:     
#--     1. creating a download.bit from a hardware bit file and an application 
#--        elf file.
#--     2. creating a bootable bin file from the download.bit (specified in a 
#--        .bif boot image file)  
#--     3. programming bootable bin in FLASH.
#-------------------------------------------------------------------------------

#-- paths  
set sdk_path "$env(ICS_MPS_FPGA_DIR)/pfs_ctrlr/pfs_ctrlr.sdk"
set hp_path "$sdk_path/block_design_wrapper_hw_platform_0"
set app_path "$sdk_path/pfs_ctrlr/Release"
set cache_path "$hp_path/cache"

#-- input files
set in_bit "block_design_wrapper.bit"
set in_mmi "block_design_wrapper.mmi"
set in_elf "pfs_ctrlr.elf"

#-- output files
# Should come from `git describe` or MAJOR.MINOR in .h file.
set ver "_v2.0"
set out_bit "download$ver.bit"
set out_bif "bootimage$ver.bif"
set out_bin "BOOT$ver.bin"

set flash_mode "28f00ap30t-bpi-x16"
set design_proc "block_design_i/microblaze_0"

#-- step 1: create download.bit
puts "creating $out_bit file"
exec updatemem -force -meminfo $hp_path/$in_mmi -bit $hp_path/$in_bit -data $app_path/$in_elf -proc $design_proc -out $hp_path/$out_bit

#-- step 2: create bootable bin file 
#---- 2.1 create a boot image file (.bif)
puts "creating $out_bif file"
set fp [open "$cache_path/$out_bif" w+]
puts $fp "the_ROM_image:\n{\n$hp_path/$out_bit\n}\n"
close $fp 

#---- 2.2 create bootable bin file by bootgen tool
puts "creating $out_bin file"
exec bootgen -arch fpga -image "$cache_path/$out_bif" -w -o "$cache_path/$out_bin" -interface bpix16 

#-- step 3: program bootable bin file in FLASH
#---- connect target
puts "connecting to target FPGA"
connect -url tcp:$env(HW_HOST):3121

#---- set target
puts "selecting target device"
targets -set -filter {level==0} -index 0

#---- program bin file in flash
puts "programming flash"
exec program_flash -f "$cache_path/$out_bin" -flash_type $flash_mode -verify -cable type xilinx_tcf url tcp:$env(HW_HOST):3121

