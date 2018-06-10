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
            RESET = 50*CLK,
            START = 1100*CLK,
            DONE = 100_000*CLK;

logic clock = 0;
logic reset = 1;

logic soft_reset;

logic [15:0] adc_sum;

logic [11:0] din_a [0:5] = '{'h012, 'h345, 'h678, 'h9ab, 'hcde, 'hf01};
logic [11:0] din_b [0:5] = '{'hfed, 'hcba, 'h987, 'h654, 'h321, 'h0fe};

logic douta, doutb;

logic [2:0] adc_addr;

logic adc_sclk_en;
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

adc_current_if DUT (
    .bus(bus),
    .soft_reset(soft_reset),
    .adc_sum(adc_sum),
    .douta(douta),
    .doutb(doutb),
    .adc_sclk_en(adc_sclk_en),
    .adc_addr(adc_addr),
    .ncs(ncs),
    .rng(rng),
    .sgl(sgl)
);

ad7265_sim simulator (
    .din_a(din_a),
    .din_b(din_b),
    .adc_sclk(adc_sclk_en ? clock : 1'b1),
    .douta(douta),
    .doutb(doutb),
    .adc_addr(adc_addr),
    .ncs(ncs),
    .rng(rng),
    .sgl(sgl)
);

col_addr_t col;
row_addr_t row;

always_ff @(posedge bus.wr_gnt[0]) begin
    bus_master.regbank[make_wr_addr_t(ADC_ROW, ADC_COL, ADC0_CTRL_REG)] =
            bus_master.regbank[make_wr_addr_t(ADC_ROW, ADC_COL, ADC0_CTRL_REG)] + 1;
end

initial begin
    #(10*CLK);
    bus_master.regbank = '{1024{16'd0}};
end


initial begin
    fork
        forever #CLK_2 clock = ~clock;
        #RESET reset = 0;
       
        begin
            #START bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, CONTROL_REG)] = 1 << CAL_BIT;
            $display($time, "START");
            #CLK bus_master.regbank[make_wr_addr_t(CONTROL_ROW, CONTROL_COL, CONTROL_REG)] = 0;
        end
        #DONE $stop;
    join
end

endmodule

/* vim: set syntax=systemverilog: */
