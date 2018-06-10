/*********************************************************************
 * \file
 * \author Joshua Schoolcraft <jschoolc@jpl.nasa.gov>
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

module serialize #(
    parameter TXN_SZ = 8
) (
    input clock, ///< Dat clock input o_O
    input reset, ///< Active-high reset
    input [(TXN_SZ - 1):0] din, ///< Input data to serialize
    input din_rdy, ///< Signal new data ready to serialize
    output reg [31:0] tx_cnt, ///< Number of transmitted transactions
    output ser_rdy, ///< Signal ready to accept new data
    output sout ///< Serial data
);

localparam  RESET = 3'd0,
            IDLE  = 3'd1,
            LATCH = 3'd2,
            SERIALIZE = 3'd3,
            SR_LEN = TXN_SZ + 3; ///< Include start, stop, parity bits

// State and bit tracking
reg [2:0] state, next_state;

// Count dem output bits
reg [31:0] bitcount; 

// Shift register for bits
reg [(SR_LEN - 1):0] shift_reg;

// Input data (z1 delay)
reg [(TXN_SZ - 1):0] z1_data;

// Signal state transitions
wire state_transition = (state != state);

// Perm-assign ready signal to IDLE state
assign ser_rdy = (state == IDLE);

// Serial output (MSB of SR)
assign sout = shift_reg[SR_LEN - 1];

// Detect resets and set to next state if it occurs
always @(posedge clock) begin
    state <= reset ? RESET : next_state;
end

// Decode next state
always @(*) begin
    next_state = state;
    case (state)
        RESET: next_state = IDLE; // Go to idle
        IDLE:  if (din_rdy) next_state = LATCH;
        LATCH: next_state = SERIALIZE;
        SERIALIZE: if (bitcount == 0) next_state = IDLE;
    endcase
end

// State control logic
// Allow async reset with posedge reset
// Actel - async reset (3-input lut, sync reset slows everything down)
// Xilinx - sync reset (5 or 6 input lut, sync reset doesn't slow down)
// (Xilinx guides recommend sync resets - prevents over-contraint)
always @(posedge clock or posedge reset) begin
    if (reset) begin
        bitcount <= 0;
        shift_reg <= 0;
        z1_data <= 0;
        tx_cnt <= 0;
    end else begin
        z1_data <= din;

        if (state == LATCH) begin
            // Init bitcount and latch in data + start/stop bits
            bitcount <= SR_LEN - 1;
            shift_reg <= {1'b1, z1_data, ^z1_data, 1'b0};
            tx_cnt <= tx_cnt + 1;
        end
        if (state == SERIALIZE) begin
            // Decrement bitcount and shift left
            bitcount <= bitcount - 1;
            // SR_LEN - 2 is tricky - check start bit.
            shift_reg <= {shift_reg[(SR_LEN - 2):0], 1'b0};
        end
    end
end

endmodule

/* vim: set syntax=verilog: */
