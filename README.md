# AXI-Based Embedded SoC with Streaming Data Path and Peripheral Subsystem

## 📌 Project Overview

This project is a **complete SystemVerilog RTL implementation of an AXI-based Embedded System-on-Chip (SoC)**.
It integrates **AXI4, AXI-Lite, AXI-Stream, and APB protocols** in a clean, modular, and industry-aligned architecture.

The goal of this project is to demonstrate **real-world SoC design skills**, including:

* Multi-bus integration
* Control and data plane separation
* Streaming data pipelines
* Peripheral subsystem design
* Protocol-correct RTL implementation

This is a **non-dummy, resume-ready project** suitable for **RTL Design / SoC / VLSI internships**.

---

## 🧠 Key Features

* Fully synthesizable **SystemVerilog RTL**
* Modular IP-based architecture
* AMBA protocol–compliant design
* Clean hierarchy and scalability
* Control path + data path separation
* Ready/Valid handshaking throughout
* Industry-style RTL folder organization

---

## 🏗️ SoC Architecture (High-Level)

### Subsystems

* **AXI-Lite Control Subsystem**

  * Register access and configuration
  * AXI-Lite master controller
  * AXI-Lite interconnect

* **APB Peripheral Subsystem**

  * AXI-Lite to APB bridge
  * UART, SPI, GPIO, Timer peripherals

* **AXI-Stream Data Path**

  * Stream data source
  * FIFO buffering
  * Stream processor

* **AXI4 Memory Interface**

  * Stream-to-AXI4 bridge
  * AXI4 memory-mapped slave

---

## 📂 RTL Directory Structure (Actual Implementation)

```text
rtl/
├── top/
│   └── soc_top.sv
│
├── common/
│   ├── bus_interfaces.sv
│   └── params_pkg.sv
│
├── axi_lite/
│   ├── axi_lite_master_ctrl.sv
│   └── axi_lite_interconnect.sv
│
├── apb/
│   ├── axi_lite_to_apb_bridge.sv
│   ├── uart_apb.sv
│   ├── spi_apb.sv
│   ├── gpio_apb.sv
│   └── timer_apb.sv
│
├── axi_stream/
│   ├── axi_stream_source.sv
│   ├── axis_fifo.sv
│   └── stream_processor.sv
│
└── axi4/
    ├── stream_to_axi4.sv
    └── axi4_slave_mem.sv
```

---

## 🔌 Bus Protocols Used

| Protocol   | Purpose                               |
| ---------- | ------------------------------------- |
| AXI4       | High-performance memory-mapped access |
| AXI-Lite   | Control & configuration registers     |
| AXI-Stream | High-speed streaming data path        |
| APB        | Low-speed peripheral communication    |

---

## ⚙️ Design Highlights

* Parameterized data/address widths
* Protocol-accurate FSMs
* AXI-Stream backpressure handling
* Clean APB SETUP → ACCESS sequencing
* No latch inference
* No combinational loops
* Synthesizable RTL

---

## 🚀 Deployment & Simulation Guide

### 🧰 Prerequisites

* Simulator:

  * Xilinx Vivado (recommended)
  * Questa / ModelSim
  * Synopsys VCS
* OS: Linux or Windows
* Knowledge: SystemVerilog + AMBA protocols

---

📥 Step 1: Clone the Repository
git clone https://github.com/Srinu-bhimavarapu/AXI-Based-Embedded-SoC-with-Streaming-Data-Path.git
cd AXI-Based-Embedded-SoC-with-Streaming-Data-Path

---
📁 Step 2: File Organization

Ensure directories remain unchanged:

src/

testbench/

This structure reflects industry-style RTL organization.

---

▶️ Step 3: Run Simulation (Vivado)
GUI Method

Open Vivado

Create a new RTL Project

Add all files from src/

Add testbench/soc_top_tb.sv

Set soc_top as the top module

Run Behavioral Simulation

#### Tcl Flow (Preferred)

read_verilog src/*.sv
read_verilog testbench/soc_top_tb.sv
set_property top soc_top [current_fileset] 
launch_simulation

### 🧪 Step 4: Testbench Functionality

The testbench validates:

* AXI-Lite register read/write transactions
* APB peripheral access via bridge
* AXI-Stream data generation and flow control
* FIFO buffering and backpressure
* AXI4 memory write/read operations

---

### 🔍 Step 5: Waveform Verification

Verify correct behavior of:

* AXI valid/ready handshakes
* APB state transitions
* FIFO full/empty logic
* AXI-Stream `TVALID / TREADY / TLAST`

Key Signals:

* `AWVALID / AWREADY`
* `WVALID / WREADY`
* `ARVALID / ARREADY`
* `TVALID / TREADY / TLAST`

---

### 🏗️ Step 6: Synthesis Check (Optional)

* Run RTL synthesis
* Ensure:

  * No latches
  * Clean elaboration
  * Synthesizable design

---

## 🧪 Verification Status

* Directed SystemVerilog testbench
* Functional protocol validation

---

## 🎯 Learning Outcomes

* End-to-end SoC RTL integration
* Practical AMBA protocol implementation
* Data path + control path design
* RTL debugging using waveforms
* Industry-ready SoC architecture skills

---

## 📌 Future Enhancements

* UVM testbench
* AXI DMA engine
* Interrupt controller
* Clock gating for low power
* RISC-V CPU integration

---

## 👤 Author

**Srinu Bhimavarapu**
Electronics & Communication Engineering
Focus Areas: RTL Design, SoC Architecture, VLSI

---

## ⭐ Recruiter Note

✔ Hand-written RTL
✔ Protocol-correct AMBA design
✔ Modular and scalable architecture
✔ Simulation-validated SoC

This project demonstrates **design, integration, and deployment skills**, exactly what is expected from a strong RTL/SoC candidate.
