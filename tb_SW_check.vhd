-------------------------------------------------------------------------------
-- Title      : Testbench for design "SW"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_SW.vhd
-- Author     : Marcel Putsche  <...@hrz.tu-chemnitz.de>
-- Company    : TU-Chemmnitz, SSE
-- Created    : 2014-08-20
-- Last update: 2016-10-18
-- Platform   : x86_64-redhat-linux
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 TU-Chemmnitz, SSE
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-08-20  1.0      mput    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity tb_SW_check is

end tb_SW_check;

-------------------------------------------------------------------------------

architecture STIMULI of tb_SW_check is

  constant period : time := 100 us;
 -- constant period : time := 61 ns;

  component SW
    port (
      clk   : in  std_logic;
      reset : in  std_logic;
      key1  : in  std_logic;
      key2  : in  std_logic;
      sseg1 : out std_logic_vector(7 downto 0);
      sseg2 : out std_logic_vector(7 downto 0);
      sseg3 : out std_logic_vector(7 downto 0);
      sseg4 : out std_logic_vector(7 downto 0));
  end component;

  -- component ports
  signal reset : std_logic;
  signal key1  : std_logic;
  signal key2  : std_logic;
  signal sseg1 : std_logic_vector(7 downto 0);
  signal sseg2 : std_logic_vector(7 downto 0);
  signal sseg3 : std_logic_vector(7 downto 0);
  signal sseg4 : std_logic_vector(7 downto 0);
  signal dummy : std_logic_vector(1 downto 0):="00";
  -- clock
  signal Clk : std_logic := '1';

begin  -- STIMULI

  -- component instantiation
  DUT : SW
    port map (
      clk   => clk,
      reset => reset,
      key1  => key1,
      key2  => key2,
      sseg1 => sseg1,
      sseg2 => sseg2,
      sseg3 => sseg3,
      sseg4 => sseg4);



-- Stimuli assignments:  --
  clk <= not clk after period/2;
  stim : process
  begin
    reset <= '1';
    key1  <= '0';
    key2  <= '0';
    wait for 200 us;
    reset <= '0';
    wait for 200 us;
    ASSERT (sseg1 = "10000001") REPORT "Simulation failed: wrong digit for seconds after initialization" SEVERITY warning;
    ASSERT (sseg2 = "10000001") REPORT "Simulation failed: wrong digit for tens seconds after initialization" SEVERITY warning;
    ASSERT (sseg3 = "10000001") REPORT "Simulation failed: wrong digit for minutes after initialization" SEVERITY warning;
    ASSERT (sseg4 = "10000001") REPORT "Simulation failed: wrong digit for tens minutes after initialization" SEVERITY warning;
    
    --REPORT "Simulation digit for seconds:" & integer'image(to_integer(unsigned(sseg1)));
  --  for i in sseg1'range loop
   --   REPORT "Simulation digit for seconds:" & std_logic'image(sseg1(7)) & std_logic'image(sseg1(6))& std_logic'image(sseg1(5))& std_logic'image(sseg1(4))& std_logic'image(sseg1(3))& std_logic'image(sseg1(2))& std_logic'image(sseg1(1)) & std_logic'image(sseg1(0));
   --   REPORT "Simulation digit for seconds:" & integer'image(to_integer(unsigned(dummy & sseg1(i))));
  --end loop;  

    key1  <= '1';
    wait for 200 us;
    key1  <= '0';
    wait for 3 sec;
    wait for 200 us;
    ASSERT (sseg1 = "10000110") REPORT "Simulation failed: wrong digit for seconds after stopping the watch" SEVERITY warning;

--    ASSERT (sseg1 = "10010010") REPORT "Simulation failed: wrong digit for seconds after stopping the watch" SEVERITY warning;

    ASSERT (sseg2 = "10000001") REPORT "Simulation failed: wrong digit for tens seconds after stopping the watch" SEVERITY warning;
    ASSERT (sseg3 = "10000001") REPORT "Simulation failed: wrong digit for minutes after stopping the watch" SEVERITY warning;
    ASSERT (sseg4 = "10000001") REPORT "Simulation failed: wrong digit for tens minutes after stopping the watch" SEVERITY warning;

    key1  <= '1';
    wait for 300 us;
    key1  <= '0';
    wait for 2 sec;
    key1  <= '1';
    wait for 300 us;
    key1  <= '0';

    wait for 1 sec;
    wait for 100 us;
    ASSERT (sseg1 = "11001100") REPORT "Simulation failed: wrong digit for seconds after continuing the watch" SEVERITY warning;
    ASSERT (sseg2 = "10000001") REPORT "Simulation failed: wrong digit for tens seconds after continuing the watch" SEVERITY warning;
    ASSERT (sseg3 = "10000001") REPORT "Simulation failed: wrong digit for minutes after continuing the watch" SEVERITY warning;
    ASSERT (sseg4 = "10000001") REPORT "Simulation failed: wrong digit for tens minutes after continuing the watch" SEVERITY warning;
    wait for 1 sec;
    key2 <= '1';
    wait for 300 us;
    key2 <= '0';
    wait for 100 us;
    ASSERT (sseg1 = "10000001") REPORT "Simulation failed: wrong digit for seconds after restting the watch" SEVERITY warning;
    ASSERT (sseg2 = "10000001") REPORT "Simulation failed: wrong digit for tens seconds after resetting the watch" SEVERITY warning;
    ASSERT (sseg3 = "10000001") REPORT "Simulation failed: wrong digit for minutes after resetting the watch" SEVERITY warning;
    ASSERT (sseg4 = "10000001") REPORT "Simulation failed: wrong digit for tens minutes after resetting the watch" SEVERITY warning;
    wait for 2 sec;
    key1 <= '1';
    wait for 300 us;
    key1 <= '0';
    wait for 2 sec;
    ASSERT (sseg1 = "10010010") REPORT "Simulation failed: wrong digit for seconds after stopping the watch again" SEVERITY warning;
    ASSERT (sseg2 = "10000001") REPORT "Simulation failed: wrong digit for tens seconds after stopping the watch again" SEVERITY warning;
    ASSERT (sseg3 = "10000001") REPORT "Simulation failed: wrong digit for minutes after stopping the watch again" SEVERITY warning;
    ASSERT (sseg4 = "10000001") REPORT "Simulation failed: wrong digit for tens minutes after stopping the watch again" SEVERITY warning;
    wait for 1 sec;
    key2 <= '1';
    wait for 300 us;
    key2 <= '0';
    wait for 300 us;
    ASSERT (sseg1 = "10000001") REPORT "Simulation failed: wrong digit for seconds after resetting the watch again" SEVERITY warning;
    ASSERT (sseg2 = "10000001") REPORT "Simulation failed: wrong digit for tens seconds after resetting the watch again" SEVERITY warning;
    ASSERT (sseg3 = "10000001") REPORT "Simulation failed: wrong digit for minutes after resetting the watch again" SEVERITY warning;
    ASSERT (sseg4 = "10000001") REPORT "Simulation failed: wrong digit for tens minutes after resetting the watch again" SEVERITY warning;
    wait for 1 sec;
    key1 <= '1';
    wait for 10.5 sec;
    ASSERT (sseg1 = "10000001") REPORT "Simulation failed: wrong digit for seconds after stopping the watch again" SEVERITY warning;
    ASSERT (sseg2 = "11001111") REPORT "Simulation failed: wrong digit for tens seconds after stopping the watch again" SEVERITY warning;
    ASSERT (sseg3 = "10000001") REPORT "Simulation failed: wrong digit for minutes after stopping the watch again" SEVERITY warning;
    ASSERT (sseg4 = "10000001") REPORT "Simulation failed: wrong digit for tens minutes after stopping the watch again" SEVERITY warning;
    REPORT "Simulation finished sucessfully";
    wait;
  end process stim;

end STIMULI;

-------------------------------------------------------------------------------

configuration cfg_tb_SW_STIMULI of tb_SW_check is
  for STIMULI
  end for;
end cfg_tb_SW_STIMULI;

-------------------------------------------------------------------------------
