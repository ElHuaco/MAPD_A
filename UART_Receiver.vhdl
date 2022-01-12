library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UART_Receiver is
    port(clk : in std_logic;
        data : in std_logic;
        valid : out std_logic := '0';
        y : out std_logic_vector(7 downto 0));
end entity UART_Receiver;

architecture behave of UART_Receiver is
    component rec is 
        port(clk : in std_logic;
            data : in std_logic;
            baud : in std_logic;
            valid : out std_logic;
            y : out std_logic_vector(7 downto 0));
    end component;

    component sampler_UART_RX is
        port(clk : in std_logic;
            data : in std_logic;
            baudrate : out std_logic);
    end component;

    signal baud : std_logic;

begin 
    state_machine : rec port map(clk=>clk, data=>data, valid=>valid, baud=>baud, y=>y);
    sample : sampler_UART_RX port map(clk=>clk, data=>data, baudrate=>baud);
end behave;
