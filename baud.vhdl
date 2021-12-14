library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity baud is
    generic ( constant lambda : integer:= 868 );
    port ( clk : in std_logic;
            y : out std_logic);
end baud;

architecture Behavioral of baud is
    signal counter : integer :=1;
    begin
        baud : process(clk) is
        begin
        if falling_edge(clk) then
            counter <=  counter + 1;
        elsif counter = lambda then
            y <= '1';
            counter <= 0;
        elsif counter = 0 then
            y <= '1';
        else
            y <= '0';
        end if;
    end process;
end Behavioral;
