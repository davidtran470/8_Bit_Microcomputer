library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu is
    Port ( -- INPUT
			  I_clk, I_rst : in  STD_LOGIC;
			  I_from_mem :  in  STD_LOGIC_VECTOR (7 downto 0);
			  -- OUTPUT
           O_write : out  STD_LOGIC;												-- Write Enable
           O_address, O_to_mem: out  STD_LOGIC_VECTOR (7 downto 0)); 	-- Address Bus, To Memory,	From Memory									
end cpu;

architecture Structural of cpu is

begin


end Structural;

