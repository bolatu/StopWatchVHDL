library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch_tb is

end stopwatch_tb;

architecture STIMULI of stopwatch_tb is

	component stopwatch
	  port(clk    : in  std_logic;
		   key1   : in  std_logic;
		   key2   : in  std_logic;
		   reset  : in  std_logic;
		   hex1   : out std_logic_vector(3 downto 0);
		   hex2   : out std_logic_vector(3 downto 0);
		   hex3   : out std_logic_vector(3 downto 0);
		   hex4   : out std_logic_vector(3 downto 0)
		   );
	end component;

  	-- component ports
	signal clk: std_logic := '1';
	signal key1: std_logic := '0';
	signal key2: std_logic := '0';
	signal reset: std_logic := '0';
	signal hex1, hex2, hex3, hex4: std_logic_vector(3 downto 0);

	-- real value should be 300000000, but simulation is needed to be faster
  	constant num_cycles : integer := 3000000;

begin
	DUT: stopwatch
	port map(	clk => clk,
				reset => reset,
				key1 => key1,
				key2 => key2,
				hex1 => hex1,
				hex2 => hex2,
				hex3 => hex3,
				hex4 => hex4);

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


configuration cfg_stopwatch_tb_STIMULI of stopwatch_tb is
  for STIMULI
  end for;
end cfg_stopwatch_tb_STIMULI;
