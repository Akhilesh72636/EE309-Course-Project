library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lmsmunit is
port(

	clk: in std_logic;
	x: in std_logic(7 downto 0);
	o1: out std_logic(2 downto 0);
	lmsm: out std_logic(7 downto 0)
	)
end entity;


architecture behavioral of lmsmunit is

component priorityencoder is
    port (
        in1 : in std_logic_vector(7 downto 0);
        out1: out std_logic_vector(2 downto 0));
end priorityencoder;

signal o2: std_logic_vector(2 downto 0);
 port(  
         x : in STD_LOGIC_VECTOR(7 downto 0);
         o1 : out STD_LOGIC_VECTOR(2 downto 0)
         );	
end component;

signal lmsmt: std_logic_vector(7 downto 0);
begin



p:priorityencoder port map(in1=>x,out1=>o2);
o1<=o2;


case o2 is
 when "000" =>
  lmsmt(6 downto 0):=x(6 downto 0);
  lmsmt(7)<='0';
 when "001" =>
  lmsmt(5 downto 0)<=x(5 downto 0);
  lmsmt(7 downto 6)<="00";
 when "010" =>
  lmsmt(4 downto 0)<=x(4 downto 0);
  lmsmt(7 downto 5)<="000";
 when "011" =>
  lmsmt(3 downto 0)<=x(3 downto 0);
  lmsmt(7 downto 4)<="0000";
 when "100" =>
  lmsmt(2 downto 0)<=x(2 downto 0);
  lmsmt(7 downto 3)<="00000";
 when "101" =>
  lmsmt(1 downto 0)<=x(1 downto 0);
  lmsmt(7 downto 2)<="000000";
 when "110" =>
  lmsmt(0 downto 0)<=x(0 downto 0);
  lmsmt(7 downto 1)<="0000000";
 when "111" =>
  lmsmout_var(7 downto 0)<="00000000";
 when others => null;
 end case;
if (clk'event and clk='1') then
 lmsm<=lmsmt;
 end if;
 end process;
 
 end behavioral;
 

