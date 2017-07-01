library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is

end counter_tb;

architecture STIMULI of counter_tb is

	component counter
		port (	clk_in: in std_logic;
				reset: in std_logic;
				clk_out: out std_logic;
				counter_out: out std_logic_vector(5 downto 0));
	end component;

  	-- component ports
	signal clk_in: std_logic := '1';
	signal reset: std_logic := '0';
	signal clk_out: std_logic;
	signal counter_out: std_logic_vector(5 downto 0);

	-- real value should be 300000000, but simulation is needed to be faster
  	constant num_cycles : integer := 30000;

begin
	DUT: counter
	port map(	clk_in => clk_in,
				reset => reset,
				clk_out => clk_out,
				counter_out => counter_out);

	-- architecture statement part
	process
  	begin
		wait for 1 ns;
		reset <= '1';
		wait for 1 ns;
		reset <= '0';

    	for i in 1 to num_cycles loop
      	clk_in <= not clk_in;
		-- real value should be 50 ns, but simulation is needed to be faster
      	wait for 50 us;
      	clk_in <= not clk_in;
      	wait for 50 us;
      	-- clock period = 10 ns
    	end loop;
		wait;
  	end process;
end STIMULI;


configuration cfg_counter_tb_STIMULI of counter_tb is
  for STIMULI
  end for;
end cfg_counter_tb_STIMULI;
