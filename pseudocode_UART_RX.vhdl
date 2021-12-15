library IEEE;
use library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sampler is

	generic(constant lambda : integer := 868);

	port(clk		: in std_logic;
		uart_rx		: in std_logic;
		baudrate	: out std_logic);

end sampler;

architecture my_sampler of sampler is

	signal clk_cnt	: integer <= 0
	signal start	: std_logic <= '0'
	signal pulse	: std_logic <= '0'

begin
	detect_start	: process(clk)
	begin
		if rising_edge(clk) then
			if start = '0' and uart_rx = '0' then
				start <= '1'
			end if;
		end if;
	end process;

	pulse_generator	: process(clk, start)
	begin
	---for 10 times
	---		generate a pulse for one clock cycle
	---		each 868 clock cycles.
	---start <= '0'
		if start <= '1' then
			for iterations in 0 to 9 loop
				if rising_edge(clk) then
					clk_cnt <= clk_cnt + 1;
					if clk_cnt = lambda then
						pulse <= '1';
						clk_cnt <= 0
					elsif
						pulse <= '0';
					end if;
				end if;
			end loop;
			start <= '0';
		end if;
	end process;

	delayer			: process(clk, pulse)
	begin
	---delay the pulse and output it
	end process;

end my_sampler;
