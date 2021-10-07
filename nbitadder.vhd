library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbitadder is
	generic (
		n: integer := 8
	);
	port(
		a_vec, b_vec: in std_logic_vector(n-1 downto 0);
		out_vec: out std_logic_vector(n-1 downto 0);
		overflow: out std_logic
	);
end nbitadder;

architecture behavioural of nbitadder is
	signal current_carry: std_logic_vector(n downto 0);
begin
	current_carry(n) <= '0';
	overflow <= current_carry(0);
	adder_loop: for ii in n-1 downto 0 generate
	adder_module: entity work.adder(behavioural)
			port map(
				in_1 => a_vec(ii),
				in_2 => b_vec(ii),
				carry_in => current_carry(ii+1),
				out_1 => out_vec(ii),
				carry_out => current_carry(ii)
			);
	end generate adder_loop;
end behavioural;
			
	
