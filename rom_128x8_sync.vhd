library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom_128x8_sync is
    Port ( I_clk : in  STD_LOGIC;
           I_address : in  STD_LOGIC_VECTOR (7 downto 0);
           O_data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end rom_128x8_sync;

architecture Structural of rom_128x8_sync is
	signal EN: STD_LOGIC;										  -- Enable signal
	type rom_type is array (0 to 127) of STD_LOGIC_VECTOR (7 downto 0);
	
	-- Opcode Declaration 
	
	-- "Load and Stores"
	constant LDA_IMM : STD_LOGIC_VECTOR (7 downto 0) := x"86"; -- Load Register A using Immediate Addressing
	constant LDA_DIR : STD_LOGIC_VECTOR (7 downto 0) := x"87"; -- Load Register A using Direct Addressing
	constant LDB_IMM : STD_LOGIC_VECTOR (7 downto 0) := x"88"; -- Load Register B using Immediate Addressing
	constant LDB_DIR : STD_LOGIC_VECTOR (7 downto 0) := x"89"; -- Load Register B using Direct Addressing
	constant STA_DIR : STD_LOGIC_VECTOR (7 downto 0) := x"96"; -- Store Register A using Direct Addressing
	constant STB_DIR : STD_LOGIC_VECTOR (7 downto 0) := x"97"; -- Store Register B using Direct Addressing
	-- "Data Manipulation"
	constant ADD_AB : STD_LOGIC_VECTOR (7 downto 0) := x"42"; -- A = A + B (plus)
	constant SUB_AB : STD_LOGIC_VECTOR (7 downto 0) := x"43"; -- A = A - B (plus)
	constant AND_AB : STD_LOGIC_VECTOR (7 downto 0) := x"44"; -- A = A & B (AND)
	constant OR_AB : STD_LOGIC_VECTOR (7 downto 0) := x"45"; -- A = A | B (OR)
	constant INCA : STD_LOGIC_VECTOR (7 downto 0) := x"46"; -- A = A + 1 (increment A)
	constant INCB : STD_LOGIC_VECTOR (7 downto 0) := x"47"; -- B = B + 1 (increment B)
	constant DECA : STD_LOGIC_VECTOR (7 downto 0) := x"48"; -- A = A - 1 (decrement A)
	constant DECB : STD_LOGIC_VECTOR (7 downto 0) := x"49"; -- B = B - 1 (decrement B)
	-- "Branches"
	constant BRA : STD_LOGIC_VECTOR (7 downto 0) := x"20"; -- Branch Always to Address Provided
	constant BMI : STD_LOGIC_VECTOR (7 downto 0) := x"21"; -- Branch to Address Provided if N = 1
	constant BPL : STD_LOGIC_VECTOR (7 downto 0) := x"22"; -- Branch to Address Provided if N = 0
	constant BEQ : STD_LOGIC_VECTOR (7 downto 0) := x"23"; -- Branch to Address Provided if Z = 1
	constant BNE : STD_LOGIC_VECTOR (7 downto 0) := x"24"; -- Branch to Address Provided if Z = 0
	constant BVS : STD_LOGIC_VECTOR (7 downto 0) := x"25"; -- Branch to Address Provided if V = 1
	constant BVC : STD_LOGIC_VECTOR (7 downto 0) := x"26"; -- Branch to Address Provided if V = 0
	constant BCS : STD_LOGIC_VECTOR (7 downto 0) := x"27"; -- Branch to Address Provided if C = 1
	constant BCC : STD_LOGIC_VECTOR (7 downto 0) := x"28"; -- Branch to Address Provided if C = 0
	
	-- Program Example, continually write x"AA" to port_out_00
	constant ROM: rom_type := (0 => LDA_IMM,
									1 => x"AA",
									2 => STA_DIR,
									3 => x"E0",
									4 => BRA,
									5 => x"00",
									others => x"00");
begin

	-- Checks that the address is located in the ROM
	ENABLE : process(I_address)
	begin	
		if((to_integer(unsigned(I_address)) >= 0) and 
			(to_integer(unsigned(I_address)) <= 127)) then 
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;
	
	-- Searches ROM for byte specified in address bus and pushes it to O_data_out
	MEMORY : process(I_clk)
	begin
		if(rising_edge(I_clk)) then
			if(EN = '1') then
				O_data_out <= ROM(to_integer(unsigned(I_address)));
			end if;
		end if;
	end process;
		
end Structural;