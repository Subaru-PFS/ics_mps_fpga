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

//`include "version.vh"
localparam VERSION = 20;

import PFS::*;

module pfs_bus_master #(
    parameter NSLV = 2          ///< Number of slaves on the bus
) (
    pfs_bus.master bus,         ///< The bus interface
    output logic soft_reset    ///< A generated soft reset signal (picked off from one register bit)
);

// Bus aliases
wire clock = bus.clock;
wire reset = bus.reset;

logic [SOFT_RESET_DUR-1:0] soft_reset_sr;
logic do_reset;

integer i, j, idx, row;

// The registers
pfs_reg_t regbank [MOTOR_ROWS*MOTOR_COLS*REGS_PER_MOTOR];

logic [WR_AWIDTH-1:0] reset_reg_count;

rd_data_t local_rd_data;
rd_addr_t z1_rd_addr;

logic [$clog2(NSLV)-1:0] rd_idx;
logic [$clog2(NSLV)-1:0] wr_idx;

logic [$clog2(NSLV)-1:0] rd_prio [NSLV-1:0];
logic [$clog2(NSLV)-1:0] wr_prio [NSLV-1:0];

assign soft_reset = |soft_reset_sr;

always_ff @(posedge clock) begin
    if (reset) begin
        for (j = 0; j < NSLV; j = j + 1) begin
            rd_prio[j] <= j;
            wr_prio[j] <= j;
        end
    end else begin
        if (|bus.wr_gnt) begin
            for (j = 0, idx = wr_idx; j < NSLV; j = j + 1,
                        idx = (idx == 0) ? NSLV-1: idx - 1) begin
                wr_prio[j] <= idx;
            end
        end
        if (|bus.rd_gnt) begin
            for (j = 0, idx = rd_idx; j < NSLV; j = j + 1,
                        idx = (idx == 0) ? NSLV-1: idx - 1) begin
                rd_prio[j] <= idx;
            end
        end
    end
end

always_comb begin
    if (reset) begin
        bus.rd_gnt = 0;
        bus.wr_gnt = 0;

        rd_idx = 0;
        wr_idx = 0;
    end else begin
        bus.rd_gnt = 0;
        bus.wr_gnt = 0;

        rd_idx = 0;
        wr_idx = 0;

        for (i = 0; i < NSLV; i = i + 1) begin
            if (bus.wr_req[wr_prio[i]]) begin
                wr_idx = wr_prio[i];
                bus.wr_gnt = 1 << wr_idx;
            end
        end

        for (i = 0; i < NSLV; i = i + 1) begin
            if (bus.rd_req[rd_prio[i]]) begin
                rd_idx = rd_prio[i];
                bus.rd_gnt = 1 << rd_idx;
            end
        end
    end
end

always_ff @(posedge clock) begin
    if (reset) begin
        do_reset <= 1;
        reset_reg_count <= 0;
        local_rd_data <= 0;
        soft_reset_sr <= 0;
        
    end else begin
        // Reset logic for the register bank.  We can't wipe these all at once,
        // so once a reset is triggered, start looping through all the registers
        // and setting them all back to 0.
        if (do_reset) begin
            regbank[reset_reg_count] <= 0;
            reset_reg_count <= reset_reg_count + 1;
            if (reset_reg_count == MOTOR_ROWS*MOTOR_COLS*REGS_PER_MOTOR - 1) begin
                do_reset <= 0;
            end
        end else begin
            z1_rd_addr <= bus.rd_addr[rd_idx];
            soft_reset_sr <= soft_reset_sr << 1;

            if (|bus.wr_gnt) begin
                regbank[bus.wr_addr[wr_idx]] <= bus.wr_data[wr_idx];

                // If we're writing into the control register...
                if (bus.wr_addr[wr_idx] == {CONTROL_ROW, CONTROL_COL, CONTROL_REG}) begin
                    // Check for the soft reset bit
                    if (bus.wr_data[wr_idx][SOFT_RESET_BIT]) begin
                        soft_reset_sr[0] <= 1;
                    end

                end
            end

            for (row = 0; row < MOTOR_ROWS; row = row + 1) begin
                local_rd_data[row] <= regbank[wr_addr_from_rd_addr(
                    bus.rd_addr[rd_idx], row)];
            end

            // Final override; if resetting, blow away the soft reset shift reg
            if (reset) begin
                soft_reset_sr <= 0;
            end
        end
    end
end

// Tie the data read out of the register bank to the output
always_comb begin
    // If we're still resetting, always output a zero.  Otherwise, output the
    // locally read-back data
    bus.rd_data = do_reset ? 0 : local_rd_data;

    // If we're reading out the version number or the final enable register,
    // take care of the fact that these have some read-only bits.  Override.
    case (z1_rd_addr)
      make_rd_addr_t(CONTROL_COL, VERSION_REG):       bus.rd_data[CONTROL_ROW] = VERSION;
      make_rd_addr_t(CONTROL_COL, MOTOR_ENABLE_REG3): bus.rd_data[CONTROL_ROW] = bus.rd_data[CONTROL_ROW] & 'h7fff;
    endcase
end

// regbank[VERSION_REG][CONTROL_COL][CONTROL_ROW] <= VERSION;

endmodule

/* vim: set syntax=systemverilog: */
