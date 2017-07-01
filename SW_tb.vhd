-------------------------------------------------------------------------------
-- Title      : Stopwatch Testbench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : SW_tb.vhd
-- Author     : Ugur Bolat  <ugur.bolat@s2016.tu-chemnitz.de>
--				Omer Guney <>
-- Company    : TU-Chemmnitz, SSE
-- Created    : 2014-08-21
-- Last update: 2016-01-20
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Several input scenarios, such as start, stop, set zero, are 
--				provided to simulate and test the behaviour of the Stopwatch.
-------------------------------------------------------------------------------
-- Copyright (c) 2014 TU-Chemmnitz, SSE
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-08-21  1.0      mput	Created
-- 2016-01-20  2.0		UB/OG	Stopwatch is implemented by combining stopwatch
--								controller and 7-segment displays
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SW_tb is

end SW_tb;

architecture STIMULI of SW_tb is

	component SW
	  port(clk    : in  std_logic;
		   key1   : in  std_logic;
		   key2   : in  std_logic;
		   reset  : in  std_logic;
		   sseg1   : out std_logic_vector(7 downto 0);
		   sseg2   : out std_logic_vector(7 downto 0);
		   sseg3   : out std_logic_vector(7 downto 0);
		   sseg4   : out std_logic_vector(7 downto 0)
		   );
	end component;

  	-- component ports
	signal clk: std_logic := '1';
	signal key1: std_logic := '0';
	signal key2: std_logic := '0';
	signal reset: std_logic := '0';
	signal sseg1, sseg2, sseg3, sseg4: std_logic_vector(7 downto 0);

	-- real value should be 300000000, but simulation is needed to be faster
  	constant num_cycles : integer := 3000000;

begin
	DUT: SW
	port map(	clk => clk,
				reset => reset,
				key1 => key1,
				key2 => key2,
				sseg1 => sseg1,
				sseg2 => sseg2,
				sseg3 => sseg3,
				sseg4 => sseg4);

	-- architecture statement part
	process
  	begin

    	for i in 1 to num_cycles loop
      	clk <= not clk;
		-- real value should be 50 ns, but simulation is needed to be faster
      	wait for 50 us;
      	clk <= not clk;
      	wait for 50 us;
    	end loop;
		wait;
  	end process;

	process
	begin
		wait for 10 us;
		reset <= '1';
		wait for 10 us;
		reset <= '0';

		-- start
		wait for 100 us;
		key1 <= '1';
		wait for 100 us;
		key1 <= '0';

		-- stop
		wait for 15100 ms;
		key1 <= '1';
		wait for 100 us;
		key1 <= '0';

		-- start
		wait for 15100 ms;
		key1 <= '1';
		wait for 100 us;
		key1 <= '0';

		-- set zero
		wait for 15100 ms;
		key2 <= '1';
		wait for 100 us;
		key2 <= '0';

		-- stop
		wait for 15100 ms;
		key1 <= '1';
		wait for 100 us;
		key1 <= '0';

		-- set zero
		wait for 15 sec;
		key2 <= '1';
		wait for 100 us;
		key2 <= '0';

		-- start
		wait for 15100 ms;
		key1 <= '1';
		wait for 100 us;
		key1 <= '0';


		wait;
	end process;

end STIMULI;


configuration cfg_SW_tb_STIMULI of SW_tb is
  for STIMULI
  end for;
end cfg_SW_tb_STIMULI;
