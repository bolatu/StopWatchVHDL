------------------------------------------------------------------------------
-- Title      : Stopwatch
-- Project    : 
------------------------------------------------------------------------------
-- File       : stopwatch.vhd
-- Author     : Ugur Bolat  <ugur.bolat@s2016.tu-chemnitz.de>
--				Omer Guney <oemer.gueney@s2016.tu-chemnitz.de>
-- Company    : TU-Chemmnitz, SSE
-- Created    : 2014-08-21
-- Last update: 2016-01-20
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Stopwatch Controller is implemented by using Mealy FSM.
--				sync_proc' process checks for the asynchronous reset and
--				updates the present_state with next_state in every rising edge.
--				'comb_proc' process is responsible for state transitions based
--				on key1 and key2.
--				'cnt' process counts every second if present_state is s2 and 
--				converts current decimal count value to digits. 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 TU-Chemmnitz, SSE
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-08-21  1.0      mput	Created
-- 2016-01-20  2.0		UB/OG	Stopwatch controller
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity stopwatch is
  port(clk    : in  std_logic;
       key1   : in  std_logic;
       key2   : in  std_logic;
       reset  : in  std_logic;
       hex1   : out std_logic_vector(3 downto 0);
       hex2   : out std_logic_vector(3 downto 0);
       hex3   : out std_logic_vector(3 downto 0);
       hex4   : out std_logic_vector(3 downto 0));
end stopwatch;

architecture arc_stopwatch of stopwatch is

	type state_type is (s1, s2);
	signal present_state, next_state: state_type;

	-- counter variables
	signal clk_cycle_counter: integer := 0;
	signal real_time_counter: integer := 0;

	signal temp_hex1, temp_hex2, temp_hex3, temp_hex4: integer := 0;

begin

--------------------------------------------------------------------------
	-- FSM Stopwatch Controller
	sync_proc: process(clk, reset)
	begin 
		-- take care of the hard reset
		if (reset = '1') then
			present_state <= s1;
		elsif (clk'event and clk = '1') then
			present_state <= next_state;
		end if;
	end process sync_proc;


	comb_proc: process(key1, key2)
	begin
		case present_state is
			when s1 =>
				if (key1 = '1') then
					next_state <= s2;
				else
					next_state <= present_state;
				end if;
			when s2 =>
				if (key1 = '1') then
					next_state <= s1;
				else
					next_state <= present_state;
				end if;
			when others =>
				next_state <= s1;
		end case;
	end process comb_proc;
--------------------------------------------------------------------------


--------------------------------------------------------------------------
	-- Counter process
	cnt: process (clk, reset, key2)
	begin
		if (reset = '1') then
			clk_cycle_counter <= 0;
			real_time_counter <= 0;
		-- counting in every falling edge
		elsif(clk'event and clk = '0') then 

			if (key2 = '1') then 
				clk_cycle_counter <= 0;
				real_time_counter <= 0;
			end if;

			-- Basic priciple of the counting in this design is to determine
			-- present state. If present state is s2, counter is active.
			-- Otherwise, counter is stopped. However, we might not 
			-- catch the key1 instantly if key1 is pressed exactly in the
			-- rising edge, because present_state will be updated  in the  
			-- next rising edge. Therefore, our counter will be one clock 
			-- cycle late. To solve it, that's why we cover the condition
			-- where key1 = '1' and present_state = s1.
			if (present_state = s2 or (key1 = '1' and present_state = s1)) then
				if (clk_cycle_counter = 10000) then 
					clk_cycle_counter <= 0;
					real_time_counter <= real_time_counter + 1;
				else
					clk_cycle_counter <= clk_cycle_counter + 1;
			 	end if;
			end if;
				temp_hex1 <= real_time_counter mod 10;
				temp_hex2 <= (real_time_counter / 10) mod 6;
				temp_hex3 <= (real_time_counter / 60) mod 10;
				temp_hex4 <= (real_time_counter / 60) / 10;
		end if;
	

	end process cnt;
--------------------------------------------------------------------------


--------------------------------------------------------------------------
	-- Output assignments
	hex1 <= std_logic_vector(to_unsigned(temp_hex1, hex1'length)); -- seconds
	hex2 <= std_logic_vector(to_unsigned(temp_hex2, hex2'length)); -- tens of seconds
	hex3 <= std_logic_vector(to_unsigned(temp_hex3, hex3'length)); -- minutes
	hex4 <= std_logic_vector(to_unsigned(temp_hex4, hex4'length));	-- tens of minutes
--------------------------------------------------------------------------

end arc_stopwatch;






		


