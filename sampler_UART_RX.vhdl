library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sampler_UART_RX is

	generic(constant lambda : integer := 868);

	port(clk		: in std_logic;
		data		: in std_logic;
		baudrate	: out std_logic);

end sampler_UART_RX;

architecture my_sampler of sampler_UART_RX is

	signal bau_cnt	: integer := 0;
	signal dly_cnt : integer := lambda;
	signal pls_cnt	: integer;
	signal enable	: std_logic := '0';
	signal pulse	: std_logic := '0';

begin
	start_detector	: process(clk)
	begin
		if rising_edge(clk) then
			if enable = '0' then
				if data = '0' then
					enable <= '1';
					pls_cnt <= 0;
					pulse <= '1';
				end if;
			end if;
		end if;
	end process;

	pulse_generator	: process(clk)
	begin
		if rising_edge(clk) then
			if enable = '1' then
				if pls_cnt = 9 then
					enable <= '0';
					pulse <= '0';
					bau_cnt <= 0;
				elsif bau_cnt < lambda then
					bau_cnt <= bau_cnt + 1;
					pulse <= '0';
				else
					bau_cnt <= 0;
					pls_cnt <= pls_cnt + 1;
					pulse <= '1';
				end if;
			end if;
		end if;
	end process;

	delayer			: process(clk, pulse)
	begin
		if pulse = '1' then
			dly_cnt <= 0;
		elsif rising_edge(clk) then
			if dly_cnt < 434 then
				dly_cnt <= dly_cnt + 1;
				baudrate <= '0';
			--- 1-clock-cycle pulse delayed 434.
			elsif dly_cnt = 434 then
				dly_cnt <= dly_cnt + 1;
				baudrate <= '1';
			else
				baudrate <= '0';
			end if;
		end if;
	end process;

end my_sampler;
