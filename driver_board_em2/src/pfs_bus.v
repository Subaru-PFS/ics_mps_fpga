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

import PFS::*;

interface pfs_bus #(
    parameter NSLV = 2
) (
    input logic clock,
    input logic reset
);
    logic     [NSLV-1:0] wr_req;
    logic     [NSLV-1:0] wr_gnt;
    wr_addr_t [NSLV-1:0] wr_addr;
    wr_data_t [NSLV-1:0] wr_data;

    logic     [NSLV-1:0] rd_req;
    logic     [NSLV-1:0] rd_gnt;
    rd_addr_t [NSLV-1:0] rd_addr;
    rd_data_t rd_data;

    modport master (
        // Control signals
        input  clock,
        input  reset,

        // Write signals
        input  wr_addr,
        input  wr_data,
        input  wr_req,
        output wr_gnt,

        // Read signals
        input  rd_addr,
        input  rd_req,
        output rd_data,
        output rd_gnt
    );
    
    modport slave (
        // Control signals
        input  clock,
        input  reset,

        // Write signals
        input  wr_gnt,
        output wr_addr,
        output wr_data,
        output wr_req,

        // Read signals
        input  rd_data,
        input  rd_gnt,
        output rd_addr,
        output rd_req
    );

endinterface

/* vim: set syntax=systemverilog: */
