library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity counter is
	port (	clk_in: in std_logic;
			reset: in std_logic;
			clk_out: out std_logic;
			counter_out: out std_logic_vector(5 downto 0));
end counter;

architecture arc_clock of counter is

	signal counter_clk: integer := 0;
	signal counter_real: integer := 0;
	signal temp: std_logic := '0';

begin

	process(clk_in,reset)
   	--variable the_line: line;
	begin

   		if(reset = '1') then 
			counter_clk <= 0; 
			temp <= '1';
    	elsif(clk_in'event and clk_in = '1') then 

			-- real value should be 10000000, but simulation is needed to be faster
		 	if (counter_clk = 10000) then 
				temp <= NOT temp; 
				counter_clk <= 0;
				counter_real <= counter_real + 1;
			else
				counter_clk <= counter_clk + 1;
				--write(the_line, Integer'(counter_clk));
    			--writeline(output, the_line);
     		end if;
    	end if;

		clk_out <= temp;
		counter_out <= std_logic_vector(to_unsigned(counter_real, counter_out'length));
	end process;
	

end arc_clock;
