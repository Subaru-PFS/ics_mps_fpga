`timescale 1ns/100ps
module cal_norm_tb();

localparam  CLK_2 = 25,
            CLK = 2*CLK_2,
            RESET = 50*CLK,
            START = 5000*CLK,
            DONE = 3_000_000*CLK;
            
logic start = 0;
logic rst = 1;
logic clk = 0;

initial begin
    fork 
        forever #CLK_2 clk = ~clk;
        #START start = 1;
        #RESET rst = 0;
    join
end

logic [15:0] period = 0;
logic [15:0] current = 0;

wire [15:0] current_norm;
logic go = 0;

cal_norm UUT (
    .rst(rst),
    .clk(clk),
    .go(go),
    .curr(current),
    .per(period),
    .curr_norm(current_norm)
);

logic [15:0] p;
logic [15:0] c;

initial begin
    c = 61_000;
    @(posedge start);
    
    
    for (p = 100; p < 300; p = p + 7) begin
        //for (c = 50_000; c < 61_000; c = c + 5_000) begin
            period = p;
            current = c;
            @ (posedge clk);
            go = 1;
            @ (posedge clk);
            go = 0;
            #(300*CLK);
            
            $display("@%0dns c:%d p:%d -> c_norm = %d = %d - %d", 
                    $time(), c, p, current_norm, c, (c-current_norm));
        //end
    end

end



endmodule