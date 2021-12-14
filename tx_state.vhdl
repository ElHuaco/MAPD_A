library ieee;
use ieee.std_logic_1164.all;
entity tx_state is
 port ( a : in std_logic_vector(7 downto 0);
    clk : in std_logic; 
    b_out : in std_logic;
    y : out std_logic;
    busy : out std_logic;
    valid : in std_logic);
end entity tx_state;

architecture rtl of tx_state is
    type state_t is (lsb, b1, b2 ,b3 ,b4, b5,b6, b7, start, stop, idle, data_valid);
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
            if valid='1' then
                state <= data_valid;
            end if;
            
            when data_valid =>
            y <= '1';
            copy <= a;
            if b_out='1' then
                state <= start;
            end if;
            
            when start =>
            y <= '1';
            busy <= '1';
            if b_out='1' then
                state <= lsb;
            end if;
            
            when lsb =>
            y <= copy(0);
            if b_out='1' then
                state <= b1;
            end if;
            
            when b1 =>
            y <= copy(1); --OUTPUT THE COPY[i] VALUE (FIND THE SYNTAX!!
            if b_out='1' then
                state <= b2;
            end if;
            
            when b2 =>
            y <= copy(2);
            if b_out='1' then
                state <= b3;
            end if;
            
            when b3 =>
            y <= copy(3);
            if b_out='1' then
                state <= b4;
            end if;
            
            when b4 =>
            y <= copy(4);
            if b_out='1' then
                state <= b5;
            end if;
            
            when b5 =>
            y <= copy(5);
            if b_out='1' then
                state <= b6;
            end if;
            
            when b6 =>
            y <= copy(6);
            if b_out='1' then
                state <= b7;
            end if;
            
            when b7 =>
            y <= copy(7);
            if b_out='1' then
                state <= stop;
            end if;
            
            when stop =>
            y <= '1';
            if b_out='1' then
                state <= idle;
            end if;
        end case;
       end if;
      end process;
end;