//============================================================
// File: axi4_if.sv
// Description: Simplified AXI4 Write-Only Interface
//============================================================

import params_pkg::*;

interface axi4_if;

  // ---------------------------------------------------------
  // Write Address Channel (AW)
  // ---------------------------------------------------------
  logic [AXI4_ADDR_W-1:0] awaddr;
  logic [7:0]             awlen;
  logic                   awvalid;
  logic                   awready;

  // ---------------------------------------------------------
  // Write Data Channel (W)
  // ---------------------------------------------------------
  logic [AXI4_DATA_W-1:0] wdata;
  logic                   wlast;
  logic                   wvalid;
  logic                   wready;

  // ---------------------------------------------------------
  // Write Response Channel (B)
  // ---------------------------------------------------------
  logic [1:0]             bresp;
  logic                   bvalid;
  logic                   bready;

  // ---------------------------------------------------------
  // AXI4 MASTER modport
  // ---------------------------------------------------------
  modport master (
    // AW
    output awaddr,
    output awlen,
    output awvalid,
    input  awready,

    // W
    output wdata,
    output wlast,
    output wvalid,
    input  wready,

    // B
    input  bresp,
    input  bvalid,
    output bready
  );

  // ---------------------------------------------------------
  // AXI4 SLAVE modport
  // ---------------------------------------------------------
  modport slave (
    // AW
    input  awaddr,
    input  awlen,
    input  awvalid,
    output awready,

    // W
    input  wdata,
    input  wlast,
    input  wvalid,
    output wready,

    // B
    output bresp,
    output bvalid,
    input  bready
  );

endinterface
