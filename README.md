**Water Level Monitoring and Control System**  

Simulate a water level monitoring and control system. Use dot matrix displays and seven-segment displays to show water level information, and provide alerts when water levels exceed defined ranges. The specific requirements and system functionalities are as follows:  

### Basic Requirements:  

1. **Water Level Input:**  
   The current water level is determined by the values of SW4~SW0, where SW4~SW1 represent the integer part, and SW0 represents the decimal part.  
   - **Safe Level:** 0 to 6 meters (inclusive).  
   - **Warning Level:** 6 to 12 meters (inclusive).  
   - **Danger Level:** Above 12 meters.  

2. **Seven-Segment Display:**  
   Display the water level value on DISP2~DISP0, showing the value to one decimal place.  

3. **Dot Matrix Display (Water Level Visualization):**  
   - When the water level is at or below 6 meters, the bottom two rows of the dot matrix display are fully green.  
   - In the **Warning Level**:  
     - 6~8 meters (inclusive): Illuminate the bottom 3 rows in yellow.  
     - 8~10 meters (inclusive): Illuminate the bottom 4 rows in yellow.  
     - 10~12 meters (inclusive): Illuminate the bottom 5 rows in yellow.  
   - In the **Danger Level**:  
     - 12~13 meters (inclusive): Illuminate the bottom 6 rows in red.  
     - 13~14 meters (inclusive): Illuminate the bottom 7 rows in red.  
     - Above 14 meters: Illuminate the entire matrix in red, flashing at a frequency of 2 Hz.  

4. **Buzzer Alarm:**  
   - Emit an alarm sound when the water level is in the **Warning Level** or **Danger Level**.  
   - The pitch of the alarm increases as the water level rises.  

5. **Water Pump Animation:**  
   - In the **Danger Level**, pressing BTN0 activates a dot matrix animation simulating a water pump draining the water.  
   - The animation continues until the water level drops to the **Safe Level**, and the dot matrix resumes displaying the water level changes.  

6. **Adjustable Pump Speed:**  
   - The water pump has three speed settings: "Slow," "Medium," and "Fast," displayed on DISP7 as 1, 2, and 3, respectively.  
   - Use BTN7 to cycle through the speed settings. The animation speed of water drainage changes accordingly to the selected speed.  
