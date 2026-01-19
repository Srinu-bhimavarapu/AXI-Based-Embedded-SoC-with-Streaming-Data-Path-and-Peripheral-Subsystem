`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 23:55:16
// Design Name: 
// Module Name: axi_lite_to_apb_bridge
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

//axi_lite slave to apb master bridge
import params_pkg::*;

module axi_lite_to_apb_bridge(
input logic clk,
input logic reset_n,

//axi_lite slave side

axi_lite_if.slave axi,

//apb master side 
apb_if.master apb
);

//fsm states
typedef enum logic[2:0] {
ST_IDLE,
ST_WSETUP,
ST_WACCESS,
ST_RSETUP,
ST_RACCESS
}state_t;

state_t state, next_state;

// internal registers
logic[AXI_ADDR_W-1:0] addr_reg;
logic[AXI_DATA_W-1:0] wdata_reg;

//fsm sequential 
always_ff@(posedge clk or negedge reset_n)
begin

if(!reset_n)
state<=ST_IDLE;
else
state<=next_state;
end

//fsm combonational 
always_comb
begin

next_state=state;

case(state)

ST_IDLE:
begin
if(axi.awvalid)
next_state=ST_WSETUP;
else if(axi.arvalid)
next_state=ST_RSETUP;
end
ST_WSETUP: next_state=ST_WACCESS;
ST_WACCESS: if(apb.pready) next_state=ST_IDLE;
ST_RSETUP: next_state=ST_RACCESS;
ST_RACCESS: if(apb.pready) next_state=ST_IDLE;

default: next_state=ST_IDLE;
endcase
end

//addresss & data latching 
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
addr_reg<='0;
wdata_reg<='0;
end
else 
begin
if(state==ST_IDLE && axi.awvalid)
begin
addr_reg<=axi.awaddr;
wdata_reg<=axi.wdata;
end

else if (state==ST_IDLE && axi.arvalid)
begin
addr_reg<=axi.araddr;
end
end
end

//axi lite outputs 

assign axi.awready=(state==ST_IDLE)&& axi.wvalid;
assign axi.wready=(state==ST_IDLE) && axi.awvalid;
assign axi.arready=(state==ST_IDLE);
assign axi.bvalid=(state==ST_WACCESS && apb.pready);
assign axi.bresp=RESP_OKAY;
assign axi.rvalid=(state==ST_RACCESS && apb.pready);
assign axi.rdata=apb.prdata;
assign axi.rresp=RESP_OKAY;

//APB outputs 
assign apb.paddr=addr_reg[APB_ADDR_W-1:0];
assign apb.pwdata=wdata_reg;
assign apb.pwrite = (state==ST_WSETUP || state==ST_WACCESS);
assign apb.psel=(state==ST_WSETUP || state==ST_WACCESS || state==ST_RSETUP || state==ST_RACCESS);
assign apb.penable=(state==ST_WACCESS || state == ST_RACCESS);

endmodule













