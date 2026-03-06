library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cmpt3 is
    Port (
        H     : in  STD_LOGIC;
        C     : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        load  : in  STD_LOGIC;
        data  : in  STD_LOGIC_VECTOR(3 downto 0);
        Q     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end cmpt3;

architecture Behavioral of cmpt3 is
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

    process(H, RESET)
    begin
        if RESET = '1' then
            count <= "0000"; -- Reset asynchrone

        elsif rising_edge(H) then

            if load = '1' then
                count <= data; -- Préchargement synchrone

            elsif C = '1' then -- Comptage
                if count = "1001" then -- 9
                    count <= "0000"; -- Rollover à 0
                else
                    count <= count + 1;
                end if;

            else -- Décomptage (C = '0')
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
