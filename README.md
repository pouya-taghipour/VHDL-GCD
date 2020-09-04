# VHDL-GCD
  * Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
  * Address:  https://github.com/pouya-taghipour
  * Date:     August, 2020.
  * License:  Gnu public license v3.0

# Things you should know:
1) What is Great Common Divisor (GCD)? ->  Read https://en.wikipedia.org/wiki/Greatest_common_divisor. 

2) The proposed circuit has used "Euclid's algorithm" to calculate GCD. For this porpuse, a C++ function and a flowchart diagram have been created that you can find them in GCD repository main directory.
   
3) The circuit has been designed based on FSM ( Finite State Machine ) + Datapath technique. The FMS diagram is in directory. See it first.

4) Mathematically GCD(x,y) = GCD(Y,X), so the circuit produces same value for (x,y) or (y,x).

5) For different data width just change generic value in top-level & testbench entities. 

6) Implementation result of proposed circuit for 32 bit data with  on XC6SLX9-TQGG144 (Speed -3) hase been as below:
   * Number of Slice Registers: 115 (1%)
   * Number of Slice LUTs: 102 (1%)
   * Number of MUXCYs: 96 (3%)
   * Number of DSP: 0   
   * Maximum Frequency: 327.665MHz
   



    





