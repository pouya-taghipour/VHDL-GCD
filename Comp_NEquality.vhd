

-- Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
-- Address:  https://github.com/pouya-taghipour
-- Date:     August, 2020.

-- File name: Comp_NEquality.VHDL

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity comp_nequ is

generic ( Size : integer := 32);
  port(Input1,Input2: in std_logic_vector (Size-1 downto 0);
       result: out std_logic);
end comp_nequ ;

architecture rtl of comp_nequ is
begin
  process(Input1,Input2)
  begin
    if (Input1 = Input2) then
      result <= '0';
    else
      result <= '1';
    end if;
  end process;
end rtl;
