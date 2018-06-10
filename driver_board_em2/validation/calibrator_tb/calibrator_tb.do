#!/usr/bin/tclsh
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

do_compile ../../src/pfs_pkgs.v ../../src/pfs_bus_master.v ../../src/pfs_bus.v ../../src/calibrator.v ../../src/cal_norm.v ../../src/divider.v

do_compile ../../src/mm_states.v ../../src/mm_throttle.v ../../src/mm_col_control.v ../../src/mm_bus_read.v ../../src/mm_bus_write.v ../../src/motor_driver.v ../../src/motor_mux.v 

do_compile ../../src/adc_current_if.v ../../src/ad7265.v

do_compile ../ad7265_tb/ad7265_sim.v

do_compile ./calibrator_tb.v

vsim work.calibrator_tb

set_context / "TOP"
logic clk_16m "Clk 16m"
logic start "start"
logic rst "rst"
logic current_sense "Current Sense"
logic phase_a_h "ph A High"
logic phase_a_l "ph A Low"
logic phase_b_h "ph B High"
logic phase_b_l "ph B Low"
logic col_en "Column Enable"
logic soft_rst "Soft Reset"
div

#set_context /bus_master "Bus Master"
#uint regbank "Regbank"
#div

#set_context /bus "Bus"
#logic rd_req "Rd Req"
#logic rd_gnt "Rd Grant"
#div

set_context /calib "Calibrator"
logic state "State"
logic rd_req "Rd Req"
logic rd_gnt "rd Grant"
logic run_bit "Run Bit"
uint col_finished_cnt "Column Count"
uint row "Row"
uint col "Col"
uint peak_adc_val "Peak ADC Value"
uint peak_period "Peak Period"
uint norm_adc_val "Normalized ADC Value"
hex enabled_motors "Motor enables"
logic sample_adc "Sample ADC"
logic col_finished "Col Finished"
logic mux_ready "Mux Ready"
logic adc_ctrl "Adc Ctrl"
div

set_context /current_if "Current If"
logic state "State"
logic rd_req "Rd Req"
logic rd_gnt "Rd Gnt"
hex row_rdy "Row Ready"
uint cal_row "Cal Row"
logic motor_going "Motor Going"
uint state_count "Sample Count"
uint accum "Accum"
uint adc_data "Adc Data"
uint adc_sum "Adc Sum out"
uint addr "Adc Addr"
div

set_context /current_if/ad7265 "Ad7265 Ctrlr"
#logic clock "Clock"
logic state "State"
uint count "Count"
uint addr "Address"
logic req "Sample Request"
logic rdy "Sample Ready"
uint data_a "Data A"
uint data_b "Data B"
#logic douta "sdata A"
#logic doutb "sdata B"
#logic adc_sclk_en "Sclk En"
#logic ncs "ADC nCS"
#logic rng "ADC Range"
#logic sgl "ADC single-ended"
div

set_context /simulator "Adc Sim"
logic adc_sclk "Adc Sclk"
logic ncs "CSn"
uint count "Count"
hex data_a_reg "Data A Reg"
hex data_b_reg "Data B Reg"
hex din_a "Din A"
hex din_b "Din B"
uint adc_addr "Adc Addr"
div


run -all
wave zoom full

# vim: set syntax=tcl:

