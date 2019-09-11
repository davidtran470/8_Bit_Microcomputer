library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity output_ports is
    Port ( I_clk : in  STD_LOGIC;
           I_rst : in  STD_LOGIC;
           I_address : in  STD_LOGIC_VECTOR (7 downto 0);
           I_data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           I_write : in  STD_LOGIC;
           port_out_00, port_out_01, port_out_02, port_out_03,	-- Output Ports
			  port_out_04, port_out_05, port_out_06, port_out_07,
			  port_out_08, port_out_09, port_out_10, port_out_11,
			  port_out_12, port_out_13, port_out_14, port_out_15 : out STD_LOGIC_VECTOR(7 downto 0));
end output_ports;

architecture Structural of output_ports is
	signal EN: STD_LOGIC;
begin

-- Checks that the address is located in the Output Location
	ENABLE : process(I_address)
	begin	
		if((to_integer(unsigned(I_address)) >= 224) and 
			(to_integer(unsigned(I_address)) <= 239)) then 
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;
	
--Process for output ports depending on address signal
	UX: process(I_clk, I_rst)
	begin
		if(I_rst = '0') then
			port_out_01 <= x"00";
			port_out_02 <= x"00";
			port_out_03 <= x"00";
			port_out_04 <= x"00";
			port_out_05 <= x"00";
			port_out_06 <= x"00";
			port_out_07 <= x"00";
			port_out_08 <= x"00";
			port_out_09 <= x"00";
			port_out_10 <= x"00";
			port_out_11 <= x"00";
			port_out_12 <= x"00";
			port_out_13 <= x"00";
			port_out_14 <= x"00";
			port_out_15 <= x"00";
		elsif(rising_edge(I_clk)) then 
			if(en = '1' and I_write = '1') then
				case I_address is
					when x"E0" => port_out_00 <= I_data_in;
					when x"E1" => port_out_01 <= I_data_in;						
					when x"E2" => port_out_02 <= I_data_in;					
					when x"E3" => port_out_03 <= I_data_in;	
					when x"E4" => port_out_04 <= I_data_in;
					when x"E5" => port_out_05 <= I_data_in;						
					when x"E6" => port_out_06 <= I_data_in;					
					when x"E7" => port_out_07 <= I_data_in;
					when x"E8" => port_out_08 <= I_data_in;
					when x"E9" => port_out_09 <= I_data_in;						
					when x"EA" => port_out_10 <= I_data_in;					
					when x"EB" => port_out_11 <= I_data_in;
					when x"EC" => port_out_12 <= I_data_in;
					when x"ED" => port_out_13 <= I_data_in;						
					when x"EE" => port_out_14 <= I_data_in;					
					when others => port_out_15 <= I_data_in;	
				end case;
			end if;
		end if;
	end process;
	
end Structural;