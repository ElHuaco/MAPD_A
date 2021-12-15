library IEEE;
use library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rec is
    port(clk : in std_logic;
        data : in std_logic;
        baud : in std_logic;
        valid : out std_logic <= '0';
        y : out std_logic_vector(7 downto 0));
end entity rec;

architecture behave of rec is
    type state_t is (start, ende , st1, st2, st3, st4, st5, st6, st7, st8, idle);
    signal state : state_t :=idle;
begin 
    main : process(clk) is
    begin
        if falling_edge(clk) then
            case state is
                when idle =>
                    if baud = '1'
                        state <= start;
                    end if;
                when start =>
                    if baud = '1';
                        state <= st1;
                        y(0) = data
                    end if;
                when st1 =>
                    if baud = '1';                     
                        state <= st2;
                        y(1) = data;
                    end if;
                when st2 =>
                    if baud = '1';
                        state <= st3;
                        y(2) = data
                    end if;
                when st3 =>
                    if baud = '1';
                        state <= st4;
                        y(3) = data;
                    end if;
                when st4 =>
                    if baud = '1';
                        state <= st5;
                        y(4) = data
                    end if;
                when st5 =>
                    if baud = '1';
                        state <= st6;
                        y(5) = data;
                    end if;
                when st6 =>
                    if baud = '1';
                        state <= st7;
                        y(6) = data
                    end if;
                when st7 =>
                    if baud = '1';
                        state <= st8;
                        y(7) = data;
                    end if;
                when st8 =>
                    if baud = '1';
                        state <= ende;
                        valid = '1';
                    end if;
                when ende =>
                    if baud = '1';
                        state <= idle;
                        valid <= '0';

                    end if;
                when others =>
                    null;
            end case;
        end if;          
    end process;
end;