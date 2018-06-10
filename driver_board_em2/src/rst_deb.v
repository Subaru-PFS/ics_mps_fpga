module rst_deb #(
    parameter IN_FREQ_KHZ = 16000,
    parameter HOLD_TIME_US = 50_000
) (
    input logic clkin,
    input logic rst_n,
    output logic rst_n_deb
);

localparam cycles = (IN_FREQ_KHZ/1000) * HOLD_TIME_US;

logic [$clog2(cycles)-1:0] counter;

logic sig, sig_z1;
logic strobe = (sig != sig_z1);

always_ff @(posedge clkin) begin
    sig <= rst_n;
    sig_z1 <= sig;
end

always_ff @(posedge clkin) begin
    // if input rst_n changed or it is low, go into reset
    if (strobe | ~sig) begin
        counter <= 0;
        rst_n_deb = 0;
    end 
    // if no change in input rst_n for 'cycles' cycles, come out of reset
    else if (counter == cycles -1) begin
        rst_n_deb = 1;
    end
    // otherwise keep counting up
    else begin
        counter <= counter + 1;
    end
    

end



endmodule
