
-- Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
-- Address:  https://github.com/pouya-taghipour
-- Date:     August, 2020.
-- License:  Gnu public license v3.0

-- File name: Multiplexer.VHDL


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;



entity Multiplexer is 

	 generic ( Size : integer := 32);

    port
	 (
		MuxPort1	 : in  std_logic_vector( Size-1 downto 0 ); -- it is connected to numbers
		MuxPort2  : in  std_logic_vector( Size-1 downto 0 );
		MuxSel	 : in  std_logic;
		MuxOutput : out std_logic_vector( Size-1 downto 0 )
    );
	 
	 
end Multiplexer;

architecture Multiplexer_Architecture of Multiplexer is
begin

		MuxOutput <= MuxPort2 when MuxSel = '1' else MuxPort1;

end Multiplexer_Architecture;