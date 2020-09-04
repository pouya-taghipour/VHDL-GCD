
-----


-- Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
-- Address:  https://github.com/pouya-taghipour
-- Date:     August, 2020.
-- License:  Gnu public license v3.0


-- File name: FSM_Controller.VHDL


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity FSM_GCD is
    
	 port
	 (
			FSM_Reset        : in  std_logic;
			FSM_Clock        : in  std_logic;
			FSM_Start        : in  std_logic;
			FSM_Comp_Equ     : in  std_logic;
			FSM_Comp_NEqu    : in  std_logic;
				
			FSM_MUX_Select_X  : out  std_logic;
			FSM_MUX_Select_Y  : out  std_logic;
			FSM_MUX_Load_X    : out  std_logic;
			FSM_MUX_Load_Y    : out  std_logic;
			Update_GCD        : out  std_logic
    );
	 
end FSM_GCD;


architecture FSM_GCD_Arch of FSM_GCD is

    type States is ( State0, State1, State2, State3,  State4,  State5,  State6,
							State7, State8, State9, State10, State11, State12 );
    signal Next_State, Current_State: states;

begin
   
	 process(FSM_Reset, FSM_Clock )
    begin
			if( FSM_Reset = '1' ) then 
				 Current_State <= State0;
			elsif( rising_edge(FSM_Clock) ) then 
				 Current_State <= Next_State;
			end if;
    end process;
	 
    process( FSM_Start, FSM_Comp_Equ, FSM_Comp_NEqu, Current_State )
    begin
				case Current_State is 
								
				-- Do nothing
				when State0 =>	
						Update_GCD       	<= '0'; -- Reg_Out do not accept new value as default
						FSM_MUX_Select_X 	<= '0'; -- X is selected as default
						FSM_MUX_Select_Y 	<= '0'; -- Y is selected as default
						FSM_MUX_Load_X   	<= '0'; -- Reg_X do not accept new value as default
						FSM_MUX_Load_Y   	<= '0'; -- Reg_Y do not accept new value as default
						Next_State 			<= State1;						
						
				-- Start Signal Detection
				when State1 =>
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0'; 
						FSM_MUX_Select_Y  <= '0'; 
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';
						if( FSM_Start = '1' ) then 
							 Next_State <= State2;
						else 
							 Next_State <= State1;
						end if;
						
						
				-- Load X
				when State2 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0'; 
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '1'; -- X will load in RegX
						FSM_MUX_Load_Y    <= '0';
						Next_State        <= State3;
						
				-- Load Y
				when State3 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '1'; -- Y will load in RegY
						Next_State        <= State4;
						
						
				-- NEquality Checking
				when State4 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';						
						if( FSM_Comp_NEqu ='0' ) then --- if x = y
							 Next_State       <= State10;
						else
							 Next_State       <= State5;
						end if;
						
				-- Finding Greater/Smaller
				when State5 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';						
						if( FSM_Comp_Equ ='1' ) then --- if x < y
							 Next_State       <= State6;
						else
							 Next_State       <= State7;
						end if;
						
				-- y = sub(y-x)
				when State6 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '1'; -- Select Mux_Port2 which is sub(y-x)
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '1'; -- Save new value to Regy
						Next_State <= State8;
						
             -- x = sub(x-y)
				when State7 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '1'; -- Select Mux_Port2 which is sub(x-y)
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '1'; -- Save new value to Regx
						FSM_MUX_Load_Y    <= '0';
						Next_State <= State8;
						
				-- Do nothing
				when State8 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';
						Next_State <= State9;
						
				-- Back to Equality Checking
				when State9 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';
						Next_State <= State4;
							
				-- Update Output Register
				when State10 =>	
						Update_GCD        <= '1';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';
						Next_State        <= State11;
						
				-- End of the loop
				when State11 =>	
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';
						Next_State        <= State0;	

				when others =>
						Update_GCD        <= '0';
						FSM_MUX_Select_X  <= '0';
						FSM_MUX_Select_Y  <= '0';
						FSM_MUX_Load_X    <= '0';
						FSM_MUX_Load_Y    <= '0';
						Next_State        <= State0;
        end case;
	
    end process;
	
end FSM_GCD_Arch;