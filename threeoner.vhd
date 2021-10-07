library ieee;
use ieee.std_logic_1164.all;

entity threeoner is
	port(
		in_1: in std_logic_vector(63 downto 0);
		out_1: out std_logic_vector(63 downto 0);
		overflow: out std_logic	
	);
end threeoner;

architecture behavioural of threeoner is
	signal overflow_1, overflow_2, overflow_3: std_logic;
	signal sum_1, sum_2, sum_3: std_logic_vector(63 downto 0);
begin
	adder_1: entity work.nbitadder(behavioural)
		generic map(
			n => 64
		)
		port map(
			a_vec => in_1,
			b_vec => in_1,
			out_vec => sum_1,
			overflow => overflow_1
		);

	adder_2: entity work.nbitadder(behavioural)
		generic map(
			n => 64
		)
		port map(
			a_vec => sum_1,
			b_vec => in_1,
			out_vec => sum_2,
			overflow => overflow_2
		);


	adder_3: entity work.nbitadder(behavioural)
		generic map(
			n => 64
		)
		port map(
			a_vec => sum_2,
			b_vec => "1000000000000000000000000000000000000000000000000000000000000000",
			out_vec => out_1,
			overflow => overflow_3
		);

	overflow <= overflow_1 or overflow_2 or overflow_3;
end behavioural;


