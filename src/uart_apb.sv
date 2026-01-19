/*`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2026 00:45:51
// Design Name: 
// Module Name: uart_apb
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

// uart_apb 
import params_pkg::*;

module uart_apb(
input logic clk,
input logic reset_n,
apb_if.slave apb,
output logic tx
);

//internal reg
logic[7:0] tx_reg;
logic tx_busy;

assign apb.pready=1'b1;

//apb write logic 
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
tx_reg<=8'h00;
tx_busy<=1'b0;
end

else if(apb.psel && apb.penable && apb.pwrite)
begin

case(apb.paddr)

REG_DATA:
begin
tx_reg<=apb.pwdata[7:0];
tx_busy<= 1'b1;
end

default: 
begin
tx_reg<=tx_reg;
end
endcase
end
else begin
//simulate tx completion 
tx_busy<=1'b0;
end
end

// apb read logic 
always_comb
begin
apb.prdata='0;
case(apb.paddr)

REG_STATUS:
 begin
apb.prdata[0]=tx_busy;
end

REG_DATA:
begin
apb.prdata[7:0]=tx_reg;
end
 default: apb.prdata='0;
 endcase
 end
 //uart tx outputs 
 assign tx=tx_reg[0];
 endmodule
*/

`timescale 1ns / 1ps
//============================================================
// File: uart_apb.sv
// Description: Simple APB UART TX (stub, single-driver safe)
//============================================================

import params_pkg::*;

module uart_apb (
  input  logic clk,
  input  logic reset_n,

  apb_if.slave apb,

  output logic tx
);

  // ---------------------------------------------------------
  // Internal registers
  // ---------------------------------------------------------
  logic [7:0] tx_reg;
  logic       tx_busy;

  // ---------------------------------------------------------
  // APB ready (no wait states)
  // ---------------------------------------------------------
  assign apb.pready = 1'b1;

  // ---------------------------------------------------------
  // APB WRITE logic
  // ---------------------------------------------------------
  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      tx_reg  <= 8'hFF;   // UART idle = 1
      tx_busy <= 1'b0;
    end
    else if (apb.psel && apb.penable && apb.pwrite) begin
      case (apb.paddr)

        REG_DATA: begin
          tx_reg  <= apb.pwdata[7:0];
          tx_busy <= 1'b1;
        end

        default: begin
          tx_reg  <= tx_reg;
          tx_busy <= tx_busy;
        end

      endcase
    end
    else begin
      // Stub behavior: TX completes in 1 cycle
      tx_busy <= 1'b0;
    end
  end

  // ---------------------------------------------------------
  // APB READ logic
  // ---------------------------------------------------------
  always_comb begin
    apb.prdata = '0;

    case (apb.paddr)

      REG_STATUS: begin
        apb.prdata[0] = tx_busy;
      end

      REG_DATA: begin
        apb.prdata[7:0] = tx_reg;
      end

      default: apb.prdata = '0;

    endcase
  end

  // ---------------------------------------------------------
  // UART TX output (SINGLE DRIVER ONLY)
  // ---------------------------------------------------------
  assign tx = tx_reg[0];

endmodule


















