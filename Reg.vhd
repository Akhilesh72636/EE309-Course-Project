library ieee;
library std;
use ieee.std_logic_1164.all;

entity reg is

port 
( regin :in  std_logic_vector(15 downto 0) ;  -- input of register
  WR_E: in std_logic;                          -- enable input
  reset: in std_logic;                         -- reset input
  clk: in std_logic;                              
  regout: out std_logic_vector(15 downto 0));  -- output of register
 end reg;

architecture alu of reg is

begin

process(clk,reset,WR_E) is
   begin
if (clk'event and clk = '1') then 
 
if(reset='1') then

regout<="0000000000000000"; --- to store '0' initially
end if;
if(WR_E='1') then 

regout<=regin;      --- if enable is 1 then update register

end if;
      end if;
        end process;
end alu;