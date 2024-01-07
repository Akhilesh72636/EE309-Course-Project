--Local Register File
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Local_Register_File is
	port (RF_In : in std_logic_vector(15 downto 0);
		clk, wr, pc_wr : in std_logic;
		S_In, S_Out_A, S_Out_B : in std_logic_vector(2 downto 0);
		RF_Out_A, RF_Out_B : out std_logic_vector(15 downto 0) );
end entity Local_Register_File;

architecture Struct of Local_Register_File is

	component Demux_1to8_16bit  is
		port (I: in std_logic_vector(15 downto 0); S: in std_logic_vector(2 downto 0); Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7: out std_logic_vector(15 downto 0));
	end component Demux_1to8_16bit;
	
	component Mux_8to1_16bit  is
		port (I0, I1, I2, I3, I4, I5, I6, I7: in std_logic_vector(15 downto 0); S: in std_logic_vector(2 downto 0); Y: out std_logic_VECTOR(15 downto 0));
	end component Mux_8to1_16bit;
	
	component Register_16_bit  is
		port (d: in std_logic_vector(15 downto 0); clk, wr: in std_logic;
			q: out std_logic_vector(15 downto 0) );
	end component Register_16_bit;

	signal d0, d1, d2, d3, d4, d5, d6, d7 : std_logic_vector(15 downto 0);
	signal q0, q1, q2, q3, q4, q5, q6, q7: std_logic_vector(15 downto 0);
	
	begin
	
		--from RF_In
		
		Demux_In: Demux_1to8_16bit port map (I => RF_In, S => S_In, Y0 => d0, Y1 => d1, Y2 => d2, Y3 => d3, Y4 => d4, Y5 => d5, Y6 => d6, Y7 => d7);
	
		
	
		--group of registers
		R0: Register_16_bit port map(d => d0, clk => clk, wr => wr and (not S_In(2) and (not S_In(1) and not S_In(0))), q => q0);
		R1: Register_16_bit port map(d => d1, clk => clk, wr => wr and (not S_In(2) and (not S_In(1) and S_In(0))), q => q1);
		R2: Register_16_bit port map(d => d2, clk => clk, wr => wr and (not S_In(2) and (S_In(1) and not S_In(0))), q => q2);
		R3: Register_16_bit port map(d => d3, clk => clk, wr => wr and (not S_In(2) and (S_In(1) and S_In(0))), q => q3);
		R4: Register_16_bit port map(d => d4, clk => clk, wr => wr and (S_In(2) and (not S_In(1) and not S_In(0))), q => q4);
		R5: Register_16_bit port map(d => d5, clk => clk, wr => wr and (S_In(2) and (not S_In(1) and S_In(0))), q => q5);
		R6: Register_16_bit port map(d => d6, clk => clk, wr => wr and (S_In(2) and (S_In(1) and not S_In(0))), q => q6);
		R7: Register_16_bit port map(d => d7, clk => clk, wr => pc_wr or (wr and (S_In(2) and (S_In(1) and S_In(0)))), q => q7);
		
		--to RF_Out_A
		
		MuxA : Mux_8to1_16bit port map (I0 => q0, I1 => q1, I2 => q2, I3 => q3, I4 => q4, I5 => q5, I6 => q6, I7 => q7, S => S_Out_A, Y => RF_Out_A);
		
		--to RF_Out_B

		MuxB : Mux_8to1_16bit port map (I0 => q0, I1 => q1, I2 => q2, I3 => q3, I4 => q4, I5 => q5, I6 => q6, I7 => q7, S => S_Out_B, Y => RF_Out_B);

		

end Struct;