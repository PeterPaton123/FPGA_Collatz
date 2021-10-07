library ieee;
use ieee.std_logic_1164.all;

entity comp is
	port(
		sum_out, comp_carry_out: out std_logic
	);
end comp;

architecture behavioural of comp is
	signal clock_1: std_logic;
	signal clock_2: std_logic;
	signal clock_3: std_logic;
begin
	-- TODO: cleanup in for loop
	clock_module_1: entity work.clock(behavioural)
		generic map(
			interval => 10 ns
		)	
		port map(
			clock_out => clock_1
		);

	clock_module_2: entity work.clock(behavioural)
		generic map(
			interval => 20 ns
		)		
		port map(
			clock_out => clock_2
		);
	
	clock_module_3: entity work.clock(behavioural)
		generic map(
			interval => 40 ns
		)		
		port map(
			clock_out => clock_3
		);

	adder_module: entity work.adder(behavioural)
		port map(
			in_1 => clock_1,
			in_2 => clock_2,
			carry_in => clock_3,
			out_1 => sum_out,
			carry_out => comp_carry_out
		);
end behavioural;
