library ieee;
use ieee.std_logic_1164.all;
entity Uart is
    Port(clk : in std_logic; 
         data_valid : in std_logic;
         data_vec : in std_logic_vector(7 downto 0);
         busy : out std_logic;
         UART_tx : out std_logic);
end UART;

architecture rtl of UART is
    component baud is
     generic ( constant lambda : integer:= 868 );
     port ( clk : in std_logic;
             y : out std_logic);
    end component;
    component tx_state is
     port ( a : in std_logic_vector(7 downto 0);
     clk : in std_logic; 
     b_out : in std_logic;
     y : out std_logic;
     busy : out std_logic;
     valid : in std_logic);
    end component;
    signal baudrate_out : std_logic;
begin
    B : baud port map(clk=>clk, y=>baudrate_out);
    TX : tx_state port map(clk=>clk, b_out=>baudrate_out, valid=>data_valid, a=>data_vec, busy=>busy, y=>UART_tx);
end rtl;
