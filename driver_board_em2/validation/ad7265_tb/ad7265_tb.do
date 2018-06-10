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


do_compile ./ad7265_tb.v ./ad7265_sim.v ../../src/ad7265.v

vsim -L a3pe work.ad7265_tb

set_context /DUT "DUT USER I/F"
logic clk "clk"
logic rst "rst"
logic req "req"
logic rdy "rdy"
uint addr "Addr"
hex data_a "Data A"
hex data_b "Data B"
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

set_context /DUT "DUT Internal"
logic slow_clk "Slow Clk"
logic state "State"
logic next_state "Nxt State"
logic valid_addr "Val Addr"
uint counter "Counter"
hex sreg_a "Sreg A"
hex sreg_b "Sreg B"
logic sclk_en "Sclk En"
div

run -all
wave zoom full

# vim: set syntax=tcl:
