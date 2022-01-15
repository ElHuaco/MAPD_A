library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UART is
    port(clk : in std_logic;
        data : in std_logic;
        valid : out std_logic := '0';
        y : out std_logic_vector(7 downto 0));
end entity UART_Receiver;