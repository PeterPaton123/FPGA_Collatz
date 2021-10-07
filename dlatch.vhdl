library ieee;
use ieee.std_logic_1164.all;

entity dlatch is
	port(
		d_in, enable: in std_logic;
		d_q_out, d_qc_out: out std_logic
	);
end dlatch;

architecture behavioural of dlatch is
	signal enable_and_not_d_in, enable_and_d_in: std_logic;
begin
	sr_latch_module: entity work.srlatch(behavioural)
	port map(
	  reset_bit => enable_and_not_d_in,
	  set_bit => enable_and_d_in,
	  q_out => d_q_out,
	  qc_out => d_qc_out
	);

	enable_and_not_d_in <= enable and not d_in;
	enable_and_d_in <= enable and d_in;
end behavioural;
