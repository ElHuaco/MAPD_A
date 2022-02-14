library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity myregister is
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        writeEnableA : in std_logic; --signal to write to register A
        writeEnableB : in std_logic; -- signal to write to register B
        readSelA, readSelB, writeSelA, writeSelB : in std_logic_vector(3 downto 0); --0000 to 1111 => values from 0 to 15
        data_inA, data_inB : in std_logic_vector(3 downto 0); -- same as above
        data_outA, data_outB: out std_logic_vector(3 downto 0) -- same as above
    );
end myregister;

architecture behavioral of register is
    type regArray is array (0 to 7) of std_logic_vector(3 downto 0); --we create a register of 8 rows which we can read/write values from 0 to 15 in each one
    signal registers : regArray := (others => (others => '0')); --initialize to 0

begin
    data_outA <= registers(to_integer(unsigned(readSelA))); -- access register index of readSelA
    -- for example readSelA = 1010, data_outA is then the contents of the 12th register. Which is a number from 0 to 15
    data_outB <= registers(to_integer(unsigned(readSelB))); -- Same thing but second output
    registerFile_main : process(clk)
    begin
        if(rising_edge(clk)) then --note that we haven't specified the condition rst = '0', register retains memory
            if(rst = '1') then
                registers <= (others => (others => '0')); --delete everything
            else
                if(writeEnableA = '1') then
                    registers(to_integer(unsigned(writeSelA))) <= data_inA; --if we enable writing of data_inA, the position of the writing is specified by value of writeSelA
                end if;
                if(writeEnableB = '1') then
                    registers(to_integer(unsigned(writeSelB))) <= data_inB;
                end if;
            end if;
        end if;
    end process;
end behavioral;
