library ieee;
use ieee.std_logic_1164.all;
entity UART_TX is
    Port(clk        : in std_logic; 
         valid      : in std_logic;
         data_in    : in std_logic_vector(7 downto 0);
         busy       : out std_logic;
         UART_tx    : out std_logic);
end UART_TX;

architecture rtl of UART_TX is
    component baud_UART_TX is
     generic ( constant lambda : integer := 868 );
     port(clk       : in std_logic;
         enabler    : in std_logic;
         y          : out std_logic);
    end component;
    
    component main_UART_TX is
     port(data_in       : in std_logic_vector(7 downto 0);
         clk            : in std_logic; 
         baud           : in std_logic;
         y              : out std_logic;
         busy           : out std_logic;
         enable_baud    : out std_logic;
         valid          : in std_logic);
    end component;
    
    signal baudrate, enable_baud : std_logic;

begin
    baud_generator : baud_UART_TX port map(clk=>clk, y=>baudrate, enabler=>enable_baud);
    state_machine : main_UART_TX port map(clk=>clk, baud=>baudrate, valid=>valid, data_in=>data_in, busy=>busy, y=>UART_tx, enable_baud=>enable_baud);
end rtl;