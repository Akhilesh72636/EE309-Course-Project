library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCincrementer is
	port (
	     clk: in std_logic;
		  PC, Imm: IN STD_LOGIC_VECTOR(15 downto 0);
		  --------------------------------------------------
		  PCout : OUT STD_LOGIC_VECTOR(15 downto 0)
		   );
end PCincrementer;


architecture behave of PCincrementer is
begin
 
  process(PC, Imm)
  
 variable T1: STD_LOGIC_VECTOR(15 downto 0);
  
  
 begin
 
 T1:="0000000000000001";
if (clk'event and clk = '1') then
	PCout <= STD_LOGIC_VECTOR(unsigned(PC) +unsigned(T1));
end if;
end process;
end behave;
