library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cmpt2 is
    Port (
        H     : in  STD_LOGIC;
        C     : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end cmpt2;

architecture Behavioral of cmpt2 is
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

    process(H, RESET)
    begin
        if RESET = '1' then
            count <= "0000"; -- Reset asynchrone
        elsif rising_edge(H) then
            if C = '1' then -- Comptage
                if count = "1001" then -- 9
                    count <= "0000"; -- Rollover à 0
                else
                    count <= count + 1;
                end if;
            else -- Décomptage
                if count = "0000" then -- 0
                    count <= "1001"; -- Rollover à 9
                else
                    count <= count - 1;
                end if;
            end if;
        end if;
    end process;

    Q <= count;

end Behavioral;
