module cal_norm (
    input rst,
    input clk,
    
    input go,
    input [15:0] curr, // current
    input [15:0] per, // period
    
    output logic [15:0] curr_norm // normalized current
);
// curr_norm = curr - (curr/per)

// the result of curr/per
wire [15:0] quotient;


/*****************************************************************************/


always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        curr_norm <= 0;
    end else begin
        curr_norm <= curr - quotient;
    end
end


// need to compute curr/per
divider div0 (
    .rst(rst),
    .clk(clk),
    
    .go(go),
    .divisor(per),
    .dividend(curr),
    
    .quotient(quotient),
    // no chk for rdy (this will have plenty of time to finish)
    .done()
);


endmodule