**Water Level Monitoring and Control System**  

The **Water Level Monitoring and Control System** is a Verilog-based design that simulates water level monitoring and control functionality. It includes various features, such as water level visualization, alerts, and dynamic animations. The project emphasizes a modular, hierarchical approach to ensure clarity, scalability, and efficient management of system complexity.

### System Overview  

The system monitors water levels using switches, displays the water level visually through seven-segment displays and a dual-color dot matrix, and triggers alerts when thresholds are exceeded. Additionally, it incorporates interactive controls for managing water levels and simulating water pump operations.

### Design Methodology  

This system adopts a **Bottom-up Design** approach, starting from basic modules and integrating them into higher-level functionalities. The key methodologies include:  
- **Design Abstraction:** Simplifies system complexity through hierarchical levels.  
- **Modular Design:** Encapsulates each function (e.g., timing, water level control, display updates) into independent modules.  
- **Hierarchical Integration:** The top-level module integrates all sub-modules into a cohesive system.  

---

### System Design and Features  

#### **Top-Level Module:** WaterController  
This module oversees overall system behavior by coordinating sub-modules.

**Sub-Modules:**  
1. **SwitchInputManager:** Processes water level input from SW4~SW0 switches.  
2. **DisplayController:** Manages water level display on DISP2~DISP0 and dot matrix animations.  
3. **AlertManager:** Handles buzzer alarms for warning and danger levels.  
4. **PumpController:** Simulates water pump operation and adjusts speeds based on user input.  
5. **AnimationManager:** Generates animations for water drainage during pump operation.  

---

### Functional Specifications  

1. **Water Level Input and Thresholds:**  
   - Water level is determined using SW4~SW0.  
     - **SW4~SW1:** Integer part of the level.  
     - **SW0:** Decimal part of the level.  
   - **Threshold Levels:**  
     - **Safe Level:** 0 to 6 meters (inclusive).  
     - **Warning Level:** 6 to 12 meters (inclusive).  
     - **Danger Level:** Above 12 meters.  

2. **Seven-Segment Display:**  
   - Displays the current water level on DISP2~DISP0 to one decimal place.  

3. **Dot Matrix Visualization:**  
   - **Safe Level (≤6m):** Bottom 2 rows are fully green.  
   - **Warning Level (6–12m):**  
     - 6–8m: Bottom 3 rows in yellow.  
     - 8–10m: Bottom 4 rows in yellow.  
     - 10–12m: Bottom 5 rows in yellow.  
   - **Danger Level (>12m):**  
     - 12–13m: Bottom 6 rows in red.  
     - 13–14m: Bottom 7 rows in red.  
     - Above 14m: Entire matrix is red, flashing at 2 Hz.  

4. **Buzzer Alerts:**  
   - Activates in **Warning** and **Danger Levels.**  
   - Pitch increases with water level to indicate rising severity.  

5. **Water Pump Simulation:**  
   - Activated by BTN0 during **Danger Level.**  
   - Animates water drainage on the dot matrix display until water level drops to **Safe Level.**  
   - Animation speed is adjustable through BTN7.  
     - Displayed on DISP7 as 1 (slow), 2 (medium), or 3 (fast).  

---

### Design Abstraction and Modularity  

The system is abstracted at multiple levels:  
- **System Level:** The WaterController module integrates and abstracts sub-modules.  
- **Functional Level:** Each sub-module manages specific tasks, such as display control or input processing.  
- **Hardware Abstraction:** Encapsulates hardware-specific details within sub-modules.  

---

### Development Process  

1. **Foundational Modules:**  
   - Timer: Generates timing signals.  
   - SwitchInputManager: Handles water level inputs.  
   - AlertManager: Implements alarm logic.  

2. **Intermediate Layers:**  
   - DisplayController: Manages visualization.  
   - PumpController: Simulates water pump functions.  

3. **Integration:**  
   - Combine all sub-modules into the WaterController module.  
   - Conduct iterative testing for smooth integration.  

---

### Tools and Verification  

- **Simulation:** Validate system functionality before implementation.  
- **Synthesis:** Optimize design for timing constraints and resource efficiency.  
- **Debugging:** Use tools to verify signal integrity and module behavior.  

---

### Conclusion  

The **Water Level Monitoring and Control System** demonstrates a systematic approach to designing a complex digital system. Its modular, hierarchical design ensures maintainability, scalability, and adaptability for future enhancements.
