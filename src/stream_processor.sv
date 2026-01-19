//============================================================
// File: stream_processor.sv
// Description: AXI-Stream pass-through processor
//============================================================

import params_pkg::*;

module stream_processor (
  input  logic clk,
  input  logic reset_n,

  axi_stream_if.slave  s_axis,
  axi_stream_if.master m_axis
);

  // ---------------------------------------------------------
  // Simple pass-through logic
  // ---------------------------------------------------------
  assign m_axis.tdata  = s_axis.tdata;
  assign m_axis.tvalid = s_axis.tvalid;
  assign m_axis.tlast  = s_axis.tlast;

  assign s_axis.tready = m_axis.tready;

endmodule
