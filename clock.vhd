library ieee;
use ieee.std_logic_1164.all;

entity clock is
	generic (
		interval: time := 10 ns
	);
	port (
		clock_out: out std_logic
	);
end clock;

architecture behavioural of clock is
-- stat
begin
	process
	begin
		clock_out <= '0';
		wait for interval/2;
		clock_out <= '1';
		wait for interval/2;
	end process;
end behavioural;

