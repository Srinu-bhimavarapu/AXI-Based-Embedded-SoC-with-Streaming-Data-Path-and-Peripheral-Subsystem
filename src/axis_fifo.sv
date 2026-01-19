`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 02:14:07
// Design Name: 
// Module Name: axis_fifo
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

import params_pkg::*;
module axis_fifo #(
parameter DEPTH = FIFO_DEPTH
)
(
input logic clk,
input logic reset_n ,
axi_stream_if.slave s_axis,
axi_stream_if.master m_axis
);
logic[AXIS_DATA_W-1:0] mem[DEPTH-1:0];
logic[$clog2(DEPTH):0] wr_ptr,rd_ptr;
logic full,empty;

//status
assign empty=(wr_ptr==rd_ptr);
assign full=((wr_ptr +1'b1)==rd_ptr);

//write side 
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
wr_ptr<='0;
else if(s_axis.tvalid && s_axis.tready)
begin
mem[wr_ptr[$clog2(DEPTH)-1:0]] <= s_axis.tdata;
wr_ptr<=wr_ptr+1'b1;
end
end

//read side ]
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
rd_ptr<='0;

else if(m_axis.tvalid && m_axis.tready)
rd_ptr<=rd_ptr+1'b1;
end

//axi_stream hand shakes 

assign s_axis.tready=~full;
assign m_axis.tvalid=~empty;
assign m_axis.tdata=mem[rd_ptr[$clog2(DEPTH)-1:0]];
assign m_axis.tlast=1'b0;
endmodule
















