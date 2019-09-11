----------------------------------------------------------------------------------
-- Company: 
-- Engineer: David Tran
-- 
-- Create Date:    17:07:36 09/07/2019 
-- Design Name: 
-- Module Name:    computer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity computer is
    Port ( I_clk : in  STD_LOGIC;												-- 50 Mhz Clock
           I_rst : in  STD_LOGIC;												-- Reset, active high
			  
			  I_port_in_00, I_port_in_01, I_port_in_02, I_port_in_03,	-- Input Ports
			  I_port_in_04, I_port_in_05, I_port_in_06, I_port_in_07,
			  I_port_in_08, I_port_in_09, I_port_in_10, I_port_in_11,
			  I_port_in_12, I_port_in_13, I_port_in_14, I_port_in_15 : in STD_LOGIC_VECTOR(7 downto 0);
			  
			  O_port_out_00, O_port_out_01, O_port_out_02, O_port_out_03,	-- Output Ports
			  O_port_out_04, O_port_out_05, O_port_out_06, O_port_out_07,
			  O_port_out_08, O_port_out_09, O_port_out_10, O_port_out_11,
			  O_port_out_12, O_port_out_13, O_port_out_14, O_port_out_15 : out STD_LOGIC_VECTOR(7 downto 0));			  
end computer;

architecture Structural of computer is

--------------------------------------------
-------------Signal Declaraction------------
--------------------------------------------

-- Temporary signals (wires) to connect cpu and memory.
	signal write1: STD_LOGIC := '0';
	signal address1, from_mem1, to_mem1: STD_LOGIC_VECTOR (7 downto 0) := x"00";

--------------------------------------------
-----------Component Declaraction-----------
--------------------------------------------
	component cpu is
		port(I_clk, I_rst  : in  STD_LOGIC;
			I_from_mem : in  STD_LOGIC_VECTOR (7 downto 0); 
			O_write : out  STD_LOGIC;
			O_address, O_to_mem : out  STD_LOGIC_VECTOR (7 downto 0));
	end component cpu;
		
	component memory is
		port(I_clk, I_rst, I_write : in  STD_LOGIC;
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
	end component memory;

begin

--------------------------------------------
-----------Component Instantiation----------
--------------------------------------------
	CPU1: cpu port map (I_clk => I_clk, I_rst => I_rst, I_from_mem => from_mem1,
								O_write => write1, O_address => address1, O_to_mem => to_mem1);
								
	MEM1: memory port map (I_clk => I_clk, I_rst => I_rst, I_write => write1, I_address => address1,
								I_data_in => to_mem1, O_data_out => from_mem1,
								
								port_in_00 => I_port_in_00, port_in_01 => I_port_in_01, --Input
								port_in_02 => I_port_in_02, port_in_03 => I_port_in_03,	
								port_in_04 => I_port_in_04, port_in_05 => I_port_in_05, 
								port_in_06 => I_port_in_06, port_in_07 => I_port_in_07,
								port_in_08 => I_port_in_08, port_in_09 => I_port_in_09, 
								port_in_10 => I_port_in_10, port_in_11 => I_port_in_11,
								port_in_12 => I_port_in_12, port_in_13 => I_port_in_13, 
								port_in_14 => I_port_in_14, port_in_15 => I_port_in_15,
								
								port_out_00 => O_port_out_00, port_out_01 => O_port_out_01, --Ouput
								port_out_02 => O_port_out_02, port_out_03 => O_port_out_03,	
								port_out_04 => O_port_out_04, port_out_05 => O_port_out_05, 
								port_out_06 => O_port_out_06, port_out_07 => O_port_out_07,
								port_out_08 => O_port_out_08, port_out_09 => O_port_out_09, 
								port_out_10 => O_port_out_10, port_out_11 => O_port_out_11,
								port_out_12 => O_port_out_12, port_out_13 => O_port_out_13, 
								port_out_14 => O_port_out_14, port_out_15 => O_port_out_15);
								
													
end Structural;

