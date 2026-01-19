`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 02:06:07
// Design Name: 
// Module Name: axi_stream_source
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
module axi_stream_source(
input logic clk,
input logic reset_n,

input logic[7:0] data_in,
input logic data_valid,

axi_stream_if.master axis
);
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
axis.tvalid<=1'b0;
axis.tdata<='0;
axis.tlast<=1'b0;
end
else begin
if(data_valid && axis.tready)
begin
axis.tvalid<=1'b1;
axis.tdata<={24'h0, data_in};
axis.tlast<=1'b0;
end
else begin
axis.tvalid<=1'b0;
end
end
end
endmodule













