library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity baud_UART_TX is
    generic(constant lambda : integer:= 868);
    port(clk    : in std_logic;
        enabler : in std_logic;
        y       : out std_logic);     
end baud_UART_TX;

architecture Behavioral of baud_UART_TX is
   signal counter : integer := 0;
    
begin 
    baud_rate_generator : process(clk)
    begin
        if rising_edge(clk) then
            if enabler = '1' then
                if counter < lambda then
                    counter <= counter + 1;
                    y <= '0';
                else
                    counter <= 0;
                    y <= '1';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
