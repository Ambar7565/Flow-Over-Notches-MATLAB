# Flow-Over-Notches-MATLAB
MATLAB program for the Flow Over Notches experiment performed in the Unit Operations Laboratory.


## Objective

The aim of this experiment is to determine the coefficient of
discharge (Cd) for:

- Rectangular Notch
- 45° V-Notch
- 60° V-Notch

## About the Program

The program takes the experimental readings as input and calculates
the actual discharge and coefficient of discharge.

The number of readings is entered by the user, so the program can
be used for different numbers of observations.

## Inputs

For each reading, the program asks for:

- Water head, H (cm)
- Rise of water level, R (cm)
- Time, t (s)

## Calculations

The actual discharge is calculated using:

Q = A × R / (t × 100)

For the rectangular notch:

Q = (2/3) Cd L √(2g) H^(3/2)

For the V-notch:

Q = (8/15) Cd tan(θ/2) √(2g) H^(5/2)

The program calculates Cd for both 45° and 60° V-notches.

## Output

The program gives:

- Actual discharge
- Coefficient of discharge for each reading
- Average coefficient of discharge
- Observation table
- Graphs for the calculated results

## How to Run

1. Open the `.m` file in MATLAB.
2. Run the program.
3. Enter the number of readings.
4. Enter H, R and time for each reading.
5. The calculated results and graphs will be displayed.

## Software Used

MATLAB

## Experiment

Flow Over Notches  
Unit Operations Laboratory  
Chemical Engineering

## Author

Ambar Pandey
Chemical Engineering Student 
