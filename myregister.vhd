library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myregister is
    port
    (
        clk : in std_logic;
        valid : in std_logic;
        data_in : in std_logic_vector(7 downto 0); --we should use the first "something" bits to specify a register and then the other ones to perform an operation on it
        data_out_1 : out std_logic_vector(7 downto 0):= "0000";
        data_out_2 : out std_logic_vector(7 downto 0):= "0000";
        data_out_3 : out std_logic_vector(7 downto 0):= "0000";
        data_out_4 : out std_logic_vector(7 downto 0):= "0000"
        
    );
end entity myregister;

architecture behavioral of myregister is
    signal rw : std_logic;
    signal reg : std_logic_vector(1 downto 0);
    type regArray is array(3 downto 0) of std_logic_vector(3 downto 0);
    signal registers : regArray := (others => (others => '0'));
begin
    data_out_1 <= "0000" & registers(0);
    data_out_2 <= "0000" & registers(1);
    data_out_3 <= "0000" & registers(2);
    data_out_4 <= "0000" & registers(3);
    frank : process(clk)
    begin
     if(rising_edge(clk)) then
     if(valid = '1') then
     if(data_in(4) = '0') then
        if to_integer(unsigned(data_in(6 downto 5))) = 0 then
            registers(0) <= data_in(3 downto 0);
        elsif to_integer(unsigned(data_in(6 downto 5))) = 1 then
            registers(1) <= data_in(3 downto 0);
        elsif to_integer(unsigned(data_in(6 downto 5))) = 2 then
            registers(2) <= data_in(3 downto 0);
        elsif to_integer(unsigned(data_in(6 downto 5))) = 3 then
            registers(3) <= data_in(3 downto 0);
        end if;
     end if;
     end if;
     end if;
end process;

end behavioral;

