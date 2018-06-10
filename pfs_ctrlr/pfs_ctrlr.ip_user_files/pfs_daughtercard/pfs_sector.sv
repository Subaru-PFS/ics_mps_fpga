module pfs_sector ( 
    // serial clock
    input ser_clk,
    input rst,
    
    // External I/O on Flex cable
    output      rst_nxt,
    output      cmd_nxt,
    output      clk_nxt,
    input       resp_nxt,
    input       rclk_nxt,
    output      psu_enable,
    
    // flag of any bad received packets
    output reg  rx_err,
    
    // Bus Signals
    input               bus_clk,
    input  [2:0]        bus_wr_addr,
    input  [2:0]        bus_rd_addr,
    input  [31:0]       bus_wr_data,
    input               bus_rd_req,
    input               bus_wr_req,
    output reg [31:0]   bus_rd_data
);
/* 
-FIFO's are 34-bits wide, and this is the size of the packet sent
-Packets sent over the serial link (cmd_nxt/resp_nxt) are 37 bits, including
    a start bit before, and parity + stop bits after.
    
- Note: upper 2 bits of 34 are not used and set to 0
*/

// Control Bits
localparam BIT_SOFT_RST = 0;
localparam BIT_PSU_OFF  = 1;

// Bus Addresses
localparam ADDR_CTRL        = 0;
localparam ADDR_STATUS      = 1;
localparam ADDR_TX          = 2;
localparam ADDR_RX          = 3;
localparam ADDR_TX_COUNT    = 4;
localparam ADDR_RX_COUNT    = 5;
localparam ADDR_RX_PARITY   = 6;
localparam ADDR_RX_STOPBIT  = 7;

localparam SOFT_RST_CYCLES = 63;

// Rx Fifo signals
wire rx_fifo_wr_clk;
wire rx_fifo_rd_clk;
wire [33:0] rx_fifo_wr_data;
wire [33:0] rx_fifo_rd_data;
wire rx_fifo_wr;
wire rx_fifo_rd;
wire rx_fifo_full;
wire rx_fifo_empty;

// Tx Fifo signals
wire tx_fifo_wr_clk;
wire tx_fifo_rd_clk;
reg  [33:0] tx_fifo_wr_data;
wire [33:0] tx_fifo_rd_data;
wire tx_fifo_wr;
wire tx_fifo_rd;
wire tx_fifo_full;
wire tx_fifo_empty;

// serializer ready
wire ser_rdy;

// new data to be loaded into Tx Fifo
reg tx_wr_rdy;

// soft reset
wire soft_rst;

// soft reset counter
reg  [5:0]   counter_soft_rst;

// writable control register
reg  [31:0]  ctrl_reg;

// read-only registers giving info/status/etc...
reg  [31:0]  status_reg;
wire [31:0]  rx_parity_fails;
wire [31:0]  rx_stopbit_fails;
wire [31:0]  tx_count;
wire [31:0]  rx_count;

reg [2:0] rst_pipe;
reg ser_rst;

/*****************************************************************************/

// command signals
assign soft_rst = ctrl_reg[BIT_SOFT_RST]; 
assign psu_enable = ~ctrl_reg[BIT_PSU_OFF];

// Note: rst_nxt is active low
assign rst_nxt = ~soft_rst;

assign rx_fifo_wr_clk = bus_clk;
assign rx_fifo_rd_clk = bus_clk;
assign rx_fifo_rd = bus_rd_req & (bus_rd_addr == ADDR_RX);

assign tx_fifo_wr_clk = bus_clk;
assign tx_fifo_wr = tx_wr_rdy;
assign tx_fifo_rd_clk = ser_clk;
assign tx_fifo_rd = ser_rdy & ~tx_fifo_empty;


// combinational mux to select bus_rd_data
always @ (*) begin
    case (bus_rd_addr)
    ADDR_CTRL:          bus_rd_data <= ctrl_reg;
    ADDR_STATUS:        bus_rd_data <= status_reg;
    ADDR_TX:            bus_rd_data <= tx_fifo_wr_data[31:0];
    ADDR_RX:            bus_rd_data <= rx_fifo_rd_data[31:0];
    ADDR_TX_COUNT:      bus_rd_data <= tx_count;
    ADDR_RX_COUNT:      bus_rd_data <= rx_count;
    ADDR_RX_PARITY:     bus_rd_data <= rx_parity_fails; 
    ADDR_RX_STOPBIT:    bus_rd_data <= rx_stopbit_fails;
    default:            bus_rd_data <= ctrl_reg;     
    endcase
end

/*****************************************************************************/

// Sequential writing via bus_wr_data, and other writing of those regs
always @ (posedge bus_clk) begin
    if (rst) begin
        ctrl_reg <= 0;
        tx_fifo_wr_data <= 0;
        
    end else begin
        // When writing...
        if (bus_wr_req) begin
            case (bus_wr_addr)
            ADDR_CTRL:      ctrl_reg[2:0]           <= bus_wr_data[2:0];
            ADDR_TX:        tx_fifo_wr_data[31:0]   <= bus_wr_data;
            endcase
           
        // When not writing...
        end else begin
            if (counter_soft_rst == 1)
                ctrl_reg[BIT_SOFT_RST] <= 0;
        
        end
    end
end

// ready to load a new Tx transaction once we write the high bits 33-32
always @ (posedge bus_clk) begin
    if (rst | soft_rst) 
        tx_wr_rdy <= 0;
    else
        tx_wr_rdy <= (bus_wr_req & (bus_wr_addr == ADDR_TX));
end

// soft-reset counter
always @ (posedge bus_clk) begin
    if (rst) begin
        counter_soft_rst <= 0;
        
    end else begin
        if (bus_wr_req & (bus_wr_addr == ADDR_CTRL) & bus_wr_data[BIT_SOFT_RST])
            counter_soft_rst <= SOFT_RST_CYCLES;
            
        else if (counter_soft_rst != 0)
            counter_soft_rst <= counter_soft_rst - 1;
    
    end
end

// detect any bad recieved packets and flag rx_err
always @ (posedge bus_clk) begin
    if (rst | soft_rst) begin
        rx_err <= 0;
        
    end else begin
        rx_err <= rx_err | rx_parity_fails[0] | rx_stopbit_fails[0];
    
    end
end

// a few things that need to be reg'd for timing
always @ (posedge bus_clk) begin
    status_reg[31:4] <= 0;
    status_reg[3] <= rx_fifo_full;
    status_reg[2] <= rx_fifo_empty;
    status_reg[1] <= tx_fifo_full;
    status_reg[0] <= tx_fifo_empty;
    

end
    

// bringing the reset to the ser_clk domain
always @ (posedge ser_clk) begin
    rst_pipe <= {rst_pipe[1:0], rst | soft_rst};
    ser_rst <= (rst_pipe[2:1] != 2'b00);
    
end


/*****************************************************************************/

ODDR clk_nxt_buf (
    .Q( clk_nxt ),
    .C( ser_clk ),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);

fifo tx_fifo (
    .reset(ser_rst),
    
    .wr_clk(tx_fifo_wr_clk),
    .din(tx_fifo_wr_data),
    .wr_en(tx_fifo_wr),
    
    .rd_clk(tx_fifo_rd_clk),
    .dout(tx_fifo_rd_data),
    .rd_en(tx_fifo_rd),
    
    .full(tx_fifo_full),
    .empty(tx_fifo_empty)
);

serialize #(
    .TXN_SZ(34)
) serializer (
    .clock(tx_fifo_rd_clk),
    .reset(ser_rst),
    
    .ser_rdy(ser_rdy),
    
    .din(tx_fifo_rd_data),
    .din_rdy(tx_fifo_rd),
    
    .tx_cnt(tx_count),
    
    .sout(cmd_nxt)
);

fifo rx_fifo (
    .reset(rst | soft_rst),
    
    .wr_clk(rx_fifo_wr_clk),
    .din(rx_fifo_wr_data),
    .wr_en(rx_fifo_wr),
    
    .rd_clk(rx_fifo_rd_clk),
    .dout(rx_fifo_rd_data),
    .rd_en(rx_fifo_rd),
    
    .full(rx_fifo_full),
    .empty(rx_fifo_empty)
);

deserialize #(
    .TXN_SZ(34)
) deserializer (
    .clock(rx_fifo_wr_clk),
    .sclock(rclk_nxt),
    .reset(rst | soft_rst),
    
    .dout(rx_fifo_wr_data),
    .dout_rdy(rx_fifo_wr),
    
    .parity_fail_cnt(rx_parity_fails),
    .stopbit_fail_cnt(rx_stopbit_fails),
    .rx_cnt(rx_count),
    
    .sin(resp_nxt)
);


endmodule
