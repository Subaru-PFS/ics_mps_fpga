module divider (
    input rst,
    input clk,
    
    input go,
    input [15:0] divisor,
    input [15:0] dividend,
    
    output logic [15:0] quotient,
    output done
);
// quotient = dividend/divisor
/*
    CORNER CASES
    divisor = 0 : returns garbage
    dividend = 0 : done immediately quotient is 0 
*/


logic [16:0] remainder;


// the number of shifts to scale divisor by before subtracting
logic scalar_rdy;


logic [16:0] scaled_divisor;
logic [15:0] nxt_quotient_bit;

/*****************************************************************************/

assign done = (divisor > remainder);


/*****************************************************************************/

always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        scalar_rdy <= 0;
        nxt_quotient_bit <= 0;
        scaled_divisor <= 0;
        
    end else begin
        scalar_rdy <= 0;
        
        if (go | scalar_rdy) begin
            nxt_quotient_bit <= 1;
            scaled_divisor <= divisor;
        
        end else if (~done) begin
            if ((scaled_divisor<<1) > remainder) begin
                scalar_rdy <= 1;
            
            end else begin
                nxt_quotient_bit <= nxt_quotient_bit << 1;
                scaled_divisor <= scaled_divisor << 1;
            
            end
        end
        
    end
end


always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        quotient <= 0;
        remainder <= 0;
        
    end else begin
    
        if (go) begin
            quotient <= 0;
            remainder <= dividend;
        
        end else if (~done & scalar_rdy) begin
            // bring in the next bit of quotient
            quotient <= quotient | nxt_quotient_bit;
            // subtract the scaled divisor from the remainder 
            remainder <= remainder - scaled_divisor;
            
        end
    end
end


endmodule