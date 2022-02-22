library ieee;
use ieee.std_logic_1164.all;
entity main_UART_TX is
    port(clk        : in std_logic;
        valid       : in std_logic;
        baud        : in std_logic;
        data_in     : in std_logic_vector(7 downto 0);
        enable_baud : out std_logic := '0';
        y           : out std_logic;
        busy        : out std_logic);
end entity main_UART_TX;

architecture rtl of main_UART_TX is

    type state_t is (lsb, b1, b2, b3, b4, b5, b6, b7, start, stop, idle);
    signal state : state_t := idle;
    signal copy : std_logic_vector(7 downto 0);

begin 
    main : process (clk) is
    begin
     if rising_edge(clk) then
        case state is
            when idle =>
                y <= '1';
                busy <= '0';
                enable_baud <= '0';
                if valid = '1' then
                    state <= start;
                    enable_baud <= '1';
                end if;
            when start =>
                y <= '0';
                copy <= data_in;
                busy <= '1';
                if baud = '1' then
                    state <= lsb;
                end if;
            when lsb =>
                y <= copy(0);
                if baud = '1' then
                    state <= b1;
                end if;
            when b1 =>
                y <= copy(1);
                if baud = '1' then
                    state <= b2;
                end if;
            when b2 =>
                y <= copy(2);
                if baud = '1' then
                    state <= b3;
                end if;
            when b3 =>
                y <= copy(3);
                if baud = '1' then
                    state <= b4;
                end if;
            when b4 =>
                y <= copy(4);
                if baud = '1' then
                    state <= b5;
                end if;
            when b5 =>
                y <= copy(5);
                if baud = '1' then
                    state <= b6;
                end if;
            when b6 =>
                y <= copy(6);
                if baud = '1' then
                    state <= b7;
                end if;
            when b7 =>
                y <= copy(7);
                if baud = '1' then
                    state <= stop;
                end if;
            when stop =>
                y <= '1';
                if baud = '1' then
                    state <= idle;
                end if;
            when others =>
                null;
        end case;
       end if;
      end process;
end;