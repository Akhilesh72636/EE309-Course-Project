library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RISC_Controller is	port (
	     clk: in std_logic;
		  
		 reset:in std_logic
		   );
end RISC_Controller;


architecture behave of RISC_Controller is

----------------------------------------------------------------------------------------
component reg is

port 
( regin :in  std_logic_vector(15 downto 0) ;  -- input of register
  WR_E: in std_logic;                          -- enable input
  reset: in std_logic;                         -- reset input
  clk: in std_logic;                              
  regout: out std_logic_vector(15 downto 0));  -- output of register
 end component;
 -------------------------------------------------------------------------------------
 component registers_file is 
    port(
        
        A1 : in std_logic_vector(2 downto 0); -- to store register adress 
        A2 : in std_logic_vector(2 downto 0); -- to store register adress 
        A3 : in std_logic_vector(2 downto 0); -- to store register adress
        -- input data
		  R0in : in std_logic_vector(15 downto 0);
		  WR_ER0: in std_logic;
        Din : in std_logic_vector(15 downto 0);-- input data to store in register
        WR_E : in std_logic; -- write enable
        reset : in std_logic; -- reset input
        clk : in std_logic; --clock
        --output data
        D1 : out std_logic_vector(15 downto 0); -- data output 1
        D2 : out std_logic_vector(15 downto 0); -- data output 2
        R0_PC : out std_logic_vector(15 downto 0)  -- value of R7 as pc

    );
end component;
---------------------------------------------------------------------------------------------
component instruction_memory is 
	port(
		 mem_a   : in std_logic_vector(15 downto 0);
		 mem_out : out std_logic_vector(15 DOWNTO 0)); -- output
end component;
---------------------------------------------------------------------------------------------
component ALU is
	port ( 
       	opcode : IN STD_LOGIC_VECTOR(3 downto 0);     ---------input 
		   c_in, z_in: IN STD_LOGIC;
			sel: IN STD_LOGIC_VECTOR(1 downto 0); 
		   ALUa, ALUb : IN STD_LOGIC_VECTOR(15 downto 0);
			clk: in std_logic;
			---------------------------------------------------
		   ComBit : IN STD_LOGIC_VECTOR(0 downto 0);
		   ALUc: OUT STD_LOGIC_VECTOR(15 downto 0);       ------------ output
		   c_out,equal,less, z_out,tell: OUT STD_LOGIC);
			 end component;
------------------------------------------------------------------------------------------------
component PCincrementer is
	port (
	     clk: in std_logic;
		  PC, Imm: IN STD_LOGIC_VECTOR(15 downto 0);
		  PCout : OUT STD_LOGIC_VECTOR(15 downto 0)
		   );
end component;
----------------------------------------------------------------------------------------------------
component ALU2forImm is
	port (
	     clk: in std_logic;
		  
		  PC, Imm: IN STD_LOGIC_VECTOR(15 downto 0);
		  --------------------------------------------------
		  PCout : OUT STD_LOGIC_VECTOR(15 downto 0)
		   );
end component;
------------------------------------------------------------------------------------------------------
component Decoder is
	port (clk : in std_logic;
       	Iin : IN STD_LOGIC_VECTOR(15 downto 0);
			SelAlu : out STD_LOGIC_VECTOR(1 downto 0);
		   opcode: OUT STD_LOGIC_VECTOR(3 downto 0); 
			RA : OUT STD_LOGIC_VECTOR(2 downto 0);
			RB : OUT STD_LOGIC_VECTOR(2 downto 0); 
			RC : OUT STD_LOGIC_VECTOR(2 downto 0);
			Compbit :out std_logic;
		   Imm : OUT STD_LOGIC_VECTOR(15 downto 0) 	
		   );
end component;
---------------------------------------------------------------------------------------------------------
component IFIDReg is
	port (
	     clk: in std_logic;
        PCin : IN STD_LOGIC_VECTOR(15 downto 0);     ---------input 
		  WR_E: in std_logic;                          -- enable input
        reset: in std_logic;
		  Iin : IN STD_LOGIC_VECTOR(15 downto 0); 
		  PCout : out STD_LOGIC_VECTOR(15 downto 0); 
		  Iout : out STD_LOGIC_VECTOR(15 downto 0)) ; ------------ output
		   
end component;
--------------------------------------------------------------------------------------------------------
component IDRR_Reg is
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
		  PCout : out STD_LOGIC_VECTOR(15 downto 0); 
		  Iout : out STD_LOGIC_VECTOR(15 downto 0) ; ------------ output
		   opcode: OUT STD_LOGIC_VECTOR(3 downto 0); 
			aRA : OUT STD_LOGIC_VECTOR(2 downto 0);
			aRB : OUT STD_LOGIC_VECTOR(2 downto 0); 
			aRC : OUT STD_LOGIC_VECTOR(2 downto 0);
			Compbit :out std_logic;
			SelAlu : out STD_LOGIC_VECTOR(1 downto 0);
		   Imm : OUT STD_LOGIC_VECTOR(15 downto 0));
end component;
-------------------------------------------------------------------------------------------------------
component RREX_Reg is
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
end component;
----------------------------------------------------------------------------------------------------------
component EXMM_Reg is
	port (
	     clk: in std_logic;
        PCin : IN STD_LOGIC_VECTOR(15 downto 0);     ---------input 
		  WR_E: in std_logic;                          -- enable input
        reset: in std_logic;
		  Iin : IN STD_LOGIC_VECTOR(15 downto 0);
         opcodein: in STD_LOGIC_VECTOR(3 downto 0); 
			tellin:in std_logic;
			tellout:in std_logic;
			aluCin : in STD_LOGIC_VECTOR(15 downto 0);
			
		   Immin : in STD_LOGIC_VECTOR(15 downto 0);
			aRAin : in STD_LOGIC_VECTOR(2 downto 0);
		  PCout : out STD_LOGIC_VECTOR(15 downto 0); 
		  Iout : out STD_LOGIC_VECTOR(15 downto 0) ; ------------ output
		   opcode: OUT STD_LOGIC_VECTOR(3 downto 0); 
			aluCout : out STD_LOGIC_VECTOR(15 downto 0);
			aRAout : out STD_LOGIC_VECTOR(2 downto 0);
		   Imm : OUT STD_LOGIC_VECTOR(15 downto 0));
end component;
--------------------------------------------------------------------------------------------------------------
component MMWB_Reg is
	port (
	     clk: in std_logic;
        PCin : IN STD_LOGIC_VECTOR(15 downto 0);     ---------input 
		  WR_E: in std_logic;                          -- enable input
         reset: in std_logic;
		   Iin : IN STD_LOGIC_VECTOR(15 downto 0);
         opcodein: in STD_LOGIC_VECTOR(3 downto 0); 
			MMoutin : IN STD_LOGIC_VECTOR(15 downto 0);
			tellin:in std_logic;
			tellout:in std_logic;
		   aluCin : in STD_LOGIC_VECTOR(15 downto 0);
			
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
end  component;
---------------------------------------------------------------------------------------------------------------
component ALUBMUX is

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

 end component;
 ----------------------------------------------------------------------------------------------------------------
 component PCIMMadd is
	port (opcode3: IN STD_LOGIC_VECTOR(3 downto 0);
	       RA:in STD_LOGIC_VECTOR(15 downto 0);
		  RB:in STD_LOGIC_VECTOR(15 downto 0);
	     clk: in std_logic;
		  PC, Imm: IN STD_LOGIC_VECTOR(15 downto 0);
		  --------------------------------------------------
		  PCout : OUT STD_LOGIC_VECTOR(15 downto 0)
		   );
end component ;
-----------------------------------------------------------------------------------------------------------------
component data_memory is                                                                       --data memory
	port(
		 mem_d   : in std_logic_vector(15 DOWNTO 0);
		 mem_a   : in std_logic_vector(15 downto 0);
		 rd_bar  : in std_logic; -- read enable.
		 wr_bar  : in std_logic; -- write enable
		 reset : in std_logic; -- clear.
		 clk : in std_logic; -- clock.
		 mem_out : out std_logic_vector(15 DOWNTO 0)); -- output
		 
end component;


------------------------------------------------------------------------------------------------------------
component mux4to1 is
port(three,two,one,zero:in std_logic_vector(15 downto 0);
     output:out std_logic_vector(15 downto 0); 
     sel:in std_logic_vector(1 downto 0));
end component;

------------------------------------------------------------------------------------------------------------
component  hazard_detector is
	port (
	     clk: in std_logic;

		   
		  I_RR_EX: IN STD_LOGIC_VECTOR(15 downto 0); 
		  I_EX_MM : IN STD_LOGIC_VECTOR(15 downto 0); 
		  I_MM_WB : IN STD_LOGIC_VECTOR(15 downto 0);
		  Z,C,equal ,less: in std_logic;                    
       
		  PC_WE,flush: out std_logic;
		  IFID_WE: out std_logic;
		  IDRR_WE: out std_logic;
		  RAselect: out STD_LOGIC_VECTOR(1 downto 0);
		  RBselect: out STD_LOGIC_VECTOR(1 downto 0)
			---------------------------------------------------
		 );
		   
end component;
-------------------------------------------------------------------------------------------------------------
---------------------------------      END COMPONENTS      -------------------------------------------------
------------------------------------------------------------------------------------------------------------
----------------------------------------SIGNALS-------------------------------------------------------------

signal PCin: std_logic_vector(15 downto 0);
signal PCreset: std_logic; 
signal PCRout: std_logic_vector(15 downto 0);
signal PCWR_E: std_logic;

signal WR_E1: std_logic;
signal reset1: std_logic;
signal Iin1: std_logic_vector(15 downto 0);
signal PCout1: std_logic_vector(15 downto 0);
signal Iout1: std_logic_vector(15 downto 0);

signal PCincrin: std_logic_vector(15 downto 0);
signal PCincrout: std_logic_vector(15 downto 0);
signal PCincrIMM: std_logic_vector(15 downto 0);

signal SelAlu1: std_logic_vector(1 downto 0);
signal opcode1: std_logic_vector(3 downto 0);
signal RA1: std_logic_vector(2 downto 0);
signal RB1: std_logic_vector(2 downto 0);
signal RC1: std_logic_vector(2 downto 0);
signal Compbit1: std_logic;
signal IMM1: std_logic_vector(15 downto 0);

signal WR_E2,tel: std_logic;
signal opcode2: std_logic_vector(3 downto 0);
signal SelAlu2: std_logic_vector(1 downto 0);
signal PCout2: std_logic_vector(15 downto 0);
signal Iout2: std_logic_vector(15 downto 0);
signal aRA2: std_logic_vector(2 downto 0);
signal aRB2: std_logic_vector(2 downto 0);
signal aRC2: std_logic_vector(2 downto 0);
signal reset2,Compbit2: std_logic;
signal IMM2: std_logic_vector(15 downto 0);

signal WBlocation : std_logic_vector(2 downto 0);
signal PCout5 : std_logic_vector(15 downto 0);
signal WR_ER05 : std_logic;
signal Din_R_file : std_logic_vector(15 downto 0);
signal WR_E_R_file: std_logic;
signal reset_R_file: std_logic;
signal Dout1: std_logic_vector(15 downto 0);
signal Dout2: std_logic_vector(15 downto 0);
signal R0PC : std_logic_vector(15 downto 0);


signal WR_E3: std_logic;
signal opcode3: std_logic_vector(3 downto 0);
signal SelAlu3: std_logic_vector(1 downto 0);
signal PCout3: std_logic_vector(15 downto 0);
signal Iout3: std_logic_vector(15 downto 0);
signal aRB3: std_logic_vector(2 downto 0);
signal aRC3: std_logic_vector(2 downto 0);
signal reset3,Compbit3: std_logic;
signal IMM3: std_logic_vector(15 downto 0);
signal RA3: std_logic_vector(15 downto 0);
signal RB3: std_logic_vector(15 downto 0);


signal WR_E4,equal4,less4: std_logic;
signal opcode4: std_logic_vector(3 downto 0);
signal PCout4: std_logic_vector(15 downto 0);
signal Iout4: std_logic_vector(15 downto 0);

signal aRC4: std_logic_vector(2 downto 0);
signal reset4: std_logic;
signal IMM4: std_logic_vector(15 downto 0);
signal RA4: std_logic_vector(15 downto 0);--not need
signal RB4: std_logic_vector(15 downto 0);--not need
signal aluC: std_logic_vector(15 downto 0);
signal aluCout4: std_logic_vector(15 downto 0);

signal alu_mux_E,C,Z: std_logic;
signal aluB: std_logic_vector(15 downto 0);
signal alu_mux_reset : std_logic;

signal PC_MM: std_logic_vector(15 downto 0);

signal WR_E5,tell: std_logic;
signal opcode5: std_logic_vector(3 downto 0);
signal Iout5: std_logic_vector(15 downto 0);
signal aRC5: std_logic_vector(2 downto 0);
signal reset5: std_logic;
signal IMM5: std_logic_vector(15 downto 0);
signal MMout5: std_logic_vector(15 downto 0);

signal MMoutin: std_logic_vector(15 downto 0);
signal aluCout5 : std_logic_vector(15 downto 0);

signal Mdatain : std_logic_vector(15 downto 0);
signal Madrin: std_logic_vector(15 downto 0);
signal RE_MD,flushit: std_logic;
signal WE_MD: std_logic;
signal reset_MD : std_logic;

signal muxaluAout : std_logic_vector(15 downto 0);
signal muxA4in : std_logic_vector(15 downto 0);

signal  muxaluAsel : std_logic_vector(1 downto 0);
signal DH_PC_WE : std_logic;
 signal DH_IFID_WE : std_logic;
 signal  DH_IDRR_WE,tell4,tell5 : std_logic;
signal RBsel : std_logic_vector(1 downto 0);          
 signal Q1 : std_logic;


begin
Q1<='1';
-----------------------------
-------------Instruction fech 
-----------------------------
---variable Q1:in std_logic;

PC: reg 
    port map( 
	  regin=> PCin,  
     WR_E=> PCWR_E,                        
     reset=> PCreset,                       
     clk => clk,                           
     regout=>PCRout --pc to IFID 
	  );
PCreset<='1'	;  
PCWR_E<=('1' and DH_PC_WE); 

PCin<=PCincrout when ((opcode3 = "1000" and equal4='1')or (opcode3 = "1001" and  less4='1')
 or (opcode3 = "1010" and equal4='1'  and less4='1' )or opcode3 = "1100"or opcode3 = "1101"
 or opcode3 = "1000") else PCincrout ;
 
 
 
IM: instruction_memory
	port map (
		 mem_a =>PCRout
		, mem_out=>Iin1); -- output


 
PCincr :PCincrementer 
	     port map  (
	     clk=> clk,
		  PC=> PCincrin, 
		  Imm =>PCincrIMM,
		  PCout =>PCincrout
		   );
-----------------------------
-----------Instruction Decode 
-----------------------------	
 
IFID :IFIDReg
	     port map (
	     clk => clk,
        PCin=>PCRout,--pc to IFID 
		  WR_E=> WR_E1,
        reset =>reset1,
		  Iin =>Iin1,
		  PCout=> PCout1,
		  Iout=>Iout1 ) ;
		  
 reset1<=('1' and flushit);		  
 WR_E1<=('1' and DH_IFID_WE);
		  
----process ( clk,PCRout,Iin1) is		  
---begin
PCin<= PCincrout;--- or alu c    		  
		 	  
Decoder1 :Decoder 
	      port map(clk=> clk,
       	Iin =>Iin1,
			SelAlu=>SelAlu1,
		   opcode=>opcode1,
			RA=>RA1, 
			RB=>RB1,
			RC=>RC1,
			Compbit=>Compbit1,
		   Imm=>IMM1
		   );
		  

-----------------------------
----------------register Read 
-----------------------------
		
IDRR:   IDRR_Reg
	     port map(
	     clk => clk,
        PCin => PCout1, 
		  WR_E =>WR_E2,
		  reset=> reset2,
		  Iin  =>Iout1,
        opcodein =>opcode1,
		  aRAin  =>RA1,
		  aRBin  =>RB1,
		  aRCin  =>RC1,
		  Compbitin =>Compbit1,
		  SelAluin  =>SelAlu1,
		  Immin  =>IMM1,
		  PCout  => PCout2, 
		  Iout   =>Iout2,
		  opcode => opcode2,
		  aRA  =>aRA2,
		  aRB  =>aRB2,
		  aRC  =>aRC2,
		  Compbit =>Compbit2,
		  SelAlu =>SelAlu2,
		  Imm =>IMM2
		  );
reset<=('1' and flushit);	
		  
 WR_E2<=('1' and DH_IDRR_WE);
		  

R_file: registers_file 
        port map(
 
        A1 =>aRA2,
        A2 =>aRB2,
        A3=>WBlocation,
		  R0in =>PCout5,----- pcout 5
		  WR_ER0=>WR_ER05,----------- wrER0
        Din=>Din_R_file,
        WR_E =>WR_E_R_file,
        reset=>reset_R_file,
        clk =>clk,
        D1=>Dout1,
        D2 =>Dout2,
        R0_PC=>R0PC
		  );
WR_E_R_file<=(not(tell) and '1');
reset_R_file <=('1' and flushit);		  
		  
-----------------------------
--------------------Exicution
-----------------------------

RREX: RREX_Reg 
	      port map (
	      clk =>clk,
         PCin =>PCout2,
		   WR_E =>WR_E3,                
         reset =>reset3,
		   Iin =>Iout2,
         opcodein =>opcode2,
			RAin =>Dout1, 
			RBin =>Dout2,
			Compbitin =>Compbit2,
			SelAluin =>SelAlu2,
		   Immin =>IMM2,
			aRBin =>aRB2,
		   aRCin =>aRC2,	
		   Iout  =>Iout3,
			PCout  =>PCout3,
		   opcode =>opcode3,
			RA  =>RA3,
			RB  =>RB3,
			Compbit  =>Compbit3,
			aRBout =>aRB3,
			aRCout =>aRC3,
			SelAlu =>SelAlu3,
		   Imm  =>IMM3
          );

			 
B_Mux: ALUBMUX 
   port map(
	aluC5=>aluCout4,
	aluC4=>aluCout5,
	RBin=>RB3,
  opcode3=>opcode3,
  IMMin=>IMM3,
  PC3=>PCout3,
  mux_E=>alu_mux_E,                       -- enable input
  reset=>alu_mux_reset,
  clk=>clk,                            
  AluB=>Alub,
  RaB=>RBsel
  );
  
muxaluA : mux4to1 
port map (three=>muxA4in ,
           two=>aluCout5,
           one=>aluCout4,
           zero=>RA3,
           output=>muxaluAout,
             sel=>muxaluAsel
	         );


 
Aluinstance : ALU 
	port map (tell=>tell, 
       	opcode=>opcode3, 
		   c_in=>C,
			z_in=>Z,
			sel=>SelAlu3,
		   ALUa=>muxaluAout,
			ALUb =>Alub,
			clk=>clk,
		   ComBit(0) =>Compbit3,
		   ALUc=>aluC,   
		   c_out=>C,
			z_out=>Z
			,equal=>equal4, less=>less4,tell=>tel
			);			 


PC_MMadd: PCIMMadd 
	port map (
	    opcode3=>opcode3,
		 RA=>RA3,
		  RB=>RB3,
	      clk=> clk,
		  PC=>PCout3,
		  Imm=>IMM3,
		  PCout=>PC_MM
		   );


			
EXMM: EXMM_Reg 
	     port map (
	     clk=>clk,
        PCin =>PCout3,
		  WR_E=>WR_E4,
        reset=>reset4,
		  Iin=>Iout3,
         opcodein=>opcode3,
			aluCin=>aluC,
		   Immin=>IMM2,
			aRAin=>aRC3,
			tellin=>tell,
			tellout=>tell4,
		   PCout=>PCout4,
		   Iout=>Iout4,
		   opcode=>opcode4,
			aluCout=>aluCout4,
			aRAout=>aRC4, -------------destination
		   Imm =>IMM4
			);
			
Dmemory : data_memory
	port map(
		 mem_d =>Mdatain,
		 mem_a =>Madrin,
		 rd_bar =>RE_MD,
		 wr_bar =>WE_MD,
		 reset =>reset_MD,
		 clk =>clk,
		 mem_out =>MMoutin
		 );

Madrin <= aluCout4 when (opcode4 = "1111" or opcode4 ="0100" )	;	
--RE_MD <= "1"	when (opcode4 = "1111" or opcode4 ="0100" )	;		
Mdatain <= aluCout4 when (opcode4 = "0101")	;
--RE_MD <= "1"	when (opcode4 = "1111" or opcode4 ="0100" )	;

	
MMWB: MMWB_Reg
	port map(
	      clk=>clk,
         PCin=>PCout4, 
		   WR_E=>WR_E5,
         reset=>reset5,
		   Iin =>Iout4,
         opcodein=>opcode4,
			MMoutin=>MMoutin,
		   aluCin=>aluCout4,
		   Immin=>IMM3,
			aRCin=>aRC4,
			tellin=>tell4,
			tellout=>tell5,
		   PCout=>PCout5,
		   Iout=>Iout5,
		   opcode=>opcode5, 
			aluCout=>aluCout5,
			aRCout=>aRC5,
		   MMoutout=>MMout5,
		   Imm=>Imm5
			);
datahaz:hazard_detector 
	port map (
	     Z=>z
		  ,flush=>flushit
		  ,C=>c
		  ,equal =>equal4
		  ,less=>less4
	     ,clk=>clk,
		  I_RR_EX=>Iout3,
		  I_EX_MM=>Iout4,
		  I_MM_WB=>Iout5,
		  PC_WE=>DH_PC_WE,
		  IFID_WE=>DH_IFID_WE,
		  IDRR_WE=> DH_IDRR_WE,
		  RAselect=>muxaluAsel,
		  RBselect=>RBsel
			---------------------------------------------------
		 );
		   
		 



	

end behave;