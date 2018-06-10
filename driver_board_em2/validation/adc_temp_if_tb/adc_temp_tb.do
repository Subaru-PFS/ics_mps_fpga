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


do_compile ../../src/pfs_pkgs.v ./adc_temp_if_tb.v ../ad7265_tb/ad7265_sim.v ../../src/pfs_bus.v ../../src/pfs_bus_master.v ../../src/adc_temps_if.v ../../src/ad7265.v

vsim -L a3pe work.adc_if_tb

set_context / "RegBank"
hex bus_master/regbank\[946\] "Temp 0"
hex bus_master/regbank\[947\] "Temp 1"
hex bus_master/regbank\[948\] "VOLTAGE"
div

set_context /simulator "SIM"
logic adc_sclk "Sclk"
logic ncs "Ncs"
logic rng "Range"
uint adc_addr "Adc Addr"
logic douta "Dout A"
logic doutb "Dout B"
uint count "Count"
div

set_context /DUT "DUT"
logic clock "Clock"
logic reset "Reset"
logic state "State"
logic next_state "Next state"
uint wait_counter "Wait Counter"
logic new_capture "New Capture"
uint accum "Accumulator"
uint state_count "State count"
hex adc_data "ADC Data"
uint adc_sum "ADC Sum"
logic rdy "Rdy"
logic req "Req"
#logic wr_req "Wr Req"
#logic wr_gnt "Wr Gnt"
#hex   wr_addr "Wr Addr"
#hex   wr_data "Wr Data"
div

set_context simulator "Sim"
logic adc_sclk "SCLK"
logic ncs "nCS"
div

#set_context bus_master "Bus_Master"
#hex regbank "Reg Bank"



configure wave -namecolwidth 200
configure wave -valuecolwidth 120


run -all
wave zoom full


# vim: set syntax=tcl:

