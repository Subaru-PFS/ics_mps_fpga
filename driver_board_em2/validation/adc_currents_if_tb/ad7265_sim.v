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

module ad7265_sim (
    input logic [11:0] din_a [0:5],
    input logic [11:0] din_b [0:5],

    input logic adc_sclk,
    input logic ncs,
    input logic rng,
    input logic sgl,
    input logic [2:0] adc_addr,

    output logic douta,
    output logic doutb
);

logic [ 5:0] count = 32;

wire [31:0] data_a_reg = {2'b0, din_a[adc_addr], 2'b0, 2'b0, din_b[adc_addr], 2'b0};
wire [31:0] data_b_reg = {2'b0, din_b[adc_addr], 2'b0, 2'b0, din_a[adc_addr], 2'b0};

assign douta = (ncs | count == 0) ? 1'bZ : data_a_reg[count - 1];
assign doutb = (ncs | count == 0) ? 1'bZ : data_b_reg[count - 1];

always_ff @(negedge ncs) begin
    count <= 32;
end

always_ff @(negedge adc_sclk) begin
    if (ncs == 0) begin
        count <= (count == 0) ? 0 : count - 1;
    end
end

endmodule

/* vim: set syntax=systemverilog: */
