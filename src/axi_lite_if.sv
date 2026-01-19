`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 17:38:19
// Design Name: 
// Module Name: axi_lite_if
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


interface axi_lite_if #(
parameter ADDR_W=32,
parameter DATA_W=32
)
(
input logic clk,
input logic reset_n
);

// write address channel


logic awvalid;
logic awready;
logic [ADDR_W-1:0] awaddr;

// write data channel
logic wvalid;
logic wready;
logic[DATA_W-1:0] wdata;

//write response channel
logic bvalid;
logic bready;
logic[1:0] bresp;

//read address channel
logic arvalid;
logic arready;
logic[ADDR_W-1:0] araddr;

//read data channel
logic rvalid;
logic rready;
logic[DATA_W-1:0]  rdata;
logic[1:0] rresp;

//modports 
modport master(
output awvalid,awaddr,
output wvalid,wdata,
output bready,
output arvalid,araddr,
output rready,
input awready, wready,
input bvalid,bresp,
input arready,
input rvalid,rdata,rresp
);

modport slave(
input awvalid,awaddr,
input wvalid,wdata,
input bready,
input arvalid,araddr,
input rready,
output awready,wready,
output bvalid, bresp,
output arready,
output rvalid,rdata,rresp
);
endinterface





























   