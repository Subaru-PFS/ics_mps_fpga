#---- connect target
puts "Resetting FPGA..." 
puts "connecting to target\n"
open_hw
connect_hw_server -verbose -url TCP:$env(HW_HOST):3121
open_hw_target -verbose
current_hw_device [get_hw_devices xc7k325t_0]

#---- set target
puts "sending reset\n"
boot_hw_device -verbose [lindex [get_hw_devices] 0]
