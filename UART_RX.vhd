library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_RX is
    port(clk    : in std_logic;
        data    : in std_logic;
        valid   : out std_logic := '0';
        UART_rx_1 : out std_logic_vector (7 downto 0));
end UART_RX;

architecture Behavioral of UART_RX is
    component main_UART_RX is
        port(clk    : in std_logic;
            data    : in std_logic;
            baud    : in std_logic;
            valid   : out std_logic := '0';
            y       : out std_logic_vector(7 downto 0));
    end component;
    
    component sampler_UART_RX is
        generic(constant lambda : integer := 868);
        port(clk        : in std_logic;
            data        : in std_logic;
            baudrate    : out std_logic);
    end component;
    
    signal baud : std_logic;
    
begin
    delayed_pulse_generator : sampler_UART_RX port map(clk=>clk, data=>data, baudrate=>baud);
    state_machine           : main_UART_RX port map(clk=>clk, data=>data, valid=>valid, baud=>baud, y=>UART_rx_1);
end Behavioral;