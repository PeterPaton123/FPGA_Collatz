library ieee;
use ieee.std_logic_1164.all;

entity reg is 
  generic(
    register_width: integer := 32
  );
  port(
    read_into, write_out: in std_logic;
    data_in: in std_logic_vector(register_width-1 downto 0);
    data_out: out std_logic_vector(register_width-1 downto 0)
  );
end reg;

architecture behavioural of reg is
  signal register_store: std_logic_vector(register_width-1 downto 0);
begin
  l: for i in 0 to register_width-1 generate
    d_latch_module: entity work.dlatch
      port map (
        enable => read_into,
        d_in => data_in(i),
        d_q_out => register_store(i)
      );
  end generate;

  process(write_out)
  begin
    if write_out = '1' then
      register_store <= register_store;
    else
      register_store <= (others => 'Z');
    end if;
  end process;
end behavioural;
