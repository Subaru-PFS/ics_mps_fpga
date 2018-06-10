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

module fifo #(
    parameter WIDTH = 8,    ///< Data width
    parameter DEPTH = 8     ///< FIFO depth
) (
    input   logic   wrclock,  ///< Write clock
    input   logic   rdclock,  ///< Read clock
    input   logic   reset,  ///< Active-high reset
    input   logic   [(WIDTH-1):0] din,  ///< Data to write
    input   logic   wr,                 ///< Write data into FIFO
    input   logic   rd,                 ///< Read data from FIFO
    output  logic   [(WIDTH-1):0] dout, ///< Data read back from FIFO
    output  logic   full,               ///< Is the FIFO full?
    output  logic   empty               ///< Is the FIFO empty?
);

// For now we don't support chaining primatives
initial begin
    assert(DEPTH <= 256);
end

localparam PRIM_FIFO_WIDTH = 18;

localparam NUM_FIFOS = (WIDTH + PRIM_FIFO_WIDTH - 1)/PRIM_FIFO_WIDTH;

logic [(NUM_FIFOS*PRIM_FIFO_WIDTH)-1:0] wr_data;
logic [(NUM_FIFOS*PRIM_FIFO_WIDTH)-1:0] rd_data;

logic [NUM_FIFOS-1:0] full_int;
logic [NUM_FIFOS-1:0] empty_int;

assign wr_data = din;
assign dout = rd_data;

assign full = |full_int;
assign empty = |empty_int;

genvar i;
generate for (i = 0; i < NUM_FIFOS; i = i + 1) begin: BUILD_FIFOS

    FIFO4K18 primative (
        /* 512 x 18bits */
        .RW2(1'b1),
        .RW1(1'b0),
        .RW0(1'b0),
        .WW2(1'b1),
        .WW1(1'b0),
        .WW0(1'b0),
        /* Stop counting if full or empty */
        .ESTOP(1'b1),
        .FSTOP(1'b1),
        /* Almost empty: 0 */
        .AEVAL11(1'b0),
        .AEVAL10(1'b0),
        .AEVAL9(1'b0),
        .AEVAL8(1'b0),
        .AEVAL7(1'b0),
        .AEVAL6(1'b0),
        .AEVAL5(1'b0),
        .AEVAL4(1'b0),
        .AEVAL3(1'b0),
        .AEVAL2(1'b0),
        .AEVAL1(1'b0),
        .AEVAL0(1'b0),
        /* Almost full: 0 */
        .AFVAL11(1'b0),
        .AFVAL10(1'b0),
        .AFVAL9(1'b0),
        .AFVAL8(1'b0),
        .AFVAL7(1'b0),
        .AFVAL6(1'b0),
        .AFVAL5(1'b0),
        .AFVAL4(1'b0),
        .AFVAL3(1'b0),
        .AFVAL2(1'b0),
        .AFVAL1(1'b0),
        .AFVAL0(1'b0),
        /* Active-high read enable */
        .REN(rd),
        /* Active-high read disable */
        .RBLK(1'b0),
        /* Read clock */
        .RCLK(rdclock),
        /* Write data */
        .WD17(wr_data[i*PRIM_FIFO_WIDTH + 17]),
        .WD16(wr_data[i*PRIM_FIFO_WIDTH + 16]),
        .WD15(wr_data[i*PRIM_FIFO_WIDTH + 15]),
        .WD14(wr_data[i*PRIM_FIFO_WIDTH + 14]),
        .WD13(wr_data[i*PRIM_FIFO_WIDTH + 13]),
        .WD12(wr_data[i*PRIM_FIFO_WIDTH + 12]),
        .WD11(wr_data[i*PRIM_FIFO_WIDTH + 11]),
        .WD10(wr_data[i*PRIM_FIFO_WIDTH + 10]),
        .WD9(wr_data[i*PRIM_FIFO_WIDTH + 9]),
        .WD8(wr_data[i*PRIM_FIFO_WIDTH + 8]),
        .WD7(wr_data[i*PRIM_FIFO_WIDTH + 7]),
        .WD6(wr_data[i*PRIM_FIFO_WIDTH + 6]),
        .WD5(wr_data[i*PRIM_FIFO_WIDTH + 5]),
        .WD4(wr_data[i*PRIM_FIFO_WIDTH + 4]),
        .WD3(wr_data[i*PRIM_FIFO_WIDTH + 3]),
        .WD2(wr_data[i*PRIM_FIFO_WIDTH + 2]),
        .WD1(wr_data[i*PRIM_FIFO_WIDTH + 1]),
        .WD0(wr_data[i*PRIM_FIFO_WIDTH + 0]),
        /* Active-low write enable */
        .WEN(~wr),
        /* Active-high write block */
        .WBLK(1'b0),
        /* Write clock */
        .WCLK(wrclock),
        /* No output register on read */
        .RPIPE(1'b0),
        /* Active-low reset */
        .RESET(~reset),
        /* Read data */
        .RD17(rd_data[i*PRIM_FIFO_WIDTH + 17]),
        .RD16(rd_data[i*PRIM_FIFO_WIDTH + 16]),
        .RD15(rd_data[i*PRIM_FIFO_WIDTH + 15]),
        .RD14(rd_data[i*PRIM_FIFO_WIDTH + 14]),
        .RD13(rd_data[i*PRIM_FIFO_WIDTH + 13]),
        .RD12(rd_data[i*PRIM_FIFO_WIDTH + 12]),
        .RD11(rd_data[i*PRIM_FIFO_WIDTH + 11]),
        .RD10(rd_data[i*PRIM_FIFO_WIDTH + 10]),
        .RD9(rd_data[i*PRIM_FIFO_WIDTH + 9]),
        .RD8(rd_data[i*PRIM_FIFO_WIDTH + 8]),
        .RD7(rd_data[i*PRIM_FIFO_WIDTH + 7]),
        .RD6(rd_data[i*PRIM_FIFO_WIDTH + 6]),
        .RD5(rd_data[i*PRIM_FIFO_WIDTH + 5]),
        .RD4(rd_data[i*PRIM_FIFO_WIDTH + 4]),
        .RD3(rd_data[i*PRIM_FIFO_WIDTH + 3]),
        .RD2(rd_data[i*PRIM_FIFO_WIDTH + 2]),
        .RD1(rd_data[i*PRIM_FIFO_WIDTH + 1]),
        .RD0(rd_data[i*PRIM_FIFO_WIDTH + 0]),
        /* Full */
        .FULL(full_int[i]),
        /* Almost full */
        .AFULL( /* NC */ ),
        /* Empty */
        .EMPTY(empty_int[i]),
        /* Almost empty */
        .AEMPTY( /* NC */ )
    );
end
endgenerate

endmodule

/* vim: set syntax=systemverilog: */
