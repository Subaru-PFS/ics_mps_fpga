module clk_counter #(
    parameter IN_FREQ_KHZ = 16000,
    parameter OUT_FREQ_KHZ = 300
) (
    input logic in_clk,
    input logic reset,
    output logic out_clk
);

localparam cycles = (IN_FREQ_KHZ / (2*OUT_FREQ_KHZ) );

logic [$clog2(cycles)-1:0] counter;

always_ff @(posedge in_clk or posedge reset) begin
    if(reset) begin
        counter <= 0;
        out_clk <= 0;
    end else if(counter == cycles-1) begin
        counter <= 0;
        out_clk <= ~out_clk;
    end else begin
        counter <= counter + 1;
    end

end

endmodule