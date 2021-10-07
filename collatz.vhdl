library ieee;
use ieee.std_logic_1164.all;

entity collatz is
	port(
		number_in: in std_logic_vector(63 downto 0);
		steps_out: out std_logic_vector(63 downto 0)
	);
end collatz;

architecture behavioural of collatz is
	signal clock, overflow: std_logic;
	signal reg_a_read_in, reg_a_write_out, reg_b_read_in, reg_b_write_out: std_logic;
	signal reg_a_in, reg_a_out, reg_b_in, reg_b_out, left_shift_out, three_one_out: std_logic_vector(63 downto 0);
	signal one: std_logic_vector(63 downto 0) := (0 => '1', others => '0');
	signal odd, setup: boolean := false;
begin
	clock_module: entity work.clock(behavioural)
		port map(
			clock_out => clock
		);

	reg_a: entity work.reg(behavioural)
		generic map(
			register_width => 64
		)
		port map(
			read_into => reg_a_read_in,
			write_out => reg_a_write_out,
			data_in => reg_a_in,
			data_out => reg_a_out
		);
	
	reg_b: entity work.reg(behavioural)
		generic map(
			register_width => 64
		)	
		port map(
			read_into => reg_b_read_in,
			write_out => reg_b_write_out,
			data_in => reg_b_in,
			data_out => reg_b_out
		);

	incrementer: entity work.nbitadder(behavioural)
		generic map(
			n => 64
		)
		port map(	
			a_vec => reg_b_out,
			b_vec => one,
			out_vec => reg_b_in,
			overflow => overflow
		);

	left_shifter: entity work.leftshifter(behavioural)
		generic map(
			n => 64
		)
		port map(
			in_1 => reg_a_out,
			out_1 => left_shift_out
		);
	
	three_oner: entity work.threeoner(behavioural)
		port map(
			in_1 => reg_a_out,
			out_1 => three_one_out
		);

	process(clock)
	begin
		wait for 10 ns;
		if not setup then	
			report "setup";
			odd <= number_in(0) = '1';
			reg_a_in <= number_in;
			setup <= true;
		end if;
		if rising_edge(clock) then
			report "rising";
			reg_a_write_out <= '1';
			reg_b_write_out <= '1';
			
			reg_a_read_in <= '0';
			reg_b_read_in <= '0';

			steps_out <= reg_b_out;
			odd <= reg_a_out(0) = '1';
		end if;
		if falling_edge(clock) then
			report "falling";
			reg_a_write_out <= '0';
			reg_b_write_out <= '0';

			reg_a_read_in <= '1';
			reg_b_read_in <= '1';

			if (odd) then
				reg_a_in <= three_one_out;
			else
				reg_a_in <= left_shift_out;
			end if;
		end if;
	end process;
end behavioural;
