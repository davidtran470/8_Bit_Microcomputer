library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rw_96x8_sync is
    Port ( I_clk, I_write : in  STD_LOGIC;
           I_address, I_data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           O_data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end rw_96x8_sync;

architecture Structural of rw_96x8_sync is 
	signal EN: STD_LOGIC;
	type rw_type is array (128 to 223) of STD_LOGIC_VECTOR (7 downto 0);
	signal RW: rw_type;

begin

	-- Checks that the address is located in the RW (Data Memory)
	ENABLE : process(I_address, I_write)
	begin	
		if((to_integer(unsigned(I_address)) >= 128) and 
			(to_integer(unsigned(I_address)) <= 223)) then 
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;
	
	-- Searches RW for byte specified in address bus and pushes it to O_data_out,
	-- or writes to the location if the write signal is high
	MEMORY : process(I_clk)
	begin
		if(rising_edge(I_clk)) then
			if(EN = '1') then
				if(I_write = '1') then
					RW(to_integer(unsigned(I_address))) <= I_data_in;
				else
					O_data_out <= RW(to_integer(unsigned(I_address)));
				end if;
			end if;
		end if;
	end process;
		
end Structural;



