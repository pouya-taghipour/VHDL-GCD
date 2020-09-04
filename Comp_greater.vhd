
-- Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
-- Address:  https://github.com/pouya-taghipour
-- Date:     August, 2020.
-- License:  Gnu public license v3.0

-- File name: Comp_Greater.VHDL

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Comp_greater is  

generic ( Size : integer := 32);
  port(
  Input1,Input2: in std_logic_vector (Size-1 downto 0);
  result : out    std_logic);
end Comp_greater ;

architecture RTL of Comp_greater is
begin
  process(Input1,Input2)
  begin
    if Input1 < Input2 then
	  result <= '1';
	else
	  result <= '0';
	end if;
  end process;
end RTL;
