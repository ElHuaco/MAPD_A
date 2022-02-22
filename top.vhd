library ieee;
use ieee.std_logic_1164.all;



entity top is

  port (

    CLK100MHZ    : in  std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic);
    
end entity top;

architecture str of top is
  signal clock        : std_logic;
  signal data_to_send_1 : std_logic_vector(7 downto 0) := X"61";
  signal data_to_send_2 :  std_logic_vector(7 downto 0);
  signal data_valid   : std_logic;
  signal busy         : std_logic;
  signal uart_tx      : std_logic;
  signal data_out_1   : std_logic_vector(7 downto 0);
  signal data_out_2   : std_logic_vector(7 downto 0);
  signal data_out_3   :  std_logic_vector(7 downto 0);
  signal data_out_4   :  std_logic_vector(7 downto 0);
  signal valid_out    : std_logic;
 

  component uart_transmitter is
    port (
      clock        : in  std_logic;
      data_to_send : in  std_logic_vector(7 downto 0);
      data_valid   : in  std_logic;
      busy         : out std_logic;
      uart_tx      : out std_logic);
  end component uart_transmitter;

  component myregister is
    port (
      clk        : in  std_logic;
      data_in : in  std_logic_vector(7 downto 0);
      data_out_1 : out std_logic_vector(7 downto 0):= "0000";
      data_out_2 : out std_logic_vector(7 downto 0):= "0000";
      data_out_3 : out std_logic_vector(7 downto 0):= "0000";
      data_out_4 : out std_logic_vector(7 downto 0):= "0000";
      valid : in std_logic
        );
  end component myregister;


component selector is
    port
    (
        clk : in std_logic;
        valid : in std_logic;
        data_out : out std_logic_vector(7 downto 0); --we should use the first "something" bits to specify a register and then the other ones to perform an operation on it
        data_in : in std_logic_vector(7 downto 0);
        data_in_1 : in std_logic_vector(7 downto 0);
        data_in_2 : in std_logic_vector(7 downto 0);
        data_in_3 : in std_logic_vector(7 downto 0);
        data_in_4 : in std_logic_vector(7 downto 0);
        valid_out : out std_logic := '0'
        
    );
end component selector;


  component uart_receiver is
    port (
      clock         : in  std_logic;
      uart_rx       : in  std_logic;
      valid         : out std_logic;
      received_data : out std_logic_vector(7 downto 0));
  end component uart_receiver;
begin  -- architecture str

  uart_receiver_1 : uart_receiver

    port map (
      clock         => CLK100MHZ,
      uart_rx       => uart_txd_in,
      valid         => data_valid,
      received_data => data_to_send_1);
      
      
  myregister_1 : myregister
 
    port map (
     clk         => CLK100MHZ,
     data_in     => data_to_send_1,
     data_out_1    => data_out_1,
     data_out_2    => data_out_2,
     data_out_3    => data_out_3,
     data_out_4    => data_out_4,
     valid => data_valid);
     
    
   selector_1 : selector
 
    port map (
     clk         => CLK100MHZ,
     data_in     => data_to_send_1,
     data_in_1    => data_out_1,
     data_in_2    => data_out_2,
     data_in_3    => data_out_3,
     data_in_4    => data_out_4,
     data_out => data_to_send_2,
     valid => data_valid,
     valid_out => valid_out); 
     
      
  uart_transmitter_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => data_to_send_2,
      data_valid   => valid_out,
      busy         => busy,
      uart_tx      => uart_rxd_out);

end architecture str;
