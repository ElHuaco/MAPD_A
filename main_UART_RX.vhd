library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity main_UART_RX is
    port(clk : in std_logic;
        data : in std_logic;
        baud : in std_logic;
        valid : out std_logic := '0';
        y : out std_logic_vector(7 downto 0));
end entity main_UART_RX;

architecture behave of main_UART_RX is
    type state_t is (start, stop, lsb, b1, b2, b3, b4, b5, b6, b7, idle);
    signal state : state_t := idle;
begin 
    main : process(clk) is
    begin
        if rising_edge(clk) then
            case state is
                when idle =>
                    valid <= '0';
                    if data = '0' then
                        state <= start;
                    end if;
                when start =>
                    if baud = '1' then
                        state <= lsb;
                    end if;
                when lsb =>
                    y(0) <= data;
                    if baud = '1' then                
                        state <= b1;
                    end if;
                when b1 =>
                    y(1) <= data;
                    if baud = '1' then
                        state <= b2;
                    end if;
                when b2 =>
                    y(2) <= data;
                    if baud = '1' then
                        state <= b3;
                    end if;
                when b3 =>
                    y(3) <= data;
                    if baud = '1' then
                        state <= b4;
                    end if;
                when b4 =>
                    y(4) <= data;
                    if baud = '1' then
                        state <= b5;
                    end if;
                when b5 =>
                    y(5) <= data;
                    if baud = '1' then
                        state <= b6;
                    end if;
                when b6 =>
                    y(6) <= data;
                    if baud = '1' then
                        state <= b7;
                    end if;
                when b7 =>
                    y(7) <= data;
                    if baud = '1' then
                        state <= stop;
                    end if;
                when stop =>
                    valid <= '1';
                    if baud = '1' then
                        state <= idle;
                    end if;
                when others =>
                    null;
            end case;
        end if;          
    end process;
end;