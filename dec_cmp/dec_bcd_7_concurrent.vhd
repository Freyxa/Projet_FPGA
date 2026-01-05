library ieee;
use ieee.std_logic_1164.all;

entity dec_concurrent is
	port (	D,C,B,A :								in std_logic;
			SEGa,SEGb,SEGc,SEGd,SEGe,SEGf,SEGg :	out std_logic);
end dec_concurrent;

architecture arch_dec_concurrent of dec_concurrent is
begin 	
		SEGa <= A or C or (not B and not D) or (not A and B and not C and D);
		SEGb <= (not A and not B)or(not B and not C)or(not A and B and not C and not D);
		SEGc <= (not A and B)or(not C and not B)or(not A and C and D);
		SEGd <= A or (C and not D)or(not B and not D)or(not A and not B and C)or(B and not C and D);
		SEGe <= (A and B)or(not B and not D)or(A and C and D);
		SEGf <= A or(not C and not D)or(B and not C)or(B and C and not D);
		SEGg <= A or(B and not C)or(C and not D)or(not A and not B and C);
end arch_dec_concurrent;
