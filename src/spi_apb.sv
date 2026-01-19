`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 01:45:48
// Design Name: 
// Module Name: spi_apb
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

module spi_apb(
input logic clk,
input logic reset_n,
apb_if.slave apb,
output logic spi_sclk,
output logic spi_mosi,
output logic spi_cs
);
//register
logic enable_reg;
logic[7:0] tx_reg;
logic[2:0] bit_cnt;
logic busy_reg;

assign apb.pready=1'b1;
assign spi_sclk=clk & busy_reg;

always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
bit_cnt<=3'd0;
busy_reg<=1'b0;
spi_mosi<=1'b0;
end
else if(enable_reg && busy_reg)
begin
spi_mosi<=tx_reg[7];
tx_reg<={tx_reg[6:0], 1'b0};
bit_cnt<=bit_cnt+1'b1;
if(bit_cnt==3'd7)
busy_reg<=1'b0;
end
end

//apb write logic 
always_ff@(posedge clk or negedge reset_n)
 begin
 if(!reset_n)
 begin
 enable_reg<=1'b0;
 tx_reg<=8'h00;
 busy_reg<=1'b0;
 end
 else if(apb.psel && apb.penable && apb.pwrite)
 begin
 case(apb.paddr)
 16'h0000: enable_reg<=apb.pwdata[0];
 16'h0004: begin
 tx_reg<= apb.pwdata[7:0];
 busy_reg<=1'b1;
 bit_cnt<=3'd0;
 end
 
 default: enable_reg<=enable_reg;
 endcase
 end
 end
 
 //apb read logic 
 always_comb
 begin
 apb.prdata='0;
 case(apb.paddr)
 16'h0008: apb.prdata[0]=busy_reg;
 default: apb.prdata='0;
 endcase
 end
 assign spi_cs=~busy_reg;
 endmodule



























