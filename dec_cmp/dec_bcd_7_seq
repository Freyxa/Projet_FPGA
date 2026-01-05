
library ieee;
use ieee.std_logic_1164.all;

entity dec_sequentiel is
	port (	BCD :	in std_logic_vector(3 downto 0);
			SEG :	out std_logic_vector(0 to 6));
end dec_sequentiel;

architecture arch_dec_sequentiel of dec_sequentiel is
begin 	
affectation_selective : 
	with BCD select
		SEG <=	"0000001" when "0000",
				"1001111" when "0001",
				"0010010" when "0010",
				"0000110" when "0011",
				"1001100" when "0100",
				"0100100" when "0101",
				"0100000" when "0110",
				"0001111" when "0111",
				"0000000" when "1000",
				"0000100" when "1001",		 
				"0110000" when others;
end arch_dec_sequentiel;
