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

module cmd_to_bus #(
    parameter BUS_ADDR = 0,
    parameter DEPTH = 8
) (
    pfs_bus.slave bus,
    input cmd_t   cmd_in,
    input logic   new_cmd_in,

    output cmd_t  response,
    output logic  new_response
);

enum {
    RESET,
    IDLE,
    READ,
    HANDLE
} state, next_state;

// Local variables
logic rd_cmd;
cmd_t cmd;
logic tx_empty;
row_addr_t rd_row, z1_rd_row;

wr_addr_t response_regno;

// Bus aliases
logic wr_req;
logic wr_gnt;
logic rd_req;
logic rd_gnt;
rd_addr_t rd_addr;
rd_data_t rd_data;

wr_addr_t wr_addr;
wr_data_t wr_data;

wire clock = bus.clock;
wire reset = bus.reset;

// Bus aliasing
// write
assign bus.wr_req[BUS_ADDR] = wr_req;
assign wr_gnt = bus.wr_gnt[BUS_ADDR];
assign bus.wr_addr[BUS_ADDR] = wr_addr;
assign bus.wr_data[BUS_ADDR] = wr_data;

// read
assign bus.rd_req[BUS_ADDR] = rd_req;
assign bus.rd_addr[BUS_ADDR] = rd_addr;
assign rd_gnt = bus.rd_gnt[BUS_ADDR];
assign rd_data = bus.rd_data;

// Continuous assignments: the value only matters when rd_req and wr_req are
// asserted.
assign {rd_row, rd_addr} = cmd.regno;
// rd_data[rd_row]
assign wr_addr = cmd.regno;
assign wr_data = cmd.value;

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= RESET;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;

    case (state)
      RESET: next_state = IDLE;
      IDLE: next_state = tx_empty ? IDLE : READ;
      READ: next_state = HANDLE;
      HANDLE: begin
        if ((cmd.rnw && rd_gnt) || (!cmd.rnw && wr_gnt)) begin
            next_state = tx_empty ? IDLE : READ;
        end
      end
    endcase
end

assign rd_cmd = (state == READ);
assign rd_req = (state == HANDLE) && (cmd.rnw);
assign wr_req = (state == HANDLE) && (!cmd.rnw);

////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clock) begin
    if (reset) begin
        new_response <= 0;
        response_regno <= 0;
        z1_rd_row <= 0;
    end else begin
        new_response <= (rd_req & rd_gnt);
        response_regno <= cmd.regno;
        z1_rd_row <= rd_row;
    end
end

assign response = '{rnw: 1, regno: response_regno, value: rd_data[z1_rd_row]};

////////////////////////////////////////////////////////////////////////////////

fifo #(
    .WIDTH($bits(cmd)),
    .DEPTH(256)
//    .DEPTH(DEPTH)
) tx_fifo (
    .wrclock(clock),
    .rdclock(clock),
    .reset(reset),
    .din(cmd_in),
    .wr(new_cmd_in),
    .rd(rd_cmd),
    .dout(cmd),
    .full( /* NC */),
    .empty(tx_empty)
);

endmodule

/* vim: set syntax=systemverilog: */
