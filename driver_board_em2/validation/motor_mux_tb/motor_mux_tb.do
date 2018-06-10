######################################################################
# \file
# \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
# \brief
#
# \copyright
# Copyright 2009-2014, by the California Institute of Technology.
# ALL RIGHTS RESERVED.  United States Government Sponsorship
# acknowledged. Any commercial use must be negotiated with the Office
# of Technology Transfer at the California Institute of Technology.
# \copyright
# This software may be subject to U.S. export control laws and
# regulations.  By accepting this document, the user agrees to comply
# with all U.S. export laws and regulations.  User has the
# responsibility to obtain export licenses, or other export authority
# as may be required before exporting such information to foreign
# countries or providing access to foreign persons.
######################################################################

source ../utils.do

set_vlog_args +incdir+../../src
do_compile ../../src/pfs_pkgs.v ../../src/mm_states.v ../../src/pfs_bus.v ./motor_mux_tb.v ../../src/motor_mux.v ../../src/motor_driver.v ../../src/pfs_bus_master.v ../../src/mm_bus_read.v ../../src/mm_bus_write.v ../../src/mm_throttle.v ../../src/mm_col_control.v

vsim -debugDB -fsmdebug work.motor_mux_tb

set_context / "TOP"

logic clock_16mhz "16MHz Clock"
logic clock_1mhz "1MHz Clock"
logic reset "Reset"
logic run "Run"
logic ready "Ready"
#logic ph_a_h "Phase A Hi"
#logic ph_a_l "Phase A Lo"
#logic ph_b_h "Phase B Hi"
#logic ph_b_l "Phase B Lo"
logic col_en "Col Enable"
logic col_finished "Col Finished"

set_context /bus_master "Bus Master"
uint regbank "Registers"
uint local_rd_data "Local read data"
uint bus/rd_addr "Read addresses"
uint rd_idx "Read index"

set_context /DUT "DUT"
logic state "State"
uint col "Col"
logic start_mux "Start mux"
logic start_motors "Start motors"
logic move_finished "Move finished"
logic col_done "Column done"
uint  subcol_idx "Subcolumn"
logic subcol_done "Subcolumn done"
logic row_ready "Row ready"
logic throttle_done "Throttle done"
logic update_counts_done "Count Update done"
uint step_len "Step lengths"
uint num_steps "### Steps"
uint num_sleeps "### Sleeps"
uint subcol_idx "Subcolumn index"
uint mm_bus_read/bus_txn_idx "Bus read transaction index"
hex  mm_bus_read/setup_regs "Setup registers"
uint mm_bus_read/motor_regs "Motor registers"

set_context /DUT/mm_bus_read "Bus"
uint rd_addr "RD Addr"
uint rd_data "RD Data"
logic rd_req "RD REQ"
logic rd_gnt "RD GNT"

set_top /DUT/mm_bus_write
uint wr_addr "WR Addr"
uint wr_data "WR Data"
logic wr_req "WR REQ"
logic wr_gnt "WR GNT"

set_contex /DUT/mm_bus_write "MM Bus Write"
logic motor_en "Motor Enabled"
logic motor_has_sleeps "Has Sleeps"
logic motor_has_steps "Has Steps"
logic more_sleeps "More Sleeps"
logic more_steps "More Steps"
uint row "row"

#uint pulse_period "Pulse period"
#uint num_pulse "Number of pulses"
#uint num_wait "Number of wait cycles"
#uint num_step "Number of steps"

#set_context /DUT "Device"
#logic in_a_quad "A quadrants"
#logic in_b_quad "B quadrants"
#uint ph_thresh\[0\] "Phase Thr 0"
#uint ph_thresh\[1\] "Phase Thr 1"
#uint ph_thresh\[2\] "Phase Thr 2"
#uint div_count    "Clock divider"

for {set i 0} {$i < 16} {incr i} {
    div

    set_context /DUT/DRIVERS\[$i\]/motor_driver "Driver $i"
    logic clock_1mhz "1MHz Clock"
    logic state "State"
    logic start "Start"
    logic ready "Ready"
    logic ph_a_h "Phase A Hi"
    logic ph_a_l "Phase A Lo"
    logic ph_b_h "Phase B Hi"
    logic ph_b_l "Phase B Lo"
    uint pulse_period "Pulse Period"
    uint pulse_len "Pulse length \[us\]"
}

log -r /*
run -all
wave zoom full

# vim: set syntax=tcl:
