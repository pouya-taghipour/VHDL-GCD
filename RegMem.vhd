

-- Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
-- Address:  https://github.com/pouya-taghipour
-- Date:     August, 2020.
-- License:  Gnu public license v3.0

-- File name: RegMem.VHDL

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity RegMem is

	 generic ( Size : integer := 32);
	
	 port
	 (
		RegMem_Clock  : in  std_logic;
		RegMem_Reset  : in  std_logic;		
		RegMem_Load	  : in  std_logic;
		RegMem_Input  : in  std_logic_vector( Size-1 downto 0 );
		RegMem_Output : out std_logic_vector( Size-1 downto 0 )
    );
	 
end RegMem;


architecture RegMem_Arch of RegMem is


signal  sig_out_internal : std_logic_vector( Size-1 downto 0 ) := (others=>'0');


begin
    process( RegMem_Reset, RegMem_Clock)
    begin
			if( RegMem_Reset = '1' ) then 
				 sig_out_internal <= (others=>'0');
			elsif( rising_edge(RegMem_Clock)) then
				 if( RegMem_Load = '1' ) then	
					  sig_out_internal <= RegMem_Input;
				 end if;
			end if;
    end process;
	 
	 
	 RegMem_Output <= sig_out_internal;
	 
end RegMem_Arch;
