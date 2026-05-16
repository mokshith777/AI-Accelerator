# VLSI Design & AI Hardware Portfolio
### **RTL-to-GDSII | PPA Optimization | Design-for-Test (DFT)**

This repository serves as a technical showcase of my work in digital VLSI design, focusing on the implementation and optimization of AI hardware accelerators. Using the **OpenLane** flow and the **SkyWater 130nm PDK**, I’ve explored the entire silicon lifecycle—from architectural RTL definition to physical sign-off and manufacturing testability.

---

## 🛠️ Technical Toolkit

* **PDK:** SkyWater 130nm (High Density)
* **Digital Flow:** OpenLane (Yosys, OpenROAD, Magic, Netgen)
* **Hardware Description:** Verilog (RTL & Structural)
* **Verification:** Icarus Verilog, GTKWave
* **Physical Analysis:** KLayout (GDSII Inspection), Timing/Power Reporting

---

## 🚀 Project Highlights

### **1. AI Accelerator: PPA Optimization (RTL-to-GDSII)**
**Core Focus:** Navigating the "Power-Performance-Area" triangle.

This project involves the physical implementation of a 4x4 Systolic Array designed for matrix multiplication. Rather than a standard "one-and-done" run, I executed three distinct design strategies to analyze how synthesis constraints impact physical results:

* **High-Performance Run:** Pushed the clock to **194.2 MHz**, involving aggressive gate resizing and clock tree synthesis (CTS) optimizations.
* **Area-Efficient Run:** Minimized silicon footprint to **0.155 mm²** for edge-AI applications.
* **Baseline Run:** Balanced stability and routing congestion at a 65% utilization factor.

**[View Project 1 Details & PPA Tables](./AI_Accelerator_Optimization)**

---

### **2. AI Accelerator: DFT & Diagnostic Fault Analysis**
**Core Focus:** Hardware Reliability and Manufacturing Testability.

Modern silicon is only as good as its testability. In this project, I integrated a **320-bit scan chain** into the systolic array architecture to ensure internal observability. 

* **Fault Injection:** Manually injected a **Stuck-at-1 (SA1)** fault into the processing element (PE) accumulators at the RTL level.
* **Verification:** Utilized a custom scan-testbench to shift out internal states, successfully identifying the exact bit-level failure through the serial `scan_out` pin.
* **Physical Closure:** Met a hold-slack margin of **+1.82ns**, ensuring the scan chain remains stable across the entire chip during high-speed shifting.

**[View Project 2 Fault Analysis & Waveforms](./AI_Accelerator_DFT_Fault_Analysis)**

---

## 💡 Why This Work Matters
The shift toward domain-specific architectures (DSAs) requires engineers who can bridge the gap between high-level AI algorithms and low-level physical constraints. My work here demonstrates a deep-dive into:

1.  **Congestion Management:** Balancing utilization to ensure a design is routable without DRC violations.
2.  **Timing Closure:** Understanding setup/hold margins in a real-world PDK.
3.  **Observability:** Designing hardware that can be diagnosed after it leaves the fab.

---

## 🎓 About Me
I am a technical engineering graduate currently preparing for Master’s studies in Electrical and Computer Engineering. I am passionate about hardware acceleration, VLSI reliability, and the open-source EDA movement.

**Connect with me:**
* **Email:** pandetimokshith@gmail.com
* **Location:** Ashburn, VA

---

### **How to Use the Project READMEs**
Each folder contains its own specialized documentation. If you are looking for **PPA Comparison Tables**, head to Project 1. If you are looking for **Scan-Chain Waveforms and Fault Logic**, head to Project 2.
