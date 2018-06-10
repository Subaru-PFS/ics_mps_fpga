module pfs_daughtercard (
    input           s00_axi_aclk,
    input           s00_axi_aresetn,
    //  Write Addr Channel
    input  [9:0]    s00_axi_awaddr,
    input  [2:0]    s00_axi_awprot, 
    input           s00_axi_awvalid,
    output          s00_axi_awready,
    // Write Data Channel
    input  [31:0]   s00_axi_wdata,
    input           s00_axi_wvalid,
    output          s00_axi_wready,
    input  [3:0]    s00_axi_wstrb, 
    // Write Response Channel
    output [1:0]    s00_axi_bresp,
    output          s00_axi_bvalid,
    input           s00_axi_bready,
    // Read Addr Channel
    input  [9:0]    s00_axi_araddr,
    input  [2:0]    s00_axi_arprot, 
    input           s00_axi_arvalid,
    output          s00_axi_arready,
    // Read Data Channel
    output [31:0]   s00_axi_rdata,
    output [1:0]    s00_axi_rresp, 
    output          s00_axi_rvalid,
    input           s00_axi_rready,
    
    // 16 Mhz Serial Clock for LVDS
    input           ser_clk,
    
    // External I/O to Daughtercard
    output [5:0] rst_nxt,
    output [5:0] cmd_nxt,
    output [5:0] clk_nxt,
    input  [5:0] resp_nxt,
    input  [5:0] rclk_nxt,
    output [5:0] psu_en,
    output [5:0] rx_err
    
);

/*
The six 6 sectors 0-5 start at the following offsets from the AXI_BASEADDR
sec0: 0x000
sec1: 0x020
sec2: 0x040
sec3: 0x060
sec4: 0x080
sec5: 0x0A0

Within each sector there are 9 (32bit) registers:
ADDR_CTRL:      0x00
ADDR_STATUS:    0x04
ADDR_TX:        0x08
ADDR_RX:        0x0C
ADDR_TX_COUNT:  0x10
ADDR_RX_COUNT:  0x14
ADDR_RX_PARITY: 0x18
ADDR_RX_STPBIT: 0x1C    

Selecting addr 0x0C0 or above will return the value of the 32-bit timer with 
TIMER_PREC_MS precision in milisec
*/


localparam NUM_SECTORS = 6;

// speed in MHZ of the ser_clk
localparam integer SER_CLK_MHZ = 16;
// timer precision in Miliseconds
localparam integer TIMER_PREC_MS = 1;

// number of cycles before counter on ser_clk rolls-over
localparam integer COUNTER_ROLL_CYCLES = SER_CLK_MHZ * TIMER_PREC_MS * 1000;
localparam COUNTER_BITS = $clog2(COUNTER_ROLL_CYCLES);


logic [31:0] wr_data = 0;
logic wr_en = 0;
logic [2:0] wr_sector_sel = 0;
logic [2:0] wr_sector_addr = 0;


wire [NUM_SECTORS-1:0] [31:0] sector_rd_data;
logic rd_en = 0;
logic [31:0] rd_data = 0;
logic [2:0] rd_sector_sel = 0;
logic [2:0] rd_sector_addr = 0;

logic awready = 0;

logic rvalid = 0;
logic arready = 0;

// counter on ser_clk domain
logic [COUNTER_BITS-1:0] ser_counter = 0;
logic counter_roll = 0;

// registering counter_roll onto bus clk domain and using it for timer
logic [1:0] counter_roll_z = 0;
wire counter_roll_r;
logic [31:0] timer = 0;


/*****************************************************************************/

assign s00_axi_awready = awready;
assign s00_axi_wready = awready;
assign s00_axi_bvalid = awready;
assign s00_axi_bresp = 2'b00; // okay resp

assign s00_axi_arready = arready;
assign s00_axi_rvalid = rvalid;
assign s00_axi_rresp = 2'b00;
assign s00_axi_rdata = rd_data;


assign counter_roll_r = ~counter_roll_z[1] & counter_roll_z[0];


/*****************************************************************************/
// READ SYNCRONOUS LOGIC

always @ (posedge s00_axi_aclk) begin
    // latching rd address
    if (~arready & s00_axi_arvalid) begin
        rd_sector_sel <= s00_axi_araddr[7:5];
        rd_sector_addr <= s00_axi_araddr[4:2];
    end
    // latching rd data
    if (arready) begin
        rd_data <= (rd_sector_sel < NUM_SECTORS) ? 
                sector_rd_data[rd_sector_sel]:timer;
    end
end

always @ (posedge s00_axi_aclk) begin
    if (~s00_axi_aresetn) begin
        rvalid <= 0;
    end else if (arready) begin
        rvalid <= 1;
    end else if (s00_axi_rready) begin
        rvalid <= 0;
    end
end

always @ (posedge s00_axi_aclk) begin
    if (~s00_axi_aresetn) begin
        arready <= 0;
        rd_en <= 0;
    end else begin
        arready <= (~arready & s00_axi_arvalid);
        rd_en <= arready;
    end
end


/*****************************************************************************/
// WRITE SYNCRONOUS LOGIC

always @ (posedge s00_axi_aclk) begin
    awready <= 0;
    wr_en <= 0;

    if(~awready & s00_axi_awvalid & s00_axi_bready & s00_axi_wvalid) begin
        awready <= 1;
        wr_data <= s00_axi_wdata;
        wr_en <= 1;
        wr_sector_sel <= s00_axi_awaddr[7:5];
        wr_sector_addr <= s00_axi_awaddr[4:2];
    end

end

/*****************************************************************************/

// timer logic
always @ (posedge ser_clk) begin
    if (ser_counter >= (COUNTER_ROLL_CYCLES-1)) begin
        ser_counter <= 0;
        counter_roll <= 1;
    end else begin
        ser_counter <= ser_counter + 1;
        counter_roll <= 0;
    
    end
end
always @ (posedge s00_axi_aclk) begin
    if (~s00_axi_aresetn) begin
        counter_roll_z <= 0;
        timer <= 0;
        
    end else begin
        counter_roll_z <= {counter_roll_z[0], counter_roll};
        timer <= (counter_roll_r) ? (timer+1):timer;
    
    end
end



// PFS Sectors
genvar j;
generate for (j = 0; j < NUM_SECTORS; j = j + 1) begin
    pfs_sector i_pfs_sector (
        .ser_clk(ser_clk),
        .rst(~s00_axi_aresetn),
        
        .rst_nxt(rst_nxt[j]),
        .cmd_nxt(cmd_nxt[j]),
        .clk_nxt(clk_nxt[j]),
        .resp_nxt(resp_nxt[j]),
        .rclk_nxt(rclk_nxt[j]),
        .psu_enable(psu_en[j]),
        .rx_err(rx_err[j]),
        
        .bus_clk(s00_axi_aclk),
        .bus_wr_addr(wr_sector_addr),
        .bus_rd_addr(rd_sector_addr),
        .bus_wr_data(wr_data),
        .bus_rd_req(rd_en & (rd_sector_sel == j)),
        .bus_wr_req(wr_en & (wr_sector_sel == j)),
        .bus_rd_data(sector_rd_data[j])
    );

end endgenerate

endmodule
