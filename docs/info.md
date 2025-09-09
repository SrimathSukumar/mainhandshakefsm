
### **How It Works**

The **Handshake FSM** (Finite State Machine) implements a simple 2-state handshake protocol:

1. **States:**

   * **IDLE:** The FSM waits for a request (`req`) signal.
   * **ACK\_STATE:** When a request is detected, the FSM asserts the acknowledgment (`ack`) signal.

2. **Operation:**

   * When `req` goes high, the FSM transitions from **IDLE** to **ACK\_STATE** and sets `ack = 1`.
   * When `req` goes low, the FSM returns to **IDLE**, resetting `ack = 0`.

3. **Signal Mapping:**

   * In the `tt_um_example` template, `req` is mapped to **ui\_in\[0]**, and `ack` is mapped to **uo\_out\[0]**.
   * Unused IO pins (`uio_in`, `uio_out`) are tied to zero.
   * The FSM operates synchronously with the clock and resets with an active-low `rst_n`.

---

### **How to Test**

The design can be tested in **simulation** and **on external hardware**:

1. **Simulation:**

   * Use the provided testbench to drive `ui_in[0]` (request) and observe `uo_out[0]` (acknowledge).
   * Check that `ack` goes high when `req` is high and returns low when `req` goes low.
   * Waveforms can be viewed using **VCD files** in **GTKWave** or other waveform viewers.

2. **External Hardware:**

   * **Arduino Uno** is used to generate input signals (`req`) using push buttons.
   * The acknowledgment (`ack`) output is observed on an LED.
   * Other unused IOs remain unconnected or tied to ground.

---

### **External Hardware Used**

| Component          | Purpose                                       |
| ------------------ | --------------------------------------------- |
| Arduino Uno        | Generates input request signals (`req`)       |
| Push Buttons       | Manual control for request signal             |
| LED Display        | Visual indication of acknowledgment (`ack`)   |
| Breadboard / Wires | Connect Arduino outputs to FSM inputs/outputs |


