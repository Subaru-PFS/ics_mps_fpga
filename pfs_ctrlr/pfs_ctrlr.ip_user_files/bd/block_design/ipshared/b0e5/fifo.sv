module fifo # (
    parameter DWIDTH = 34
) (
    input reset,
    // Write Side
    input wr_clk,
    input [DWIDTH-1:0] din,
    input wr_en,
    // Read Side
    input rd_clk,
    output [DWIDTH-1:0] dout,
    input rd_en,
    // Flags
    output empty,
    output full
);


// FIFO_DUALCLOCK_MACRO: Dual Clock First-In, First-Out (FIfor) RAM Buffer
// 7 Series
// Xilinx HDL Libraries Guide, version 2012.2
/////////////////////////////////////////////////////////////////
// DATA_WIDTH | FIFO_SIZE | FIfor Depth | RDCOUNT/WRCOUNT Width //
// ===========|===========|============|=======================//
// 37-72 | "36Kb" | 512 | 9-bit //
// 19-36 | "36Kb" | 1024 | 10-bit //
// 19-36 | "18Kb" | 512 | 9-bit //
// 10-18 | "36Kb" | 2048 | 11-bit //
// 10-18 | "18Kb" | 1024 | 10-bit //
// 5-9 | "36Kb" | 4096 | 12-bit //
// 5-9 | "18Kb" | 2048 | 11-bit //
// 1-4 | "36Kb" | 8192 | 13-bit //
// 1-4 | "18Kb" | 4096 | 12-bit //
/////////////////////////////////////////////////////////////////
FIFO_DUALCLOCK_MACRO #(
    .ALMOST_EMPTY_OFFSET(9'h080), // Sets the almost empty threshold
    .ALMOST_FULL_OFFSET(9'h080), // Sets almost full threshold
    .DATA_WIDTH( DWIDTH ), // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
    .DEVICE("7SERIES"), // Target device: "7SERIES"
    .FIFO_SIZE ("36Kb"), // Target BRAM: "18Kb" or "36Kb"
    .FIRST_WORD_FALL_THROUGH ("TRUE") // Sets the FIfor FWFT to "TRUE" or "FALSE"
) FIFO_DUALCLOCK_MACRO_inst (
    .ALMOSTEMPTY(), // 1-bit output almost empty
    .ALMOSTFULL(), // 1-bit output almost full
    .DO( dout ), // Output data, width defined by DATA_WIDTH parameter
    .EMPTY( empty ), // 1-bit output empty
    .FULL( full ), // 1-bit output full
    .RDCOUNT(), // Output read count, width determined by FIfor depth
    .RDERR(), // 1-bit output read error
    .WRCOUNT(), // Output write count, width determined by FIfor depth
    .WRERR(), // 1-bit output write error
    .DI( din ), // Input data, width defined by DATA_WIDTH parameter
    .RDCLK( rd_clk ), // 1-bit input read clock
    .RDEN( rd_en), // 1-bit input read enable
    .RST( reset ), // 1-bit input reset
    .WRCLK( wr_clk ), // 1-bit input write clock
    .WREN( wr_en ) // 1-bit input write enable
);
// End of FIFO_DUALCLOCK_MACRO_inst instantiation

endmodule