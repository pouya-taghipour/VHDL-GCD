-- Designer: Pouya Taghipour ( pouya.taghipour@gmail.com )
-- Address:  https://github.com/pouya-taghipour
-- Date:     August, 2020.
-- License:  Gnu public license v3.0


-- File name: Subtractor.VHDL

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

Library UNISIM;
use UNISIM.vcomponents.all;
use work.all;

entity Subtractor is

generic ( Size : integer := 32);

  port(Input1,Input2: in std_logic_vector (Size-1 downto 0);
    Output: out std_logic_vector (Size-1 downto 0));
end subtractor ;

architecture rtl of subtractor is
  signal sig_int : unsigned(Size-1 downto 0);
begin
  sig_int <= unsigned(Input1) - unsigned(Input2);
  Output <= std_logic_vector(sig_int);
end rtl;
