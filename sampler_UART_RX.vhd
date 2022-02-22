library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sampler_UART_RX is
	generic(constant lambda : integer := 868;
	       constant halflambda : integer := 434);
	port(clk		: in std_logic;
		data		: in std_logic;
		baudrate	: out std_logic);
end sampler_UART_RX;

architecture my_sampler of sampler_UART_RX is
    type state_t is (idle_s, start_s, bit0_s, bit1_s, bit2_s, bit3_s, bit4_s, bit5_s, bit6_s, bit7_s, stop_s);
    signal state                    : state_t := idle_s;
    signal enable_pulse_generator   : std_logic := '0';
    signal reset_delay_cnt          : std_logic := '0';
	signal pulse                    : std_logic := '0';
	signal baud_cnt                 : integer := lambda;
	signal delay_cnt                : integer := lambda;

begin
    --Need state machine because the same signal (enable_pulse)
    --cannot be changed in different processes (start_stop_detector and pulse_generator).
	start_stop_detector	: process(clk)
    begin
        if rising_edge(clk) then
          case state is
            when idle_s =>
                enable_pulse_generator <= '0';
                if data = '0' then
                  state <= start_s;
                end if;
            when start_s =>
                enable_pulse_generator <= '1';
                if pulse = '1' then
                  state <= bit0_s;
                end if;
            when bit0_s =>
                if pulse = '1' then
                  state <= bit1_s;
                end if;
            when bit1_s =>
                if pulse = '1' then
                  state <= bit2_s;
                end if;
            when bit2_s =>
                if pulse = '1' then
                  state <= bit3_s;
                end if;
            when bit3_s =>
                if pulse = '1' then
                  state <= bit4_s;
                end if;
            when bit4_s =>
                if pulse = '1' then
                  state <= bit5_s;
                end if;
            when bit5_s =>
                if pulse = '1' then
                  state <= bit6_s;
                end if;
            when bit6_s =>
                if pulse = '1' then
                  state <= bit7_s;
                end if;
            when bit7_s =>
                if pulse = '1' then
                  state <= stop_s;
                end if;
            when stop_s =>
                if pulse = '1' then
                    state <= idle_s;
                end if;
            when others =>
                null;
            end case;
        end if;
    end process;

	pulse_generator	: process(clk)
	begin
		if rising_edge(clk) then
			if enable_pulse_generator = '1' then
				if baud_cnt < lambda then
					baud_cnt <= baud_cnt + 1;
					pulse <= '0';
					reset_delay_cnt <= '0';
				else
					baud_cnt <= 0;
					pulse <= '1';
					reset_delay_cnt <= '1';
				end if;
			else
			    baud_cnt <= lambda;
			end if;
		end if;
	end process;

	delayer			: process(clk)
	begin
        if rising_edge(clk) then
            if reset_delay_cnt = '1' then
                delay_cnt <= 0;
            end if;
            if delay_cnt < halflambda then
                delay_cnt <= delay_cnt + 1;
                baudrate <= '0';
            --- A 1-clock-cycle pulse delayed lambda/2 cycles.
            elsif delay_cnt = halflambda then
                delay_cnt <= delay_cnt + 1;
                baudrate <= '1';
            else
                baudrate <= '0';
            end if;   
		end if;
	end process;

end my_sampler;