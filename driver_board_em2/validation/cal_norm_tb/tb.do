source ../utils.do

do_compile ../../src/cal_norm.v ../../src/divider.v
do_compile ./cal_norm_tb.v

vsim work.cal_norm_tb

set_context / "TOP"
logic start "Start"
logic rst "Rst"
logic clk "Clock"
div

set_context /UUT "Cal Norm"
uint curr_norm "Curr Norm"
div

set_context /UUT/div0 "Divider"
logic go "Go"
logic clk "Clock"
uint divisor "Divisor"
uint dividend "Dividend"
uint quotient "Quotient"
logic done "Done"
uint remainder "Remainder"
uint nxt_quotient_bit "Nxt Quotient Bit"
uint scaled_divisor "Scaled Divisor"
logic scalar_rdy "Scalar Rdy"
div

run -all
wave zoom full