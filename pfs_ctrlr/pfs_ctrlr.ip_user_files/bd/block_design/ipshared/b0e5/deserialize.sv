/*********************************************************************
 * \file
 * \author Josh Schoolcraft <jschoolc@jpl.nasa.gov>
 * \brief
 *
 * \copyright
 * Copyright 2005-2014, by the California Institute of Technology.
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

module deserialize #(
    parameter TXN_SZ = 8 ///< Bit length of transaction data
) (
    input clock, ///< System clock
    input sclock, ///< serial input clock
    input reset, ///< Active-high reset
    input sin,  ///< Serial input data
    output reg [31:0] rx_cnt, ///< Number of received transactions
    output reg [31:0] parity_fail_cnt, ///< Number of dropped transactions due to invalid parity
    output reg [31:0] stopbit_fail_cnt, ///< Number of dropped transactions due to no stop bit
    output reg dout_rdy,  ///< Signal new output data ready 
    output reg [(TXN_SZ - 1):0] dout ///< Deserialized data out
);

// State machine states
localparam  RESET = 3'd0,
            IDLE  = 3'd1,
            START_BIT = 3'd2,
            DATA = 3'd3,
            STOP_BIT = 3'd4;

localparam  SR_LEN = TXN_SZ + 1; ///< Include parity bit

// State and bit tracking
reg [2:0] state, next_state;

// Count dem output bits
reg [31:0] bitcount; ///< Intentionally over-sized

// Shift register for input bits
reg [(SR_LEN - 1):0] shift_reg;

// Registered inputs
reg sin_reg;
reg sclock_reg;

// Input data (z1 delay)
reg z1_sin_reg;

// Delayed serial clock
reg z1_sclock_reg;

// Signal state transitions
wire state_transition = (state != state);

// Falling edge of serial clock
wire sclock_f = z1_sclock_reg & (~sclock_reg);

// Detect resets and set to next state if it occurs
always @(posedge clock) begin
    sclock_reg <= sclock;
    sin_reg <= sin;
    z1_sclock_reg <= sclock_reg;
    state <= reset ? RESET : next_state;
end

// Decode next state
always @(*) begin
    next_state = state;
    if (sclock_f) begin
        case (state) 
          RESET: next_state = IDLE; // Go to idle
          // Immediately check for a start bit
          IDLE:  if (sin_reg) next_state = START_BIT;
          START_BIT: next_state = DATA;
          DATA: begin
              if (bitcount == 0) begin
                  next_state = (sin_reg == 0) ? STOP_BIT : IDLE;
              end
          end
          // Check if a start bit is already in place,
          // and jump to the appropriate state.
          STOP_BIT: next_state = sin_reg ? START_BIT : IDLE;
        endcase
    end
end

// State control logic
// Allow async reset with posedge reset
// Actel - async reset (3-input lut, sync reset slows everything down)
// Xilinx - sync reset (5 or 6 input lut, sync reset doesn't slow down)
// (Xilinx guides recommend sync resets - prevents over-contraint)
always @(posedge clock or posedge reset) begin
    if (reset) begin
        z1_sin_reg <= 0;
        bitcount <= 0;
        shift_reg <= 0;
        dout <= 0;
        dout_rdy <= 0;
        rx_cnt <= 0;
        parity_fail_cnt <= 0;
        stopbit_fail_cnt <= 0;
    end else begin
        dout_rdy <= 0; // Clear the new data ready signal
        if (sclock_f) begin
            z1_sin_reg <= sin_reg; // Get the input bit into a reg
            // Shift bit into shift register (always)
            shift_reg <= {shift_reg[(SR_LEN - 2):0], z1_sin_reg};

            case (state)
              START_BIT: bitcount <= SR_LEN - 1;
              DATA: begin
                bitcount <= bitcount - 1;
                if ((bitcount == 0) && (next_state != STOP_BIT)) begin
                    stopbit_fail_cnt <= stopbit_fail_cnt + 1;
                end
              end
              STOP_BIT: begin
                // Upon stop bit, latch data out and signal
                // new data is ready.
                if (0 == ^shift_reg) begin
                    dout_rdy <= 1;
                    dout <= shift_reg[(SR_LEN-1):1];
                    rx_cnt <= rx_cnt + 1;
                end else begin
                    parity_fail_cnt <= parity_fail_cnt + 1;
                end
              end
            endcase
        end
    end
end


endmodule

/* vim: set syntax=verilog: */
