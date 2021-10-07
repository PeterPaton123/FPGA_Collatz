library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity naddertest is
       port(
		test_sum_out: out std_logic_vector := (7 downto 0 => '0');
		test_carry_out: out std_logic
       );
end naddertest;

architecture behavioural of naddertest is
	signal print_out: std_logic_vector(7 downto 0) := (7 downto 0 => '0');
begin
	bit_8_adder_module: entity work.nbitadder(behavioural)
		port map(
			a_vec => "11111111",
			b_vec => "10000000",
			out_vec => print_out,
			overflow => test_carry_out
		);
	process
	begin
		test_sum_out <= print_out;
		wait for 10 ns;
	end process;
end behavioural;
