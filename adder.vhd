library ieee;
use ieee.std_logic_1164.all;

entity adder is
	port (
		in_1, in_2, carry_in: in std_logic;
		out_1, carry_out: out std_logic
	);
end adder;

architecture behavioural of adder is
begin
	process
	begin
		if (in_1 = 'Z' or in_2 = 'Z') then
			out_1 <= 'Z';
			carry_out <= 'Z';
		else
			out_1 <= in_1 xor in_2 xor carry_in;
			-- can see via truth tables that xor is an associative operation,
			-- so it doesn't matter vhdl resolves it
			carry_out <= (in_1 and in_2) or (in_1 and carry_in) or (in_2 and carry_in);
		end if;
	end process;
end behavioural;

