# VHDL-GCD
  * E-mail:   pouya.taghipour@gmail.com
  * Date:     August, 2020.
  * License:  Gnu public license v3.0

# Things you should know:
1) What is Great Common Divisor (GCD)? ->  Read https://en.wikipedia.org/wiki/Greatest_common_divisor. 
2) The proposed circuit is designed based on "Euclid's algorithm" to calculate Great Common Divisor. You can find a C++ implementation and related flowchart in GCD repository main directory.
   
3) The circuit has been designed based on FSM ( Finite State Machine ) + Datapath technique. The FMS diagram is in directory. See it first.

4) We know that GCD(x,y) = GCD(y,x), so the circuit produces same value for (x,y) or (y,x).

5) For different data width just change generic value in top-level & testbench entities. 

6) Implementation result of proposed circuit for 32 bit data with  on XC6SLX9-TQGG144 (Speed -3) are as below:
   * Number of Slice Registers: 115 (1%)
   * Number of Slice LUTs: 102 (1%)
   * Number of MUXCYs: 96 (3%)
   * Number of DSP: 0   
   * Maximum Frequency: 327.665MHz
   



    





