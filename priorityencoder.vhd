library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity priorityencoder is
    port (
        in1 : in std_logic_vector(7 downto 0);
        out1 : out std_logic_vector(2 downto 0)
    );
end entity priorityencoder;

architecture behavioral of priorityencoder is

begin
    
	 process (in1)
        variable highest_bit_index : integer := -1;
    
	 begin
        
		  for i in 7 downto 1 loop
            if in1(i) = '1' then
                highest_bit_index := i;
                exit;
            end if;
        end loop;

        case highest_bit_index is
            when 7 =>
                out1 <= "000";
            when 6 =>
                out1 <= "001";
            when 5 =>
                out1 <= "010";
            when 4 =>
                out1 <= "011";
            when 3 =>
                out1 <= "100";
            when 2 =>
                out1 <= "101";
            when 1 =>
                out1 <= "110";
            when 0 =>
                out1 <= "111";
            when -1 =>
                out1 <= "000"; --if no input is high
        end case;
    end process;
end architecture behavioral;