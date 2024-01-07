library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCIMMadd is
	port (opcode3: IN STD_LOGIC_VECTOR(3 downto 0);
	     clk: in std_logic;
		  RA:in STD_LOGIC_VECTOR(15 downto 0);
		  RB:in STD_LOGIC_VECTOR(15 downto 0);
		  PC, Imm: IN STD_LOGIC_VECTOR(15 downto 0);
		  --------------------------------------------------
		  PCout : OUT STD_LOGIC_VECTOR(15 downto 0)
		   );
end PCIMMadd;


architecture behave of PCIMMadd is
begin
 
process(PC, Imm,opcode3,RA,RB)
  
variable T1: STD_LOGIC_VECTOR(15 downto 0);
  

begin
  T1:="0000000000000010" ;
if (clk'event and clk = '1') then


if (opcode3 = "1000" or opcode3 = "1001" or opcode3 = "1010" or opcode3 = "1100") then
PCout <= STD_LOGIC_VECTOR(unsigned(PC) +unsigned(Imm)+ unsigned(Imm) );
end if;

if (opcode3 = "1101") then
PCout <= RB;
end if;

if (opcode3 = "1000" ) then  
PCout <= STD_LOGIC_VECTOR(unsigned(PC) +unsigned(IMM) );
end if ;

end if;
end process;
end behave;
