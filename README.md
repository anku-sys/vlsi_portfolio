# 💻 VLSI & RTL Design Portfolio 
**Author:** Ankush Rai (ECE, 6th Semester)  
**Tools Used:** Icarus Verilog (`iverilog`), GTKWave, VS Code, Linux (WSL)

Welcome to my Hardware Design portfolio! This repository tracks my journey from writing basic combinational logic to designing a custom Machine Learning Hardware Accelerator. All modules are written in Verilog and verified using testbenches to ensure cycle-accurate behavior.

---

## 🚀 The Capstone: K-Means ML Hardware Accelerator
The highlight of this repository is a parallel spatial computing engine designed for Edge AI inference. While software ML models run sequentially on CPUs/GPUs, this custom RTL design computes distances and assigns clusters in hardware with zero software overhead.

* **`manhattan_distance.v`**: A hardware-optimized distance calculator. To save silicon area and power, it replaces the heavy Euclidean distance (squares and square roots) with Manhattan distance (absolute differences and additions) using comparators and MUX logic.
* **`cluster_assigner.v`**: The core ML inference engine. It instantiates multiple distance calculators in parallel to instantly compare a new data point's distance against multiple centroids, outputting the predicted `cluster_id` in a single pipeline stage.

---

## 📁 Repository Contents (Level-Up Architecture)

### 1. Compute & Datapath (`mac.v`)
* **Multiply-Accumulate (MAC) Unit**: The fundamental muscle of any AI chip. Calculates `Output = Output + (A * B)` continuously. Built with proper bit-width expansion (8-bit inputs $\rightarrow$ 16-bit output) to prevent integer overflow.

### 2. Control Systems (`traffic_light.v`)
* **Finite State Machine (FSM)**: A two-block Moore/Mealy FSM architecture separating state memory (sequential) and next-state logic (combinational) to control traffic lights based on sensor inputs.

### 3. Data Management (`fifo.v`)
* **Synchronous FIFO**: A critical data buffer mechanism used between different clock domains or varying data rates. Features circular read/write pointers and cycle-accurate `full` and `empty` flag generation.

### 4. Basic Memory & Logic
* **`counter.v`**: A 4-bit synchronous up-counter.
* **`dff.v`**: Edge-triggered Data Flip-Flop.
* **`and_gate.v`**: Basic combinational logic.

### 5. Adders & Arithmetic Logic Unit (ALU)
* **`alu_8bit.v`**: A multi-function 8-bit Calculator/ALU executing addition, subtraction, multiplication, and division based on a 2-bit opcode, including divide-by-zero hardware exception handling.
* **`rca_4bit.v` & `cla_4bit.v`**: Area vs. Speed tradeoff demonstration. Synthesized using Yosys to compare the low-area Ripple Carry Adder against the high-speed Carry Look-Ahead Adder.
---

## 🛠️ How to Run the Simulations

You can compile and simulate any of these modules locally using Icarus Verilog and GTKWave. 

**Example (Running the ML Cluster Assigner):**
```bash
# 1. Compile the Verilog files
iverilog -o cluster_sim cluster_assigner.v manhattan_distance.v cluster_assigner_tb.v

# 2. Run the simulation
vvp cluster_sim

# 3. View the waveforms
gtkwave cluster.vcd &
