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

///////////////////////////////////////////////////////////////////////////////
//% 
//% 
//% 
//%
//%
//%
///////////////////////////////////////////////////////////////////////////////

module roundrobin_mux #(
    parameter WIDTH = 16,
    parameter DEPTH = 8,
    parameter MUXIN = 2
) (
    input   logic             clock,          ///< Input clock
    input   logic             reset,          ///< Active-high reset
    input   logic [WIDTH-1:0] din [0:MUXIN-1],
    input   logic             nd  [0:MUXIN-1],
    output  logic [WIDTH-1:0] dout,
    output  logic             dval
);

enum {
    RESET,
    IDLE,
    READ
} state, next_state;

logic [  MUXIN-1:0] fifo_empty;

logic [$clog2(MUXIN)-1:0] fifo_idx, next_fifo_idx, idx;
integer i;  // 32-bits... only an idiot would try to mux 2**32 inputs

logic [MUXIN-1:0] rd;
logic [WIDTH-1:0] fifo_dout [0:MUXIN-1];

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= RESET;
        fifo_idx <= MUXIN-1;
    end else begin
        state <= next_state;
        fifo_idx <= next_fifo_idx;
    end
end

always_comb begin
    if (reset) begin
        next_state = IDLE;
        next_fifo_idx = MUXIN-1;
    end else begin
        next_state = IDLE;
        next_fifo_idx = fifo_idx;

        if (state != RESET) begin
            for (i = 0, idx = fifo_idx; i < MUXIN; i = i + 1,
                        idx = (idx == 0) ? MUXIN-1 : idx - 1) begin
                if (!fifo_empty[idx]) begin
                    next_fifo_idx = idx;
                    next_state = READ;
                end
            end
        end
    end
end

always_comb begin
    rd = 0;
    rd[fifo_idx] = (state == READ);
end

always_ff @(posedge clock) begin
    dval <= 0;
    if (state == READ) begin
        dval <= ~fifo_empty[fifo_idx];
    end
end

assign dout = fifo_dout[fifo_idx];

genvar j;
generate for (j = 0; j < MUXIN; j = j + 1) begin: FIFOS
    fifo #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) fifo (
        .wrclock(clock),
        .rdclock(clock),
        .reset(reset),
        .din(din[j]),
        .wr(nd[j]),
        .rd(rd[j]),
        .dout(fifo_dout[j]),
        .full( /* NC */ ),
        .empty(fifo_empty[j])
    );
end
endgenerate

endmodule

/* vim: set syntax=systemverilog: */
