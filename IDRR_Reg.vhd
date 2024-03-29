library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IDRR_Reg is
	port (
	     clk: in std_logic;
        PCin : IN STD_LOGIC_VECTOR(15 downto 0);     ---------input 
		  WR_E: in std_logic;                          -- enable input
        reset: in std_logic;
		  Iin : IN STD_LOGIC_VECTOR(15 downto 0);
         opcodein: in STD_LOGIC_VECTOR(3 downto 0);
		  	
			aRAin : in STD_LOGIC_VECTOR(2 downto 0);
			aRBin : in STD_LOGIC_VECTOR(2 downto 0); 
			aRCin : in STD_LOGIC_VECTOR(2 downto 0);
			Compbitin :in std_logic;
			SelAluin : in STD_LOGIC_VECTOR(1 downto 0);
		   Immin : in STD_LOGIC_VECTOR(15 downto 0);
			---------------------------------------------------
		  PCout : out STD_LOGIC_VECTOR(15 downto 0); 
		  Iout : out STD_LOGIC_VECTOR(15 downto 0) ; ------------ output
		   opcode: OUT STD_LOGIC_VECTOR(3 downto 0); 
			aRA : OUT STD_LOGIC_VECTOR(2 downto 0);
			aRB : OUT STD_LOGIC_VECTOR(2 downto 0); 
			aRC : OUT STD_LOGIC_VECTOR(2 downto 0);
			Compbit :out std_logic;
			SelAlu : out STD_LOGIC_VECTOR(1 downto 0);
		   Imm : OUT STD_LOGIC_VECTOR(15 downto 0));
end IDRR_Reg;


architecture behave of IDRR_Reg is
  begin 
  
    process(Iin,clk,PCin,reset,WR_E,opcodein,aRAin,aRBin,aRCin, Compbitin,SelAluin, Immin) is
	  variable T1, compvalue,One: STD_LOGIC_VECTOR(15 downto 0);
      begin
		if (clk'event and clk = '1') then
		  
		 if(reset='1') then
               Iout  <="----------------";
               PCout <="----------------"  ;
					opcode<="----";
			      aRA    <="---";
			      aRB    <="---";
			      aRC    <="---";
			      Compbit<='-';
			      SelAlu <="--";
		         Imm    <="----------------";
       end if; 
		 
		 if(WR_E='1') then 
               Iout <=Iin; 
               PCout<=PCin;
               opcode<=opcodein;
			      aRA    <=aRAin;
			      aRB    <=aRBin;
			      aRC    <=aRcin;
			      Compbit<=Compbitin;
			      SelAlu <= SelAluin;
		         Imm    <=Immin;
       end if;
  
		  
			 end if;
		end process;
end behave;