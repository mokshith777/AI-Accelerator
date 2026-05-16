# AI Accelerator Optimization: RTL-to-GDSII PPA Analysis
**Architecture:** 4x4 Systolic Array | **Technology:** SkyWater 130nm | **Flow:** OpenLane

This project focuses on the physical design and optimization of a 4x4 Systolic Array tailored for Matrix-Vector Multiplication. The primary objective was to navigate the **PPA (Power, Performance, Area) triangle** by executing multiple design runs with varying synthesis strategies and physical constraints. By manipulating the OpenLane flow, I achieved a high-performance configuration reaching **194 MHz** and an ultra-efficient configuration reducing power consumption by over **50%**.

---

## Architecture & Design Specs

* **Processing Elements (PEs):** 16 independent units featuring 8-bit MAC (Multiply-Accumulate) logic.
* **Precision:** 8-bit integer inputs with 20-bit accumulation to prevent overflow during large matrix operations.
* **Data Flow:** Weight-stationary systolic architecture with optimized data skewing for synchronized pipeline execution.
* **Sign-off Library:** Sky130 High Density (HD) for optimal area utilization.

---

## PPA Comparison Results

The following table summarizes the trade-offs observed across three distinct implementation strategies. Each run was performed using a unique `config.json` profile to prioritize different design goals.

| Metric | Base (Stable) | Fastest (High Performance) | Efficient (Low Power) |
| :--- | :--- | :--- | :--- |
| **Clock Frequency** | 166.6 MHz | **194.2 MHz** | 100 MHz |
| **Clock Period** | 6.0 ns | **5.15 ns** | 10.0 ns |
| **Setup Slack** | 0.78 ns | 0.04 ns | 2.92 ns |
| **Total Power** | ~30 mW | 38.8 mW | **16.2 mW** |
| **Die Area** | ~0.25 mm² | 0.291 mm² | **0.155 mm²** |
| **Cell Count** | ~10,200 | 12,309 | **8,643** |

---

## Engineering Analysis & Trade-offs

### 1. The Performance Ceiling
In the **Fastest Case**, the clock period was tightened to **5.15 ns**. To meet this aggressive target, the synthesis strategy was shifted to `DELAY 1`, which prioritizes timing over area. This resulted in a **20.6% increase in cell count** compared to the base case, as the tool inserted high-drive buffers and upsized gates to minimize path delays.

### 2. Area vs. Routability
For the **Efficient Case**, the core utilization was maintained at a higher level while relaxing timing. By lowering the frequency to 100 MHz, the router successfully reduced the die area to **0.155 mm²**. This demonstrates that for edge-AI applications where latency is secondary to cost and battery life, relaxing timing constraints can yield a **~38% area saving**.

### 3. Power Density
The total power jumped from **16.2 mW** to **38.8 mW** when moving from the Efficient to the Fastest run. This nearly 2.4x increase highlights the non-linear relationship between frequency and power, driven by both increased switching activity and the addition of larger, high-leakage cells required for timing closure.

---

## Physical Design Gallery

### **GDSII Layout Comparison**
Below are the finalized GDSII layouts generated via the OpenLane flow.

* **Base Layout:** Stable routing with 65% utilization.
* **Fastest Layout:** Dense logic placement with aggressive timing buffers (see highlighted regions).
* **Efficiency Layout:** Compact footprint optimized for minimum silicon area.

![Base Layout](./assets/visuals/base_layout.png)
![Fastest Layout](./assets/visuals/fastest_layout.png)
![Efficient Layout](./assets/visuals/efficient_layout.png)

### **Standard Cell Detail**
This zoomed-in view from KLayout shows the high-density standard cell placement and the Metal-1/Metal-2 routing layers that form the internal processing elements.

![Efficient Zoom](./assets/visuals/efficient_zoom.png)

---

## Repository Structure

* `hdl/`: Verilog source code for the systolic array and PEs.
* `tb/`: Testbenches for functional verification.
* `assets/netlist/`: Gate-level netlists for all three optimization runs.
* `assets/reports/`: Detailed timing summaries, power reports, and area statistics.
* `assets/visuals/`: GDSII screenshots and layout inspections.
* `assets/waveforms/`: GTKWave captures validating the 4x4 array's arithmetic correctness.

---

## How to Replicate
1. Ensure **Docker** and **OpenLane** are installed on your environment.
2. Clone this repository.
3. To run a specific optimization, copy the corresponding `config.json` from `assets/reports/<case>/` to the root directory.
4. Run: `./flow.tcl -design . -tag <your_tag>`
