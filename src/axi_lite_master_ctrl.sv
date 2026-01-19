`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 21:48:59
// Design Name: 
// Module Name: axi_lite_master_ctrl
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

//axi_lite_master_ctrl 
import params_pkg::*;
module axi_lite_master_ctrl(
input logic clk,
input logic reset_n,
axi_lite_if.master axi
);

typedef enum logic[3:0]{
ST_IDLE,
ST_WADDR,
ST_WDATA,
ST_WRESP,
ST_RADDR,
ST_RDATA,
ST_DONE
}state_t;
state_t state,next_state;

// transaction registers

logic[AXI_ADDR_W-1:0] addr_reg;
logic[AXI_DATA_W-1:0] wdata_reg;

//example burst sequence
localparam logic[AXI_ADDR_W-1:0] UART_TX_ADDR=UART_BASE+REG_DATA;
localparam logic[AXI_DATA_W-1:0] UART_BOOT_MSG=32'h0000_0048;

//fsm sequential
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
state<=ST_IDLE;
else
state<=next_state;
end 

//fsm combinational
always_comb
begin

next_state=state;

case(state)

ST_IDLE:
 begin
next_state=ST_WADDR;
end

ST_WADDR:
begin
if(axi.awready)
next_state=ST_WDATA;
end

ST_WDATA:
begin
if(axi.wready)
next_state=ST_WRESP;
end

ST_WRESP:
begin
if(axi.bvalid)
next_state=ST_DONE;
end

ST_DONE:
begin
next_state=ST_DONE;
end

default: next_state=ST_IDLE;

endcase
end

//address & data set up

always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
addr_reg<='0;
wdata_reg<='0;
end

else if(state==ST_IDLE)
begin
addr_reg<=UART_TX_ADDR;
wdata_reg<=UART_BOOT_MSG;
end
end

//axi_lite outputs 
assign axi.awvalid=(state==ST_WADDR);
assign axi.awaddr=addr_reg;
assign axi.wvalid=(state==ST_WDATA);
assign axi.wdata=wdata_reg;
assign axi.bready=1'b1;
//no reads on this phase 
assign axi.arvalid=1'b0;
assign axi.araddr='0;
assign axi.rready=1'b1;
endmodule



























 
