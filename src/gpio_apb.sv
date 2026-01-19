`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 01:05:54
// Design Name: 
// Module Name: gpio_apb
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
module gpio_apb #(
parameter GPIO_WIDTH=8
)
(
input logic clk ,
input logic reset_n,

apb_if.slave apb,
input logic[GPIO_WIDTH-1:0] gpio_in,
output logic[GPIO_WIDTH-1:0] gpio_out,
output logic[GPIO_WIDTH-1:0] gpio_dir
);

//gpio registers
logic[GPIO_WIDTH-1:0] data_reg;
logic[GPIO_WIDTH-1:0] dir_reg;

//apb ready
assign apb.pready=1'b1;

//apb write logic 
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
data_reg<='0;
dir_reg<='0;
end

else if(apb.psel && apb.penable && apb.pwrite)
begin
case(apb.paddr)
16'h0000: data_reg<= apb.pwdata[GPIO_WIDTH-1:0];
16'h0004: dir_reg<= apb.pwdata[GPIO_WIDTH-1:0];

default: begin
data_reg<=data_reg;
dir_reg<=dir_reg;
end
endcase
end
end

//apb read logic 
always_comb
begin
apb.prdata='0;
case(apb.paddr)
16'h0000: apb.prdata[GPIO_WIDTH-1:0]= data_reg;
16'h0004: apb.prdata[GPIO_WIDTH-1:0] = dir_reg;
16'h0008: apb.prdata[GPIO_WIDTH-1:0] = gpio_in;
default: apb.prdata='0;
endcase
end

//gpio outputs
assign gpio_out=data_reg;
assign gpio_dir=dir_reg;
endmodule
























