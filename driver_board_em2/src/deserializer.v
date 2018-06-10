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

module deserializer #(
    parameter TXN_SZ = 8   ///< Transaction size (bits)
) (
    input   logic       clock,  ///< Input clock
    input   logic       reset,  ///< Active-high reset
    input   logic       sin,    ///< Serial-in data
    output  logic       nd,     ///< Asserted for one cycle when new data is available
    output  logic [(TXN_SZ-1):0] data  ///< The deserialized data
);

localparam START = 1'b1;
localparam STOP  = 1'b0;

// State machine states
enum {
    RESET,
    IDLE,
    START_BIT,
    DATA,
    STOP_BIT
} state, next_state;

// The shift register has to hold a transaction and a checksum bit
localparam SR_LEN = TXN_SZ + 1;

// Bit counter
logic [$clog2(SR_LEN)-1:0] count;
// Shift register to deserialize the bits
logic [(SR_LEN-1):0] shift_reg;

// Cycle-delayed serial input data
logic z1_sin;

always_ff @(negedge clock or posedge reset) begin
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
      // If we're in IDLE and we see a high bit, that's a start bit
      IDLE: if (sin == START) next_state = START_BIT;
      START_BIT: next_state = DATA;
      DATA: begin
        // Once the bit counter hits 0, we're done.  Just need to capture the stop
        // bit, or go back to idle if it's not there
        if (count == 0) begin
            next_state = (sin == STOP) ? STOP_BIT : IDLE;
        end
      end
      // Be careful, there might be a new start bit immediately following a stop bit
      STOP_BIT: next_state = (sin == START) ? START_BIT : IDLE;
    endcase
end

always_ff @(negedge clock) begin
    if (reset) begin
        z1_sin <= 0;
        shift_reg <= 0;
        nd <= 0;
        count <= 0;
        data <= 0;
    end else begin
        // Register the input bit
        z1_sin <= sin;
        // Then shift it into the shift register
        shift_reg <= {shift_reg[(SR_LEN-2):0], z1_sin};
        nd <= 0;

        case (state)
          START_BIT: count <= SR_LEN-1;
          DATA: count <= count - 1;
          STOP_BIT: begin
            // When we've hit the stop bit, latch the data out of the shift
            // register and notify the parent if the parity bit matches.
            if (0 == ^shift_reg) begin
                nd <= 1;
                data <= shift_reg[(SR_LEN-1):1];
            end
          end
        endcase
    end
end

endmodule

/* vim: set syntax=systemverilog: */
