`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 01:30:17
// Design Name: 
// Module Name: timer_apb
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
module timer_apb(
input logic clk ,
input logic reset_n,
apb_if.slave apb,
output logic tick
);

logic enable_reg;
logic[31:0] count_reg ;
logic overflow_reg;
assign apb.pready=1'b1;

//timer counting logic 
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
count_reg<=32'd0;
overflow_reg<=1'b0;
end

else if(enable_reg)
begin
count_reg<=count_reg+1'b1;
if(count_reg==32'hffff_ffff)
overflow_reg<=1'b1;
end 
end

// apb write 
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
enable_reg<=1'b0;
end

else if(apb.psel && apb.penable && apb.pwrite)
begin
case(apb.paddr)
16'h0000: enable_reg<=apb.pwdata[0];
16'h0008: overflow_reg<=1'b0;
default: enable_reg<=enable_reg;
endcase
end
end

// apb read logic 
always_comb
begin
apb.prdata='0;
case(apb.paddr)
16'h0000:apb.prdata[0]=enable_reg;
16'h0004:apb.prdata=count_reg;
16'h0008:apb.prdata[0]=overflow_reg;

default: apb.prdata='0;
endcase
end
assign tick= overflow_reg;
endmodule 





















