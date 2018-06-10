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

module comm #(
    parameter WIDTH = 16,
    parameter DEPTH = 8
) (
    /* Control signals */
    input   logic   reset,  ///< Reset
    input   logic   clock,  ///< Main clock

    /* Rx subsystem */
    input   logic   sin_clock, ///< Serial clock
    input   logic   sin,    ///< Serial input
    input   logic   rx_rd,  ///< Read RX data
    output  logic   rx_val, ///< RX data is valid
    output  logic   rx_full,    ///< RX FIFO is full
    output  logic   [(WIDTH-1):0] rx_data,  ///< RX data

    /* Tx subsystem */
    input   logic   [(WIDTH-1):0] tx_data,  ///< TX data
    input   logic   tx_wr,  ///< Queue TX data
    output  logic   tx_rdy, ///< OK to queue TX data
    input   logic   sout_clock, ///< Serial clock
    output  logic   sout    ///< Serial output
);

// DES to FIFO bus
logic [(WIDTH-1):0] des_to_fifo;
// FIFO to SER bus
logic [(WIDTH-1):0] fifo_to_ser;

// RX FIFO is empty
logic rx_empty;
// TX FIFO is full
logic tx_full;
// TX FIFO is empty
logic tx_empty;

// Write into the RX FIFO
logic rx_fifo_wr;

// Serializer ready for new data
logic ser_rdy;

logic z1_tx_fifo_rd;

// Read from the TX FIFO only if it isn't empty *and* the serializer is ready
// for new data
wire tx_fifo_rd = ser_rdy & !tx_empty;

// RX data is valid any time the RX fifo isn't empty
assign rx_val = ~rx_empty;

// Can TX as long as the FIFO isn't full
assign tx_rdy = ~tx_full;

// Output of fifo shows up a cycle after requesting it
always_ff @(posedge sout_clock) begin
    z1_tx_fifo_rd <= tx_fifo_rd;
end

// Not much to this.  It's just a SERDES with input and output FIFOs.

deserializer #(
    .TXN_SZ(WIDTH)
) rx (
    .clock(sin_clock),
    .reset(reset),
    .sin(sin),
    .nd(rx_fifo_wr),    // Any time new data comes in, try to write into the fifo
    .data(des_to_fifo)
);

fifo #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
) rx_fifo (
    .reset(reset),
    .full(rx_full),
    .empty(rx_empty),
    
    .wrclock(sin_clock),
    .din(des_to_fifo),
    .wr(rx_fifo_wr),
    
    .rdclock(clock),
    .rd(rx_rd),
    .dout(rx_data)
);

fifo #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
) tx_fifo (
    .reset(reset),
    .full(tx_full),
    .empty(tx_empty),

    .wrclock(clock),
    .din(tx_data),
    .wr(tx_wr),
    
    .rdclock(sout_clock),
    .rd(tx_fifo_rd),
    .dout(fifo_to_ser)
);

serializer #(
    .TXN_SZ(WIDTH)
) tx (
    .clock(sout_clock),
    .reset(reset),
    .data(fifo_to_ser),
    .nd(z1_tx_fifo_rd),
    .sout(sout),
    .rdy(ser_rdy)
);

endmodule

/* vim: set syntax=systemverilog: */
