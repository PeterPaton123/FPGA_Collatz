library ieee;
use ieee.std_logic_1164.all;

entity dlatchtest is
	port(
		out_1: out std_logic
	);
end dlatchtest;

architecture behavioural of dlatchtest is
	signal clock_1, not_clock_1, clock_2, not_clock_2: std_logic;
begin
	clock_module_1: entity work.clock(behavioural)
	generic map(
		interval => 1 ps
	)
	port map(
		clock_out => clock_1
	);
	
	clock_module_2: entity work.clock(behavioural)
	generic map(
		interval => 2 ps
	)
	port map(
		clock_out => clock_2
	);


	dlatch_module: entity work.dlatch(behavioural)
	port map(
		d_in => clock_1,
		enable => clock_2,
		d_q_out => out_1
	);

	not_clock_1 <= not clock_1;
	not_clock_2 <= not clock_2;
end behavioural;
