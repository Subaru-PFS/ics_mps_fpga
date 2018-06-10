module simple_ip (
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
    input           s00_axi_rready
);

logic rvalid = 0;
logic arready = 0;

logic awready = 0;

logic [31:0] rd_data = 32'hABCD0000;
logic [3:0] rd_addr = 0;

logic [31:0] wr_word = 0;


/*****************************************************************************/

assign s00_axi_awready = awready;
assign s00_axi_wready = awready;
assign s00_axi_bvalid = awready;
assign s00_axi_bresp = 2'b00; // okay resp

assign s00_axi_arready = arready;
assign s00_axi_rvalid = rvalid;
assign s00_axi_rresp = 2'b00;

assign s00_axi_rdata = rd_data;


/*****************************************************************************/
// read logic
always @ (posedge s00_axi_aclk) begin
    if (~arready & s00_axi_arvalid) begin
        rd_addr <= s00_axi_araddr[3:0];
    end
    
    if(arready) begin
        rd_data <= (rd_addr == 0) ? (rd_data+1):wr_word;
    
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
    end else begin
        arready <= (~arready & s00_axi_arvalid);
    end
end
/*****************************************************************************/
// write logic
always @ (posedge s00_axi_aclk) begin
    awready <= 0;

    if(~awready & s00_axi_awvalid & s00_axi_bready & s00_axi_wvalid) begin
        awready <= 1;
        wr_word <= s00_axi_wdata;
    end

end



endmodule