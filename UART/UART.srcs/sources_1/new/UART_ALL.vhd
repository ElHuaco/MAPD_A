library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UART_ALL is
    port(clk : in std_logic;
         input : in std_logic;
         output : out std_logic;
         busy : out std_logic);
end entity UART_ALL;


architecture Behavioral of UART_ALL is
    component UART_Receiver is
       port(clk : in std_logic;
        data : in std_logic;
        valid : out std_logic := '0';
        y : out std_logic_vector(7 downto 0));
    end component;
    
    component UART_Transmitter is
        port(clk : in std_logic; 
         data_valid : in std_logic;
         data_vec : in std_logic_vector(7 downto 0);
         busy : out std_logic;
         UART_tx : out std_logic);
    end component;

    signal valid : std_logic; 
    signal data_inside : std_logic_vector(7 downto 0);
    
begin
    receiver : UART_Receiver port map(clk=>clk, data=>input, valid=>valid, y=>data_inside);
    transmitter : UART_Transmitter port map(clk=>clk, UART_tx=>output, data_valid=>valid, data_vec=>data_inside, busy=>busy);
end Behavioral;
