library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder is
	port (clk : in std_logic;
       	Iin : IN STD_LOGIC_VECTOR(15 downto 0);
			SelAlu : out STD_LOGIC_VECTOR(1 downto 0);
			---------input 
		  --------------------------------------------------------------------------
		   opcode: OUT STD_LOGIC_VECTOR(3 downto 0); 
			RA : OUT STD_LOGIC_VECTOR(2 downto 0);
			RB : OUT STD_LOGIC_VECTOR(2 downto 0); 
			RC : OUT STD_LOGIC_VECTOR(2 downto 0);
			Compbit :out std_logic;
		   Imm : OUT STD_LOGIC_VECTOR(15 downto 0) 	
		   );
end Decoder;


architecture behave of Decoder is
  begin
  
      process(Iin,clk) 
		
	   variable T1, compvalue: STD_LOGIC_VECTOR(15 downto 0);
		
      begin
		if (clk'event and clk = '1') then
		opcode<=Iin(15 downto 12) ;
		
----------------------------------------------------------------------------------------------------------------------- 
		if Iin(15 downto 12) = ("0001" or "0010" ) then----------------ADD AND NAND 
		
		SelAlu <=Iin(1 downto 0) ; 
	   Compbit<= Iin(2);    
		RC <=Iin(11 downto 9) ;    ------A
		RA <=Iin(8 downto 6) ;     ------B
		RB <=Iin(5 downto 3) ;     ------C
      Imm <= "0000000000000000";
		END IF;
---------------------------------------------------------------------------------------------------------------------		
		if Iin(15 downto 12) = ("0000" or "1000" or "1001" or "1010" or "0101"or "0100" OR  "1101" ) then  ----- 6 bit immidiate case
		
		RC <=Iin(11 downto 9) ;    ------A
		RB <=Iin(8 downto 6) ;     ------B
      Imm(5 downto 0) <=Iin(5 downto 0);
		Imm(15 downto 6) <= "0000000000";
			
		end if;
		
----------------------------------------------------------------------------------------------------------------
		if Iin(15 downto 12) = ("1100" or "1111" or "0111" or "0011" or "0110" ) then    ----- 9 bit immidiate case
		
		RC <=Iin(11 downto 9) ;     ------A
      
		Imm(8 downto 0) <=Iin(8 downto 0);
		Imm(15 downto 9) <= "0000000";
	   	
		end if;
-------------------------------------------------------------------------------------------------------------------		
		end if;
end process ;

end behave;