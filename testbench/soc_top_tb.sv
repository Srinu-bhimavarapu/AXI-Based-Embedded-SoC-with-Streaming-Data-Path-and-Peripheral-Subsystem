`timescale 1ns / 1ps
//============================================================
// File: soc_top_tb.sv
// Description: Full SystemVerilog testbench for AXI-based SoC
//============================================================

module soc_top_tb;

  // ---------------------------------------------------------
  // Clock & Reset
  // ---------------------------------------------------------
  logic clk;
  logic reset_n;

  // ---------------------------------------------------------
  // External IO signals
  // ---------------------------------------------------------
  logic [7:0] gpio_in;
  logic [7:0] gpio_out;
  logic [7:0] gpio_dir;

  logic uart_tx;
  logic spi_sclk;
  logic spi_mosi;
  logic spi_cs;

  // ---------------------------------------------------------
  // DUT instantiation
  // ---------------------------------------------------------
  soc_top dut (
    .clk      (clk),
    .reset_n  (reset_n),

    .gpio_in  (gpio_in),
    .gpio_out (gpio_out),
    .gpio_dir (gpio_dir),

    .uart_tx  (uart_tx),

    .spi_sclk (spi_sclk),
    .spi_mosi (spi_mosi),
    .spi_cs   (spi_cs)
  );

  // ---------------------------------------------------------
  // Clock generation : 100 MHz
  // ---------------------------------------------------------
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;   // 10ns period
  end

  // ---------------------------------------------------------
  // Reset task
  // ---------------------------------------------------------
  task apply_reset;
    begin
      reset_n = 1'b0;
      #50;
      reset_n = 1'b1;
      $display("[%0t] RESET RELEASED", $time);
    end
  endtask

  // ---------------------------------------------------------
  // Stimulus process
  // ---------------------------------------------------------
  initial begin
    // Initial values
    gpio_in = 8'h00;

    // Apply reset
    apply_reset();

    // Drive some GPIO inputs
    #100;
    gpio_in = 8'hA5;

    #200;
    gpio_in = 8'h3C;

    // Let system run
    #2000;

    $display("--------------------------------------------------");
    $display("SIMULATION COMPLETED SUCCESSFULLY");
    $display("--------------------------------------------------");
    $finish;
  end

  // ---------------------------------------------------------
  // Simple monitors (text-based debug)
  // ---------------------------------------------------------
  initial begin
    $display("TIME\tRST\tGPIO_OUT\tGPIO_DIR\tSPI_CS\tSPI_MOSI");
    $monitor("%0t\t%b\t%h\t\t%h\t\t%b\t%b",
              $time,
              reset_n,
              gpio_out,
              gpio_dir,
              spi_cs,
              spi_mosi);
  end

  // ---------------------------------------------------------
  // AXI-Stream monitor (internal - optional but useful)
  // ---------------------------------------------------------
  always @(posedge clk) begin
    if (dut.axis_src.tvalid && dut.axis_src.tready) begin
      $display("[%0t] AXIS TRANSFER : tdata = %h",
                $time, dut.axis_src.tdata);
    end
  end

  // ---------------------------------------------------------
  // AXI4 write monitor (DMA activity)
  // ---------------------------------------------------------
  always @(posedge clk) begin
    if (dut.axi4_bus.awvalid && dut.axi4_bus.awready) begin
      $display("[%0t] AXI4 AW : addr = %h len = %0d",
               $time,
               dut.axi4_bus.awaddr,
               dut.axi4_bus.awlen);
    end

    if (dut.axi4_bus.wvalid && dut.axi4_bus.wready) begin
      $display("[%0t] AXI4 W  : data = %h last = %b",
               $time,
               dut.axi4_bus.wdata,
               dut.axi4_bus.wlast);
    end

    if (dut.axi4_bus.bvalid && dut.axi4_bus.bready) begin
      $display("[%0t] AXI4 B  : WRITE RESPONSE RECEIVED",
               $time);
    end
  end

endmodule
