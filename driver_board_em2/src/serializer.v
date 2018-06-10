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

module serializer #(
    parameter TXN_SZ = 8   ///< Transaction size (bits)
) (
    input   logic       clock,  ///< Input clock
    input   logic       reset,  ///< Active-high reset
    input   logic [(TXN_SZ-1):0] data,  ///< Data to serialize
    input   logic       nd, ///< Request to serialize
    output  logic       sout,   ///< Serial data out
    output  logic       rdy ///< Ready to accept serialization requests
);

// The shift register has to hold a transaction, plus a start, a stop bit, and a checksum bit
localparam SR_LEN = TXN_SZ + 3;

// State machine states
enum {
    RESET,
    IDLE,
    LATCH,
    SERIALIZE
} state, next_state;

// Bit counter
logic [$clog2(SR_LEN)-1:0] count;
// Shift register to serialize the bits
logic [(SR_LEN-1):0] shift_reg;

// Cycle-delayed parallel input data
logic [(TXN_SZ-1):0] z1_data;

// Serial output is the MSB of the shift register
assign sout = shift_reg[$bits(shift_reg)-1];
// If the state machine is idle, we're ready to accept new data
assign rdy = (state == IDLE);

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
      // When new data is present, latch it
      IDLE: if (nd) next_state = LATCH;
      // then start serialization
      LATCH: next_state = SERIALIZE;
      SERIALIZE: if (count == 0) next_state = IDLE;
    endcase
end

always_ff @(posedge clock) begin
    if (reset) begin
        count <= 0;
        shift_reg <= 0;
        z1_data <= 0;
    end else begin
        z1_data <= data;

        if (state == LATCH) begin
            // Initialize the counter and latch the data (with start and stop
            // bits)
            count <= $bits(shift_reg) - 1;
            shift_reg <= {1'b1, z1_data, ^z1_data, 1'b0};
        end
        if (state == SERIALIZE) begin
            // When serializing, decrement the counter and shift the data left
            count <= count - 1;
            shift_reg <= {shift_reg[($bits(shift_reg)-2):0], 1'b0};
        end
    end
end

endmodule

/* vim: set syntax=systemverilog: */
