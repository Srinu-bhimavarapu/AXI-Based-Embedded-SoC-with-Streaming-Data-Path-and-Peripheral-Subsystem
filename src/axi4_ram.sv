`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 17:53:03
// Design Name: 
// Module Name: axi4_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//axi_ram 
import params_pkg::*;

module axi4_ram #(
parameter MEM_DEPTH=1024
)
(
input logic clk,
input logic reset_n,
axi4_if.slave axi
);

logic[AXI4_DATA_W-1:0] mem[0:MEM_DEPTH-1];
logic[AXI4_ADDR_W-1:0] addr_reg;
logic[7:0] beat_cnt;
logic write_active;

assign axi.awready =~write_active;
assign axi.wready=write_active;

always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
addr_reg<='0;
beat_cnt<='0;
write_active<=1'b0;
end
else begin
if(axi.awvalid && axi.awready)
begin
addr_reg<=axi.awaddr;
beat_cnt<=8'd0;
write_active<=1'b1;
end

//write data beats
if(axi.wvalid && axi.wready)
begin
mem[addr_reg[AXI4_ADDR_W-1:2]]<=axi.wdata;

addr_reg<=addr_reg+4;
beat_cnt<=beat_cnt+1'b1;

if(axi.wlast)
write_active<=1'b0;
end
end
end

assign axi.bvalid=~write_active && (beat_cnt!=0);
assign axi.bresp=RESP_OKAY;
endmodule



















