`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 17:09:02
// Design Name: 
// Module Name: params_pkg
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

package params_pkg;

//global enable
parameter bit SOC_ENABLE=1'b1;

// axi/apb widths 

parameter int AXI_ADDR_W=32;
parameter int AXI_DATA_W=32;

parameter int APB_ADDR_W=16;
parameter int APB_DATA_W=32;

//AXI STREAM
parameter int AXIS_DATA_W=32;

//FIFO CONFIGURATION
parameter int FIFO_DEPTH=16;
localparam int FIFO_ADDR_W=$clog2(FIFO_DEPTH);

//AXI4 memory
parameter int AXI4_ADDR_W=32;
parameter int AXI4_DATA_W=32;
parameter int AXI4_MAX_BURST=16;

//address map (axi lite)
parameter logic[AXI_ADDR_W-1:0]  UART_BASE=32'h0000_0000;
parameter logic[AXI_ADDR_W-1:0]  SPI_BASE=32'h0000_1000;
parameter logic[AXI_ADDR_W-1:0]  GPIO_BASE=32'h0000_2000;
parameter logic[AXI_ADDR_W-1:0]  TIMER_BASE=32'h0000_3000;
parameter logic[AXI_ADDR_W-1:0]  STATUS_BASE=32'h0000_4000;
   

// APB REGISTER OFF SETS
 parameter logic[APB_ADDR_W-1:0]  REG_CTRL=16'h0000;
 parameter logic[APB_ADDR_W-1:0]  REG_STATUS=16'h0004;
 parameter logic[APB_ADDR_W-1:0]  REG_DATA=16'h0008;
 
 // common enums 
 typedef enum logic[1:0] {
 RESP_OKAY=2'b00,
 RESP_SLVERR=2'b10
 }axi_resp_t;
 
 endpackage
 



















