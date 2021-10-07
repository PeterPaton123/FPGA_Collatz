library ieee;
use ieee.std_logic_1164.all;

entity srlatch is
	port(
		set_bit, reset_bit: in std_logic;
		q_out, qc_out: out std_logic
	);
end srlatch;

architecture behavioural of srlatch is
	signal nor_1_out: std_logic;
	signal nor_2_out: std_logic;
begin
	nor_1_out <= reset_bit nor nor_2_out;
	nor_2_out <= set_bit nor nor_1_out;
	q_out <= nor_1_out;
	qc_out <= nor_2_out;
end behavioural;

