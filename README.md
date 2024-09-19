Eco-Friendly Intelligent Traffic Light System
Overview
This project focuses on optimizing vehicle speed to reduce fuel consumption and CO2 emissions by integrating an intelligent traffic light system. The system leverages traffic light data to recommend speeds that align with eco-friendly driving practices.

Technologies Used
ESP32 (Traffic Light)

Inputs: Power source
Outputs: Traffic light data (current phase, time remaining, full timings)
Functionality: Controls traffic light phases and timings; communicates data to vehicles.
ESP32 (Vehicle)

Inputs: Traffic light data
Outputs: Traffic light data
Functionality: Receives data from the traffic light and transmits it to the Arduino via serial communication.
Arduino

Inputs: Power source, distance sensor readings, traffic light data
Outputs: Recommended speed
Functionality: Processes data from ESP32 to calculate and recommend speed.
Motor Driver

Inputs: 12V
Outputs: Motor direction and speed
Functionality: Controls the movement and direction of the DC motor.
DC Motor

Inputs: 12V
Outputs: Wheel rotation
Functionality: Converts electrical energy into mechanical energy for movement.
TFmini Sensor

Inputs: 5V
Outputs: Distance measurement
Functionality: Measures distance between the sensor and a target object.
Libraries Used:

ESPNow Library: Enables communication between ESP8266 and ESP32 modules over a low-power Wi-Fi network.
Wi-Fi Library: Connects Arduino to Wi-Fi networks for IoT applications.
Motor Control Library: Facilitates control of the DC motor (speed, direction).
TFmini Sensor Library: Interfaces with the TFmini sensor for accurate distance measurements.
Remote Control Interface Library: Integrates remote control for user input interpretation.
Implementation
Prototype Implementation:

Osoyoo Robot Car: Initial testing revealed limited speed range; replaced with a more suitable car.
RN AI Car: Provided noticeable speed differences but faced steering challenges.
DC Motor Implementation:

The DC motor controls the car's movement, with hardware setup illustrated in provided figures.
Design Verification
Test Cases:
Car Test #1: Ensured the system's recommended speed falls between minimum and maximum road speeds.
Car Test #2: Verified the maximum and minimum speeds against engineering requirements.
Experiment Scenarios
First Scenario: Computed recommended speed based on traffic light phases to synchronize with green light and optimize vehicle response.

Second Scenario: Used the VT-Micro model to estimate fuel consumption and CO2 emissions based on vehicle speed and acceleration.
