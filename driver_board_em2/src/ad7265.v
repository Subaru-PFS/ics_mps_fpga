`timescale 1ns/100ps 

module ad7265 # (
    parameter integer RANGE = 0 // set 1 for 0-2VREF, 0 for 0-VREF
) (
    input clk,
    input rst,
    
    input           req,
    input [2:0]     addr,
    output          rdy,
    output logic [11:0]   data_a,
    output logic [11:0]   data_b,

    // ADC I/F
    output              adc_sclk,
    output logic        adc_ncs,
    output logic [2:0]  adc_addr,
    output              adc_rng,
    input               adc_a,
    input               adc_b
);

enum {
    IDLE,
    SETUP,
    GOING,
    SAMPLE
} state, next_state;

// counter for clock cycles
logic [3:0] counter;

// dual shift regs for both A & B serial adc data in
logic [11:0] sreg_a;
logic [11:0] sreg_b;

wire valid_addr;

// latched on rising edge of clk by DDR_OUT to en a falling edge on adc_sclk
logic sclk_en;

/* 
slow clk running at 1/2 clk freq, need a slower clock than 16Mhz, because
ADC has 36ns max delay on asserting data on falling edge, which will not arrive
by the coming rising edge of 16Mhz clock
*/
logic [1:0] slow_clk;
wire slow_clk_f;
wire slow_clk_r;

/*****************************************************************************/
// make sure addr is not 0 or 7
assign valid_addr = addr inside {[1:6]};

assign rdy = (state == IDLE);

assign slow_clk_f = (slow_clk == 2'b11);
assign slow_clk_r = (slow_clk == 2'b01);

// set range for ADC based on parameter
assign adc_rng = RANGE;

always_comb begin
    case (state)
    IDLE:   next_state = (req & valid_addr) ? SETUP:state;
    SETUP:  next_state = (slow_clk_r) ? GOING:state;
    GOING:  next_state = (slow_clk_r & (counter == 0)) ? SAMPLE:state;
    SAMPLE: next_state = (slow_clk_r) ? IDLE:state;
    endcase
end

/*****************************************************************************/

always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        slow_clk <= 0;
        state <= IDLE;
        adc_addr <= 0;
        data_a <= 0;
        data_b <= 0;
        
    end else begin
        slow_clk <= slow_clk + 1;
        state <= next_state;
        adc_addr <= (state == IDLE) ? (addr-1):adc_addr;
        
        if (state == SAMPLE) begin
            data_a <= sreg_a;
            data_b <= sreg_b;
        end
        
    end
end

always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        sreg_a <= 0;
        sreg_b <= 0;
        adc_ncs <= 1;
        counter <= 0;

    end else if (slow_clk_r) begin
        sreg_a <= {sreg_a[10:0], adc_a};
        sreg_b <= {sreg_b[10:0], adc_b};
    
        case (state)
        IDLE: begin
            adc_ncs <= 1;
            counter <= 0;
            
        end
        SETUP: begin
            adc_ncs <= 0;
            counter <= 13;
            
        end
        GOING: begin
            adc_ncs <= 0;
            counter <= counter - 1;
            
        end
        SAMPLE: begin
            adc_ncs <= 1;
            counter <= 0;
        end
        endcase
    end
end

always_ff @ (posedge clk or posedge rst) begin
    if (rst) begin
        sclk_en <= 0;
    
    end else if (slow_clk_f) begin
        sclk_en <= (state == GOING);

    end
end



DDR_OUT adc_clk_gen (
    .DR(1'b1),
    .DF(~sclk_en),
    .CLK(slow_clk[1]),
    .CLR(rst),
    .Q(adc_sclk)   
);




endmodule