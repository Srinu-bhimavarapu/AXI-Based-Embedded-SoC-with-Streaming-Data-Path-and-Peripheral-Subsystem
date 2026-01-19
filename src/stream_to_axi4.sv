`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 02:33:01
// Design Name: 
// Module Name: stream_to_axi4
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
module stream_to_axi4(
input logic clk,
input logic reset_n,

axi_stream_if.slave axis,
axi4_if.master axi4
);

localparam int BURST_LEN=4;

//fsm states
typedef enum logic[2:0] {
ST_IDLE,
ST_AW,
ST_W,
ST_B
}state_t;
state_t state, next_state;

logic [AXI4_ADDR_W-1:0] addr_reg;
logic [ AXI4_DATA_W-1:0] data_reg;
logic [$clog2(BURST_LEN):0] beat_cnt;

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
if(axis.tvalid)
next_state=ST_AW;
end

ST_AW:
begin
if(axi4.awready)
next_state=ST_W;
end

ST_W:
begin 
if(axi4.wready && axis.tvalid && beat_cnt ==BURST_LEN-1)
next_state =ST_B;
end

ST_B:
 begin
 if(axi4.bvalid)
 next_state= ST_IDLE;
 end 
 default: next_state=ST_IDLE;
 endcase
 end
 
 //address ,data and counts
 always_ff@(posedge clk or negedge reset_n)
 begin
 if(!reset_n)
 begin
 addr_reg<=32'h8000_0000;
 beat_cnt<='0;
 end
 
 else begin
 case(state)
 ST_IDLE: begin
 beat_cnt<='0;
 end
ST_W:
 begin 
 if(axi4.wready && axis.tvalid)
 begin
 beat_cnt<=beat_cnt+1'b1;
 addr_reg<=addr_reg+4;
 end
 end
 endcase
 end
 end
 
 //axi stream handshake 
 assign axis.tready=(state==ST_W) && axi4.wready;
 
 //axi4 write address channel 
 
assign axi4.awvalid=(state==ST_AW);
assign axi4.awaddr =addr_reg;
assign axi4.awlen=BURST_LEN-1;

// axi4 write data channel
assign axi4.wvalid=(state==ST_W) && axis.tvalid;
assign axi4.wdata=axis.tdata;
assign axi4.wlast=(beat_cnt== BURST_LEN-1);
assign axi4.bready=1'b1;
endmodule



























