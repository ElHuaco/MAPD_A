library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity baud is

  port (
    clk        : in  std_logic;
    baudrate_out : out std_logic);

end entity baud;


architecture rtl of baud is
  signal counter   : unsigned(9 downto 0) := (others => '0');
  constant divisor : unsigned(9 downto 0) := to_unsigned(867, 10);
begin  -- architecture rtl
  main : process (clk) is
  begin  -- process main
    if rising_edge(clk) then          -- rising clock edge
      counter <= counter + 1;
      if counter = divisor then
        baudrate_out <= '1';
        counter      <= (others => '0');
      else
        baudrate_out <= '0';
      end if;
    end if;
  end process main;

end architecture rtl;