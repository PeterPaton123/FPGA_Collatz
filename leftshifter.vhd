library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
entity leftshifter is
	generic(
		n: integer := 64
	);
	port(
		in_1: in std_logic_vector(n-1 downto 0);
		out_1: out std_logic_vector(n-1 downto 0)
	);
end leftshifter;

architecture behavioural of leftshifter is
begin
	out_1 <= std_logic_vector(shift_left(unsigned(in_1), 1));
end behavioural;
