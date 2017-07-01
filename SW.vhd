-------------------------------------------------------------------------------
-- Title      : Stop watch top level
-- Project    : 
-------------------------------------------------------------------------------
-- File       : SW.vhd
-- Author     : Ugur Bolat  <ugur.bolat@s2016.tu-chemnitz.de>
--				Omer Guney <>
-- Company    : TU-Chemmnitz, SSE
-- Created    : 2014-08-21
-- Last update: 2016-01-20
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Entity for top level of stop watch design for system design 1
-- practical lab
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
entity SW is
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    key1    : in  std_logic;
    key2    : in  std_logic;
    sseg1   : out std_logic_vector(7 downto 0);
    sseg2   : out std_logic_vector(7 downto 0);
    sseg3   : out std_logic_vector(7 downto 0);
    sseg4   : out std_logic_vector(7 downto 0));
end entity SW;

architecture arc_SW of SW is

	component stopwatch 
		port(clk    : in  std_logic;
			key1   : in  std_logic;
			key2   : in  std_logic;
			reset  : in  std_logic;
			hex1   : out std_logic_vector(3 downto 0);
			hex2   : out std_logic_vector(3 downto 0);
			hex3   : out std_logic_vector(3 downto 0);
			hex4   : out std_logic_vector(3 downto 0));
	end component stopwatch;

	component decoder
		port(
      		hex  : in  std_logic_vector(3 downto 0);
      		sseg : out std_logic_vector(7 downto 0));
	end component decoder;

	signal sw_to_decoder1: std_logic_vector(3 downto 0);
	signal sw_to_decoder2: std_logic_vector(3 downto 0);
	signal sw_to_decoder3: std_logic_vector(3 downto 0);
	signal sw_to_decoder4: std_logic_vector(3 downto 0);

begin

	decoder1: decoder
		port map(hex => sw_to_decoder1, sseg => sseg1);

	decoder2: decoder
		port map(hex => sw_to_decoder2, sseg => sseg2);

	decoder3: decoder
		port map(hex => sw_to_decoder3, sseg => sseg3);

	decoder4: decoder
		port map(hex => sw_to_decoder4, sseg => sseg4);

	stopwatch_controller: stopwatch
		port map(	clk => clk,
					reset => reset,
					key1 => key1,
					key2 => key2,
					hex1 => sw_to_decoder1,
					hex2 => sw_to_decoder2,
					hex3 => sw_to_decoder3,
					hex4 => sw_to_decoder4);

end architecture arc_SW;



