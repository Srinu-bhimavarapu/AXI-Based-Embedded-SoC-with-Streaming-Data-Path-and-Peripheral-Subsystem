`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 21:38:38
// Design Name: 
// Module Name: axi_stream_if
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

interface axi_stream_if #(
parameter DATA_W=32
)
(
input logic clk,
input logic reset_n
);

logic tvalid;
logic tready;
logic[DATA_W-1:0] tdata;
logic tlast;

modport master(
output tvalid,tdata,tlast,
input tready
);
modport slave(
input tvalid,tdata,tlast,
output tready
);
endinterface



























