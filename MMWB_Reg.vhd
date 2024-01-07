library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MMWB_Reg is
	port (
	     clk: in std_logic;
        PCin : IN STD_LOGIC_VECTOR(15 downto 0);     ---------input 
		  WR_E: in std_logic;                          -- enable input
         reset: in std_logic;
		   Iin : IN STD_LOGIC_VECTOR(15 downto 0);
         opcodein: in STD_LOGIC_VECTOR(3 downto 0); 
			MMoutin : IN STD_LOGIC_VECTOR(15 downto 0);
			
		   aluCin : in STD_LOGIC_VECTOR(15 downto 0);
			tellin:in std_logic;
			tellout:in std_logic;
		   Immin : in STD_LOGIC_VECTOR(15 downto 0);
			aRCin : in STD_LOGIC_VECTOR(2 downto 0);
			---------------------------------------------------
		   PCout : out STD_LOGIC_VECTOR(15 downto 0); 
		   Iout : out STD_LOGIC_VECTOR(15 downto 0) ; ------------ output
		   opcode: OUT STD_LOGIC_VECTOR(3 downto 0); 
			aluCout : out STD_LOGIC_VECTOR(15 downto 0);
			
			aRCout : out STD_LOGIC_VECTOR(2 downto 0);
		   MMoutout : out STD_LOGIC_VECTOR(15 downto 0);------for load 
		   Imm : OUT STD_LOGIC_VECTOR(15 downto 0));
end MMWB_Reg;


architecture behave of MMWB_Reg is
  begin 
  
    process(Iin,clk,PCin,reset,WR_E,opcodein,aluCin ,Immin,aRCin ,MMoutin,tellin) is
	  variable T1, compvalue,One: STD_LOGIC_VECTOR(15 downto 0);
      begin
		if (clk'event and clk = '1') then
		  
		 if(reset='1') then
               Iout  <="----------------";
               PCout <="----------------"  ;
					opcode<="----";
			      aluCout<="----------------"; 
		         Imm    <="----------------";
					aRCout<="---";
					MMoutout <="----------------";
					tellout<='0';
       end if; 
		 
		 if(WR_E='1') then 
               Iout <=Iin; 
               PCout<=PCin;
               opcode<=opcodein;
			     aluCout<=aluCin;
			     MMoutout <= MMoutin;
		         Imm    <=Immin;
					aRCout <=aRCin;
					tellout<=tellin;
       end if;
  
		  
			 end if;
		end process;
end behave;