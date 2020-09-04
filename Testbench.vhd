
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;


entity tb_gcd_toplevel is

		generic ( WidthSizeTop : integer := 32);

end tb_gcd_toplevel;

architecture tb of tb_gcd_toplevel is

    component gcd_toplevel
        port (i_clock_top  : in std_logic;
              i_reset_top  : in std_logic;
              i_start_top  : in std_logic;
              i_input1_top : in std_logic_vector (widthsizetop-1 downto 0 );
              i_input2_top : in std_logic_vector (widthsizetop-1 downto 0 );
              o_output_top : out std_logic_vector (widthsizetop-1 downto 0 ));
    end component;

    signal i_clock_top  : std_logic;
    signal i_reset_top  : std_logic;
    signal i_start_top  : std_logic;
    signal i_input1_top : std_logic_vector (widthsizetop-1 downto 0 );
    signal i_input2_top : std_logic_vector (widthsizetop-1 downto 0 );
    signal o_output_top : std_logic_vector (widthsizetop-1 downto 0 );

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : gcd_toplevel
    port map (i_clock_top  => i_clock_top,
              i_reset_top  => i_reset_top,
              i_start_top  => i_start_top,
              i_input1_top => i_input1_top,
              i_input2_top => i_input2_top,
              o_output_top => o_output_top);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that i_clock_top is really your main clock signal
    i_clock_top <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        i_start_top <= '0';
        i_input1_top <= (others => '0');
        i_input2_top <= (others => '0');
		  
		  
		  i_input1_top <= std_logic_vector(to_unsigned(12, 32));
		  i_input2_top <= std_logic_vector(to_unsigned(30, 32));
		  i_start_top <= '1';

        -- Reset generation
        -- EDIT: Check that i_reset_top is really your reset signal
        i_reset_top <= '1';
        wait for 100 ns;
        i_reset_top <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_gcd_toplevel of tb_gcd_toplevel is
    for tb
    end for;
end cfg_tb_gcd_toplevel;