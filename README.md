🧠 Synchronous FIFO Memory in Verilog

A FIFO is a fundamental digital structure for data buffering and synchronization, where the first data written is the first to be read. This project implements the FIFO memory module using Verilog HDL, simulating and verifying its behavior using ModelSim. 

Key features include:

✅ Clock-controlled read and write operations

✅ Status flags: full, empty, overflow, and underflow

✅ Threshold indicator to monitor buffer usage

⚙️ Features

✅ Synchronous Operation: All operations are driven by a single clock signal.

✅ Read/Write Control: Controlled via read_en and write_en signals.

✅ Pointers & Count Register: Manage the memory buffer for proper sequencing.

✅ Status Flags:

📌full: Buffer is full

📌empty: Buffer is empty

📌overflow: Write attempted when buffer is full

📌underflow: Read attempted when buffer is empty

📌Threshold Indicator: Monitors buffer usage (e.g., 50% full).

🧪 Simulation Scenarios 

✅ Scenario 1: Sequential Write and Read

Action: Five values are written in sequence, followed by five read operations.

Result: Data is read in the same order as written, maintaining FIFO behavior.

✅ Scenario 2: Alternate Write and Read

Action: Write and read operations alternate (write → read → write → read…).

Result: The FIFO correctly handles the operations, preventing overflow/underflow.

✅ Scenario 3: Overflow and Underflow

Action:
FIFO is filled to max capacity → triggers full flag.
Additional write causes overflow.
All data is read → triggers empty flag.
Extra read causes underflow.

Result: All status flags respond correctly, confirming reliable control logic.
