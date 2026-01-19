`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 18:09:19
// Design Name: 
// Module Name: soc_top
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

module soc_top(
input logic clk,
input logic reset_n,

//extend io

input logic[7:0] gpio_in,
output logic[7:0] gpio_out,
output logic[7:0] gpio_dir,
output logic uart_tx,

output logic spi_sclk,
output logic spi_mosi,
output logic spi_cs
);

//bus interface
axi_lite_if   axi_lite_m();
axi_lite_if   axi_lite_s();
apb_if        apb_bus();

axi_stream_if axis_src();
axi_stream_if axis_fifo_out();
axi_stream_if axis_proc_out();

axi4_if  axi4_bus();


axi_lite_master_ctrl u_axi_lite_master(
.clk(clk),
.reset_n(reset_n),
.axi(axi_lite_m)
);

axi_lite_interconnect u_axi_lite_ic(
.clk(clk),
.reset_n(reset_n),
.m_axi(axi_lite_m),
.s_axi(axi_lite_s)
);

axi_lite_to_apb_bridge u_axi_to_apb(
.clk(clk),
.reset_n(reset_n),
.axi(axi_lite_s),
.apb(apb_bus)
);

uart_apb u_uart(
.clk(clk),
.reset_n(reset_n),
.apb(apb_bus),
.tx(uart_tx)
);


//gpio
gpio_apb#(.GPIO_WIDTH(8)) u_gpio(
.clk(clk),
.reset_n(reset_n),
.apb(apb_bus),
.gpio_in(gpio_in),
.gpio_out(gpio_out),
.gpio_dir(gpio_dir)
);

timer_apb u_timer(
.clk(clk),
.reset_n(reset_n),
.apb(apb_bus),
.tick()
);

//spi
spi_apb u_spi(
.clk(clk),
.reset_n(reset_n),
.apb(apb_bus),
.spi_sclk(spi_sclk),
.spi_mosi(spi_mosi),
.spi_cs(spi_cs)
);

axi_stream_source u_axis_src(
.clk(clk),
.reset_n(reset_n),
.data_valid(8'hA5),
.axis(axis_src)
);

axis_fifo u_axis_fifo(
.clk(clk),
.reset_n(reset_n),
.s_axis(axis_src),
.m_axis(axis_fifo_out)
);


stream_processor u_stream_proc(
.clk(clk),
.reset_n(reset_n),
.s_axis(axis_fifo_out),
.m_axis(axis_proc_out)
);

stream_to_axi4 u_stream_to_axi4(
.clk(clk),
.reset_n(reset_n),
.axis(axis_proc_out),
.axi4(axi4_bus)
);

//axi4 ram
axi4_ram u_axi4_ram(
.clk(clk),
.reset_n(reset_n),
.axi(axi4_bus)
);
endmodule
















