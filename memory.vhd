library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
    Port ( I_clk, I_rst, I_write : in  STD_LOGIC;
			  I_address : in  STD_LOGIC_VECTOR (7 downto 0);
           I_data_in : in  STD_LOGIC_VECTOR (7 downto 0);
			  O_data_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  
			  port_in_00, port_in_01, port_in_02, port_in_03,	-- Input Ports
			  port_in_04, port_in_05, port_in_06, port_in_07,
			  port_in_08, port_in_09, port_in_10, port_in_11,
			  port_in_12, port_in_13, port_in_14, port_in_15 : in STD_LOGIC_VECTOR(7 downto 0);
			  
			  port_out_00, port_out_01, port_out_02, port_out_03,	-- Output Ports
			  port_out_04, port_out_05, port_out_06, port_out_07,
			  port_out_08, port_out_09, port_out_10, port_out_11,
			  port_out_12, port_out_13, port_out_14, port_out_15 : out STD_LOGIC_VECTOR(7 downto 0));
end memory;

architecture Structural of memory is
--------------------------------------------
-------------Signal Declaraction------------
--------------------------------------------
	signal rom_data_out, rw_data_out: STD_LOGIC_VECTOR(7 downto 0);
	
--------------------------------------------
-----------Component Declaraction-----------
--------------------------------------------
	component rom_128x8_sync is
		port(I_clk : in  STD_LOGIC;
           I_address : in  STD_LOGIC_VECTOR (7 downto 0);
           O_data_out : out  STD_LOGIC_VECTOR (7 downto 0));
	end component rom_128x8_sync;
	
	component rw_96x8_sync is
		port( I_clk, I_write : in  STD_LOGIC;
           I_address, I_data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           O_data_out : out  STD_LOGIC_VECTOR (7 downto 0));
	end component rw_96x8_sync;
	
	component output_ports is
		port(I_clk : in  STD_LOGIC;
           I_rst : in  STD_LOGIC;
           I_address : in  STD_LOGIC_VECTOR (7 downto 0);
           I_data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           I_write : in  STD_LOGIC;
           port_out_00, port_out_01, port_out_02, port_out_03,
			  port_out_04, port_out_05, port_out_06, port_out_07,
			  port_out_08, port_out_09, port_out_10, port_out_11,
			  port_out_12, port_out_13, port_out_14, port_out_15 : out STD_LOGIC_VECTOR(7 downto 0));
	end component output_ports;

begin

--------------------------------------------
-----------Component Instantiation----------
--------------------------------------------
	ROM1: rom_128x8_sync port map(I_clk => I_clk, I_address => I_address, O_data_out => rom_data_out);
	
	RW1: rw_96x8_sync port map(I_clk => I_clk, I_write => I_write, I_address => I_address, 
											I_data_in => I_data_in, O_data_out => rw_data_out);
					
	OUT1: output_ports port map(I_clk => I_clk, I_rst => I_rst, I_address => I_address, 
											I_data_in => I_data_in, I_write => I_write,
											port_out_00 => port_out_00, port_out_01 => port_out_01, --Ouput
											port_out_02 => port_out_02, port_out_03 => port_out_03,	
											port_out_04 => port_out_04, port_out_05 => port_out_05, 
											port_out_06 => port_out_06, port_out_07 => port_out_07,
											port_out_08 => port_out_08, port_out_09 => port_out_09, 
											port_out_10 => port_out_10, port_out_11 => port_out_11,
											port_out_12 => port_out_12, port_out_13 => port_out_13, 
											port_out_14 => port_out_14, port_out_15 => port_out_15);
											
--------------------------------------------
-----------Process Implementation-----------
--------------------------------------------
-- Multiplexer to decide which output to send to the CPU
	MUX1: process(I_address, rom_data_out, rw_data_out, 
						port_in_00, port_in_01, port_in_02, port_in_03,	
						port_in_04, port_in_05, port_in_06, port_in_07,
						port_in_08, port_in_09, port_in_10, port_in_11,
						port_in_12, port_in_13, port_in_14, port_in_15)
	begin
	-- ROM
		if ((to_integer(unsigned(I_address)) >= 0) and
				(to_integer(unsigned(I_address)) <= 127)) then 
			O_data_out <= rom_data_out;
	-- RW (Data Memory)
		elsif ((to_integer(unsigned(I_address)) >= 128) and 
				(to_integer(unsigned(I_address)) <= 223)) then
			O_data_out <= rw_data_out;
		elsif (I_address = x"F0") then O_data_out <= port_in_00; 
		elsif (I_address = x"F1") then O_data_out <= port_in_01; 
		elsif (I_address = x"F2") then O_data_out <= port_in_02; 
		elsif (I_address = x"F3") then O_data_out <= port_in_03; 
		elsif (I_address = x"F4") then O_data_out <= port_in_04; 
		elsif (I_address = x"F5") then O_data_out <= port_in_05; 
		elsif (I_address = x"F6") then O_data_out <= port_in_06; 
		elsif (I_address = x"F7") then O_data_out <= port_in_07; 
		elsif (I_address = x"F8") then O_data_out <= port_in_08; 
		elsif (I_address = x"F9") then O_data_out <= port_in_09; 
		elsif (I_address = x"FA") then O_data_out <= port_in_10; 
		elsif (I_address = x"FB") then O_data_out <= port_in_11; 
		elsif (I_address = x"FC") then O_data_out <= port_in_12; 
		elsif (I_address = x"FD") then O_data_out <= port_in_13; 
		elsif (I_address = x"FE") then O_data_out <= port_in_14; 
		elsif (I_address = x"FF") then O_data_out <= port_in_15;
		else O_data_out <= x"00";
		end if; 
	end process;
end Structural;

