library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RREX_Reg is
	port (
	     clk: in std_logic;
        PCin : IN STD_LOGIC_VECTOR(15 downto 0);     ---------input 
		  WR_E: in std_logic;                          -- enable input
        reset: in std_logic;
		  Iin : IN STD_LOGIC_VECTOR(15 downto 0);
         opcodein: in STD_LOGIC_VECTOR(3 downto 0); 
			RAin : in STD_LOGIC_VECTOR(15 downto 0);   -------------------16 bit data 
			RBin : in STD_LOGIC_VECTOR(15 downto 0); 
			Compbitin :in std_logic;
			SelAluin : in STD_LOGIC_VECTOR(1 downto 0);
		   Immin : in STD_LOGIC_VECTOR(15 downto 0);
			aRBin : in STD_LOGIC_VECTOR(2 downto 0);
			aRCin : in STD_LOGIC_VECTOR(2 downto 0);
			---------------------------------------------------
		   PCout : out STD_LOGIC_VECTOR(15 downto 0); 
		   Iout : out STD_LOGIC_VECTOR(15 downto 0) ; ------------ output
		   opcode: OUT STD_LOGIC_VECTOR(3 downto 0); 
			RA : OUT STD_LOGIC_VECTOR(15 downto 0);
			RB : OUT STD_LOGIC_VECTOR(15 downto 0); 
			RC : OUT STD_LOGIC_VECTOR(15 downto 0);
			Compbit :out std_logic;
			aRBout : out STD_LOGIC_VECTOR(2 downto 0);
			aRCout : out STD_LOGIC_VECTOR(2 downto 0);
			SelAlu : out STD_LOGIC_VECTOR(1 downto 0);
		   Imm : OUT STD_LOGIC_VECTOR(15 downto 0));
end RREX_Reg;


architecture behave of RREX_Reg is
  begin 
  
    process(Iin,clk,PCin,reset,WR_E,opcodein,RAin,RBin, Compbitin,SelAluin, Immin,aRBin,aRCin ) is
	  variable T1, compvalue,One: STD_LOGIC_VECTOR(15 downto 0);
      begin
		if (clk'event and clk = '1') then
		  
		 if(reset='1') then
               Iout  <="----------------";
               PCout <="----------------"  ;
					opcode<="----";
			      RA    <="----------------";
			      RB    <="----------------";
			      Compbit<='-';
			      SelAlu <="--";
		         Imm    <="----------------";
					aRCout <="---";
					aRBout <="---";
       end if; 
		 
		 if(WR_E='1') then 
               Iout <=Iin; 
               PCout<=PCin;
               opcode<=opcodein;
			      RA    <=RAin;
			      RB    <=RBin;
			      Compbit<=Compbitin;
			      SelAlu <= SelAluin;
		         Imm    <=Immin;
					aRBout <=aRBin;
					aRCout <=aRCin;
       end if;
  
		  
			 end if;
		end process;
end behave;