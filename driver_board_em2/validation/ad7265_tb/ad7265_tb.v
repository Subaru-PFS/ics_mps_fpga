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

`timescale 1ns/10ps 
 
module ad7265_tb;

localparam  CLK_2 = 31.25,
            CLK = 2*CLK_2,
            RESET = 25*CLK,
            DONE = 1000*CLK;

logic clk = 0;
logic rst = 1;

initial begin
    fork
        forever #CLK_2 clk = ~clk;
        #RESET rst = 0;
        #DONE $stop();
    join
end

wire adc_a;
wire adc_b;
wire adc_rng;
wire adc_sclk;
wire adc_ncs;
wire [2:0] adc_addr;

logic req = 0;
logic [2:0] addr = 0;
wire rdy;
wire [11:0] data_a;
wire [11:0] data_b;



logic [11:0] adc_vals_a [0:7] = {0, 'h012, 'h345, 'h678, 'h9ab, 'hcde, 'hf01, 0};
logic [11:0] adc_vals_b [0:7] = {0, 'hfed, 'hcba, 'h987, 'h654, 'h321, 'h0fe, 0};

ad7265 DUT (
    .clk(clk),
    .rst(rst),
    
    .req(req),
    .addr(addr),
    .rdy(rdy),
    .data_a(data_a),
    .data_b(data_b),
    
    .adc_sclk(adc_sclk),
    .adc_ncs(adc_ncs),
    .adc_addr(adc_addr),
    .adc_rng(adc_rng),
    .adc_a(adc_a),
    .adc_b(adc_b)
    
);

ad7265_sim simulator (
    .din_a(adc_vals_a),
    .din_b(adc_vals_b),
    
    .adc_sclk(adc_sclk),
    .adc_addr(adc_addr),
    .ncs(adc_ncs),
    .rng(adc_rng),
    
    .douta(adc_a),
    .doutb(adc_b)
);

initial begin
    req = 1;
    
    forever begin
        @ (posedge rdy) begin
            addr <= addr + 1;
        end
    end
end


endmodule

/* vim: set syntax=systemverilog: */
