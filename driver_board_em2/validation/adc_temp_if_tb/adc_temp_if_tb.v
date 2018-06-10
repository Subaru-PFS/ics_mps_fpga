/*********************************************************************
 * \file
 * \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
 * \brief
 *
 * \copyright
 * Copyright 2009-2014, by the California Institute of Technology.
 * ALL RIGHTS RESERVED.  United States Government Sponsorship
 * acknowledged. Any commercial use must be negotiated with the Office
 * of Technology Transfer at the California Institute of Technology.
 * \copyright
 * This software may be subject to U.S. export control laws and
 * regulations.  By accepting this document, the user agrees to comply
 * with all U.S. export laws and regulations.  User has the
 * responsibility to obtain export licenses, or other export authority
 * as may be required before exporting such information to foreign
 * countries or providing access to foreign persons.
 ********************************************************************/

`timescale 1ns/100ps

import PFS::*;

module adc_if_tb();

localparam  CLK_2 = 25,
            CLK = 2*CLK_2,
            CLK_1M_2 = 500,
            CLK_1M = 2*CLK_1M_2,
            RESET = 50*CLK,
            START = 1100*CLK,
            DONE = 100_000*CLK;
            

logic clock = 0;
logic clock_1m = 0;
logic reset = 1;

logic soft_reset;

logic [11:0] din_a [0:7] = '{0, 'h012, 'h345, 'h678, 'h9ab, 'hcde, 'hf01, 0};
logic [11:0] din_b [0:7] = '{0, 'hfed, 'hcba, 'h987, 'h654, 'h321, 'h0fe, 0};

logic douta, doutb;

logic [2:0] adc_addr;

logic adc_sclk;
logic ncs;
logic rng;
logic sgl;

// The register bank
pfs_bus #(
    .NSLV(1)
) bus (
    .clock(clock),
    .reset(reset)
);

pfs_bus_master #(
    .NSLV(1)
) bus_master (
    .bus(bus),
    .soft_reset(soft_reset)
);

adc_temps_if DUT (
    .bus(bus),
    .clock_1mhz(clock_1m),
    .soft_reset(soft_reset),
    .douta(douta),
    .doutb(doutb),
    .adc_sclk(adc_sclk),
    .adc_addr(adc_addr),
    .ncs(ncs),
    .rng(rng)
);

ad7265_sim simulator (
    .din_a(din_a),
    .din_b(din_b),
    .adc_sclk(adc_sclk),
    .douta(douta),
    .doutb(doutb),
    .adc_addr(adc_addr),
    .ncs(ncs),
    .rng(rng)
);

col_addr_t col;
row_addr_t row;


initial begin
    #(10*CLK);
    bus_master.regbank = '{1024{16'd0}};
end



initial begin
    fork
        forever #CLK_2 clock = ~clock;
        forever #CLK_1M_2 clock_1m = ~clock_1m;
        #RESET reset = 0;
       
        #DONE $stop;
    join
end

endmodule

/* vim: set syntax=systemverilog: */
