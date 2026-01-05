library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cmpt1 is
    Port (
        H : in  STD_LOGIC;  -- Horloge
        Q : out STD_LOGIC_VECTOR(3 downto 0)  -- Sortie BCD
    );
end cmpt1;

architecture Behavioral of cmpt1 is
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

    process(H)
    begin
        if rising_edge(H) then
            if count = "1001" then  -- 9 en BCD
                count <= "0000";    -- Revenir à 0
            else
                count <= count + 1; -- Incrémenter
            end if;
        end if;
    end process;

    Q <= count;

end Behavioral;
