

-- Title:    A Circuit to calculate GCD of two n-bit integer number
-- Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
-- Address:  https://github.com/pouya-taghipour
-- Date:     August, 2020.
-- License:  Gnu public license v3.0

-- File name: GCD_Top.VHDL

-------------------------------------------------------------
-------------------------------------------------------------
 
----------------------   GCD_TOP    -------------------------

-------------------------------------------------------------
-------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity gcd_toplevel is

    generic ( WidthSizeTop : integer := 32);

    port
	 (
	      i_clock_top  : in std_logic; 
			i_reset_top  : in  std_logic; 			
			i_start_top  : in  std_logic; 
		   i_input1_top : in  std_logic_vector( WidthSizeTop-1 downto 0 ); 
			i_input2_top : in  std_logic_vector( WidthSizeTop-1 downto 0 ); 		
		   o_output_top : out std_logic_vector( WidthSizeTop-1 downto 0 ) 
    );
	 
end gcd_toplevel;

architecture struct of gcd_toplevel is
 
	signal sig_equ         : std_logic;
	signal sig_nequ        : std_logic;
	
	signal sig_select_x    : std_logic;  
	signal sig_load_x      : std_logic;
	signal sig_reg_x : std_logic_vector(WidthSizeTop-1 downto 0);
	
	signal sig_select_y    : std_logic; 	   
	signal sig_load_y      : std_logic;  
	signal sig_reg_y : std_logic_vector(WidthSizeTop-1 downto 0);	
	
	
	signal sig_register_en : std_logic; 
	
	signal sig_x_int : std_logic_vector(WidthSizeTop-1 downto 0);
	signal sig_x_sub : std_logic_vector(WidthSizeTop-1 downto 0);
	
	signal sig_y_int : std_logic_vector(WidthSizeTop-1 downto 0);
	signal sig_y_sub : std_logic_vector(WidthSizeTop-1 downto 0);

 

	COMPONENT FSM_GCD	
		PORT(
			FSM_Reset : IN std_logic;
			FSM_Clock : IN std_logic;
			FSM_Start : IN std_logic;
			FSM_Comp_Equ : IN std_logic;
			FSM_Comp_NEqu : IN std_logic;          
			FSM_MUX_Select_X : OUT std_logic;
			FSM_MUX_Select_Y : OUT std_logic;
			FSM_MUX_Load_X : OUT std_logic;
			FSM_MUX_Load_Y : OUT std_logic;
			Update_GCD : OUT std_logic
			);
	END COMPONENT;



	COMPONENT Comp_greater
		GENERIC ( Size : integer );
		PORT(
			Input1 : IN std_logic_vector(WidthSizeTop-1 downto 0);
			Input2 : IN std_logic_vector(WidthSizeTop-1 downto 0);          
			result : OUT std_logic
			);
	END COMPONENT;

	  
	COMPONENT Comp_nequ
		GENERIC ( Size : integer );
		PORT(
			Input1 : IN std_logic_vector(WidthSizeTop-1 downto 0);
			Input2 : IN std_logic_vector(WidthSizeTop-1 downto 0);          
			result : OUT std_logic
			);
	END COMPONENT;
		
		
	COMPONENT Multiplexer
		GENERIC ( Size : integer );
		PORT(
			MuxPort1 : IN std_logic_vector(WidthSizeTop-1 downto 0);
			MuxPort2 : IN std_logic_vector(WidthSizeTop-1 downto 0);
			MuxSel : IN std_logic;          
			MuxOutput : OUT std_logic_vector(WidthSizeTop-1 downto 0)
			);
	END COMPONENT;
		
	COMPONENT RegMem
		GENERIC ( Size : integer );
		PORT(
			RegMem_Clock : IN std_logic;
			RegMem_Reset : IN std_logic;
			RegMem_Load : IN std_logic;
			RegMem_Input : IN std_logic_vector(WidthSizeTop-1 downto 0);          
			RegMem_Output : OUT std_logic_vector(WidthSizeTop-1 downto 0)
			);
	END COMPONENT;
		
		
	COMPONENT Subtractor
		GENERIC ( Size : integer );
		PORT(
			Input1 : IN std_logic_vector(WidthSizeTop-1 downto 0);
			Input2 : IN std_logic_vector(WidthSizeTop-1 downto 0);          
			Output : OUT std_logic_vector(WidthSizeTop-1 downto 0)
			);
	END COMPONENT;
	
	
begin 
 
  u0 : Comp_greater 
  generic map (Size => WidthSizeTop)
  port map(	sig_reg_x,sig_reg_y,sig_equ );
  
  u1 : Comp_nequ 
  generic map (Size => WidthSizeTop)
  port map(sig_reg_x,sig_reg_y,sig_nequ);
    
  
  u2 : Multiplexer -- poer1: x , port2=x-y
  generic map (Size => WidthSizeTop)
  port map(i_input1_top, sig_x_sub,sig_select_x, sig_x_int);  
  
  u3 : Multiplexer -- poer1: y , port2=y-x
  generic map (Size => WidthSizeTop)  
  port map(i_input2_top, sig_y_sub,sig_select_y, sig_y_int);
    
  u4 : RegMem -- to hold x
  generic map (Size => WidthSizeTop)  
  port map(i_clock_top, i_reset_top, sig_load_x, sig_x_int, sig_reg_x);  
  
  
  u5 : RegMem -- to hold y
  generic map (Size => WidthSizeTop)  
  port map(i_clock_top, i_reset_top, sig_load_y, sig_y_int, sig_reg_y);
  
  
  u6 : RegMem -- to hold GCD
  generic map (Size => WidthSizeTop)  
  port map(i_clock_top,i_reset_top,sig_register_en,sig_reg_y,  o_output_top);
  
  
  u7 : Subtractor -- to calculate x-y
  generic map (Size => WidthSizeTop)  
  port map(sig_reg_x,sig_reg_y,sig_x_sub);
  
  u8 : Subtractor --to calculate y-x
  generic map (Size => WidthSizeTop)  
  port map(sig_reg_y,sig_reg_x,sig_y_sub);
  
  
  u9 : FSM_GCD -- Controller  
  port map (i_reset_top, i_clock_top,i_start_top,   sig_equ,sig_nequ,  sig_select_x,sig_select_y, sig_load_x, sig_load_y, sig_register_en);  
  
   
end struct;