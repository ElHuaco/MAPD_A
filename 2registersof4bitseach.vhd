library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myregister is
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        data_in : in std_logic_vector(7 downto 0); --we should use the first "something" bits to specify a register and then the other ones to perform an operation on it
        data_out : out std_logic_vector(3 downto 0)
    );
end myregister;

architecture behavioral of register is
    type regArray is array (0 to 1) of std_logic_vector(3 downto 0);
    signal registers : regArray := (others => (others => '0')); --initialize to 0

begin
    registerfile_clear : process(clk)
    begin
        if(rising_edge(clk)) then
            if(data_in(7) = '1') then -- if the first bit we send is a '1'
                registers <= (others => (others => '0')); -- we delete everything
        end if;
    end if;
    end process;

  registerfile_read_write : process(clk)
  begin
      if(data_in(6) = '1') then --if second bit we send is a '1' we write to a register which is specified by the next 2 bits
          registers(to_integer(unsigned(data_in(5 downto 4)))) <= data_in(3 downto 0);
      elsif (data_in(6) = '0') then --if second bit we send is a '0' we read from a register which is specified by the next 2 bits
          data_out <= registers(to_integer(unsigned(data_in(5 downto 4))));
      end elsif
  end if;
end process;

end behavioral;
