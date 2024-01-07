library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hazard_detector is
	port (
	     clk: in std_logic;

		   
		  I_RR_EX: IN STD_LOGIC_VECTOR(15 downto 0); 
		  I_EX_MM : IN STD_LOGIC_VECTOR(15 downto 0); 
		  I_MM_WB : IN STD_LOGIC_VECTOR(15 downto 0);
		  Z,C,equal ,less: in std_logic;                     
        
		  PC_WE: out std_logic;
		  IFID_WE,flush: out std_logic;
		  IDRR_WE: out std_logic;
		  RAselect: out STD_LOGIC_VECTOR(1 downto 0);
		  RBselect: out STD_LOGIC_VECTOR(1 downto 0)
			---------------------------------------------------
		 );
		   
end entity;


architecture behave of hazard_detector is


component regstuff is

port 
( regin :in  std_logic_vector(15 downto 0) ; 
  clk: in std_logic;                              
  regout: out std_logic_vector(15 downto 0));
 end  component;

 
 signal T12 : STD_LOGIC_VECTOR(2 downto 0);

 
  begin 
  
  
  process(I_RR_EX,I_EX_MM ,I_MM_WB,clk,less,equal,Z,C) is
	  variable T1,T2, compvalue,One: STD_LOGIC_VECTOR(15 downto 0);
      begin
		if (clk'event and clk = '1') then
	     RAselect<="00";
		  RBselect<="00";
		  
                     PC_WE<='1';
							IFID_WE<='1';
							IDRR_WE<='1';
							
		  
		  
		  

		  
		 if (I_RR_EX(15 DOWNTO 12)="0001" OR I_RR_EX(15 DOWNTO 12)="0000" OR I_RR_EX(15 DOWNTO 12)="0010" OR 
		    I_RR_EX(15 DOWNTO 12)="0011"  OR I_RR_EX(15 DOWNTO 12)="1101" OR
			 I_RR_EX(15 DOWNTO 12)="1100") THEN
			 
			            IF (I_RR_EX(8 DOWNTO 6) =  I_EX_MM(11 DOWNTO 9)) THEN 
							     RAselect<="01";
						   end if;
							 IF (I_RR_EX(8 DOWNTO 6) = I_MM_WB(11 DOWNTO 9)) THEN      -----simple data dependancy
							     RAselect<="10";
						   end if;
		end if;					
		    
			 
	    if (I_RR_EX(15 DOWNTO 12)="0001" OR I_RR_EX(15 DOWNTO 12)="0010" ) THEN
			 
			            IF (I_RR_EX(5 DOWNTO 3) =  I_EX_MM(11 DOWNTO 9)) THEN 
							     RBselect<="01";  
						   end if;
							 IF (I_RR_EX(5 DOWNTO 3) = I_MM_WB(11 DOWNTO 9)) THEN 
							     RBselect<="10";                                       -----simple data dependancy
						   end if;             
		end if;
		
		 ------------------------------------------------------------------------------------------------------  
			 
	    if ( I_RR_EX(15 DOWNTO 12)="0100") THEN
			 
			            IF (T12="001") THEN 
							RAselect<="10";
							
		               T12<="001";  
						   end if;
							
							IF (I_RR_EX(5 DOWNTO 3) =  I_EX_MM(11 DOWNTO 9)) THEN 
							PC_WE<='0';
							IFID_WE<='0';
							IDRR_WE<='0';
							
		               T12<="001";  
						   end if;
							
							 IF (I_RR_EX(5 DOWNTO 3) = I_MM_WB(11 DOWNTO 9)) THEN 
							    RAselect<="10";                               ---------OR I_RR_EX(15 DOWNTO 12)="0100"
					      end if;             
		end if;	 
      
		
		------------------------------------------------------------------------------------
		--------------------------------------------------------------------------for beq
		
		--if(I_RR_EX(15 DOWNTO 12)="1000")then or I_RR_EX(15 DOWNTO 12)="1001"or I_RR_EX(15 DOWNTO 12)= "1010") then 
		----I_RR_EX(15 DOWNTO 12)= "1100"or I_RR_EX(15 DOWNTO 12)= "1111"or I_RR_EX(15 DOWNTO 12)= "1101" )  then 
		 
		if(I_RR_EX(15 DOWNTO 12)="1000")then
		      if (equal='1') then flush<='0';else  flush<='1';  end if;
	    end if;	
		if(I_RR_EX(15 DOWNTO 12)="1001")then
		      if (less='1') then flush<='0'; else  flush<='1';end if;
	    end if;
		
		if(I_RR_EX(15 DOWNTO 12)="1010")then
		      if (equal='1'and less='1' ) then flush<='0';else  flush<='1'; end if;
	    end if;
		
		
		
		
		
		
		
		
		
		
		
	   end if;
		end process;
end behave;