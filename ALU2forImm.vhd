library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU2forImm is
	port (
	     clk: in std_logic;
		  PC, Imm: IN STD_LOGIC_VECTOR(15 downto 0);
		  --------------------------------------------------
		  PCout : OUT STD_LOGIC_VECTOR(15 downto 0)
		   );
end ALU2forImm;


architecture behave of ALU2forImm is
begin
  
process(PC, Imm)

 begin
if (clk'event and clk = '1') then
	PCout <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(Imm)+unsigned(Imm));
end if;
end process;
end behave;
