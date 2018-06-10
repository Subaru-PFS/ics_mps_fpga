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

set_vlog_args +incdir+../../src
do_compile ../../src/pfs_pkgs.v ./adc_current_if_tb.v ./ad7265_sim.v ../../src/pfs_bus.v ../../src/pfs_bus_master.v ../../src/adc_current_if.v ../../src/ad7265.v

vsim work.adc_if_tb

set_context / "TOP"

logic clock "Clock"
logic reset "Reset"
hex bus_master/regbank\[944\] "ADC Control"
hex bus/rd_addr "Bus rd address"
hex bus/rd_data "Bus rd data"
logic bus/rd_req "Bus rd req"
logic bus/rd_gnt "Bus rd gnt"

uint adc_addr "ADC Address"
uint adc_sum "ADC Sum"
hex din_a "Din A"
hex din_b "Din B"

set_context DUT "DUT"
logic state "State"
logic next_state "Next state"
uint accum "Accumulator"
hex addr "Address"
uint state_count "State count"
logic rdy "Rdy"
logic req "Req"
logic rd_req "Rd Req"
logic rd_gnt "Rd Gnt"
hex   rd_addr "Rd Addr"
hex   rd_data "Rd Data"
logic wr_req "Wr Req"
logic wr_gnt "Wr Gnt"
hex   wr_addr "Wr Addr"
hex   wr_data "Wr Data"
hex   data_a  "Data A"
hex   data_b  "Data B"

set_context simulator "Sim"
logic adc_sclk "SCLK"
logic ncs "nCS"

set_context bus_master "Bus_Master"
hex regbank "Reg Bank"

run -all
wave zoom full

# vim: set syntax=tcl:

