library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myregister is
    port
    (
        clk : in std_logic;
        data_in : in std_logic_vector(7 downto 0); --we should use the first "something" bits to specify a register and then the other ones to perform an operation on it
        data_out : out std_logic_vector(7 downto 0)
    );
end myregister;

architecture behavioral of myregister is
    type regArray is array (0 to 7) of std_logic_vector(3 downto 0);
    signal registers : regArray := (others => (others => '0')); --initialize to 0
    signal rw : std_logic;
begin
    frank : process(clk)
    begin
     if(rising_edge(clk)) then
     rw <= data_in(4);
        if(rw = '1') then --read the register
            data_out(3 downto 0) <= registers(to_integer(unsigned(data_in(7 downto 5))));
            data_out(7 downto 4) <= "0000";
        end if;
        if(rw = '0') then --writing the regisrter
            registers(to_integer(unsigned(data_in(7 downto 5)))) <= data_in(3 downto 0);
            
        end if;
      end if;
end process;

end behavioral;
