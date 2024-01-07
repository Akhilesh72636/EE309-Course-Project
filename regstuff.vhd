library ieee;
library std;
use ieee.std_logic_1164.all;

entity regstuff is

port 
( regin :in  std_logic_vector(15 downto 0) ; 
  clk: in std_logic;                              
  regout: out std_logic_vector(15 downto 0));
 end regstuff;

architecture alu of regstuff is

begin

process(clk,regin) is
   begin
if (clk'event and clk = '1') then 



regout<=regin;      --- if enable is 1 then update register


      end if;
        end process;
end alu;