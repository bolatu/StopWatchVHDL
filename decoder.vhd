-------------------------------------------------------------------------------
-- Title      : 7-Segment decoder
-- Project    : 
-------------------------------------------------------------------------------
-- File       : SW.vhd
-- Author     : Ugur Bolat  <ugur.bolat@s2016.tu-chemnitz.de>
--				Omer Guney <>
-- Company    : TU-Chemmnitz, SSE
-- Created    : 2014-08-21
-- Last update: 2016-01-20
-- Standard   : VHDL'87
------------------------------------------------------------------------------
-- Description: A 7-decoder, having 8 bits output, needs a decoder hardware
--				since Stopwatch Controller provides decimal (4 bits) output.
------------------------------------------------------------------------------
-- Copyright (c) 2014 TU-Chemmnitz, SSE
------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-08-21  1.0      mput	Created
-- 2016-01-20  2.0		UB/OG	Decoder for a 7-segment display
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity decoder is
   port(
      hex  : in  std_logic_vector(3 downto 0);
      sseg : out std_logic_vector(7 downto 0));
end decoder;

architecture arc_decoder of decoder is
begin
	sseg <= X"81" when (hex = "0000") else
			X"CF" when (hex = "0001") else
			X"92" when (hex = "0010") else
			X"86" when (hex = "0011") else
			X"CC" when (hex = "0100") else
			X"A4" when (hex = "0101") else
			X"A0" when (hex = "0110") else
			X"8F" when (hex = "0111") else
			X"80" when (hex = "1000") else
			X"84" when (hex = "1001") else
			X"00";
end arc_decoder;
			
