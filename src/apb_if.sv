`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 21:27:49
// Design Name: 
// Module Name: apb_if
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

// apb interface 

interface apb_if #(
parameter ADDR_W=16,
parameter DATA_W=32
)
(
input logic clk,
input logic reset_n
);

logic psel;
logic penable;
logic pwrite;

logic[ADDR_W-1:0] paddr;
logic[DATA_W-1:0] pwdata;
logic[DATA_W-1:0] prdata;
logic pready;

modport master(
output psel,penable,pwrite,paddr,pwdata,
input prdata,pready
);


modport slave(
input psel,penable,pwrite,paddr,pwdata,
output prdata,pready
);

endinterface





































