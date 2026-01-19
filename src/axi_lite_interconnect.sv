`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 23:34:21
// Design Name: 
// Module Name: axi_lite_interconnect
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


//axi_lite_interconnect 
import params_pkg::*;

module axi_lite_interconnect(
input logic clk,
input logic reset_n,
axi_lite_if.slave m_axi,
axi_lite_if.master s_axi
);

//pass through routing 
//write address
assign s_axi.awvalid=m_axi.awvalid;
assign s_axi.awaddr=m_axi.awaddr;
assign m_axi.awready=s_axi.awready;

//write data 
assign s_axi.wvalid=m_axi.wvalid;
assign s_axi.wdata=m_axi.wdata;
assign m_axi.wready=s_axi.wready;

//write response
assign m_axi.bvalid=s_axi.bvalid;
assign m_axi.bresp=s_axi.bresp;
assign s_axi.bready=m_axi.bready;

//read address
assign s_axi.arvalid =  m_axi.arvalid;
assign s_axi.araddr = m_axi.araddr;
assign m_axi.arready=s_axi.arready;

//read data
assign m_axi.rvalid=s_axi.rvalid;
assign m_axi.rdata=s_axi.rdata;
assign m_axi.rresp=s_axi.rresp;
assign s_axi.rready=m_axi.rready;
endmodule

















