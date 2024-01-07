library ieee;
library std;
use ieee.std_logic_1164.all;

entity ALUBMUX is

port 
( aluC5:in  std_logic_vector(15 downto 0) ;
  aluC4 :in  std_logic_vector(15 downto 0) ;
  RBin :in  std_logic_vector(15 downto 0) ;
  opcode3:in  std_logic_vector(3 downto 0) ;
  IMMin:in  std_logic_vector(15 downto 0) ;
  PC3:in  std_logic_vector(15 downto 0) ;
  mux_E: in std_logic;                          -- enable input
  reset: in std_logic;                         -- reset input
  clk: in std_logic;                              
  AluB: out std_logic_vector(15 downto 0);
  RaB:in  std_logic_vector(1 downto 0) 
  
  );  -- output of register
 end ALUBMUX;

architecture alu of ALUBMUX is

begin

process(clk,reset,RBin,IMMin,PC3,mux_E,opcode3,aluC4,aluC5,RaB) is
   begin
if (clk'event and clk = '1') then 
 
if(reset='1') then

AluB<="0000000000000000"; --- to store '0' initially
end if;

if(mux_E='1') then

if (RaB="01") then 
AluB<= aluC4;
 end if;

 if (RaB="10") then 
AluB<= aluC5;
 end if;

if(opcode3 ="0010" or opcode3 = "0001" ) then
 AluB<= RBin;
 end if;

if(opcode3="0000" or opcode3="0101" ) then
 AluB<= IMMin;
 end if;
 
if(opcode3= "1101" or opcode3="1111" ) then
 AluB<= PC3;
 end if;

     end if;
      end if;
        end process;
end alu;