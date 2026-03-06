library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity diviseur_1hz is
    Port (
        clk_50mhz : in  STD_LOGIC;   -- Horloge 50 MHz
        reset     : in  STD_LOGIC;   -- Reset asynchrone
        led       : out STD_LOGIC    -- Sortie 1 Hz vers LED
    );
end diviseur_1hz;

architecture Behavioral of diviseur_1hz is
    signal compteur : unsigned(24 downto 0);  -- 25 bits pour compter jusqu'à 25M
    signal led_int  : STD_LOGIC;
    
    constant MAX_COMPTE : integer := 25;        -- 50M/2 = 25M pour altera de1
												-- on utilise 25 pour faciliter la simu fonctionnelle	
begin

    process(clk_50mhz, reset)
    begin
        if reset = '1' then
            compteur <= (others => '0');
            led_int <= '0';
            
        elsif rising_edge(clk_50mhz) then
            if compteur = MAX_COMPTE - 1 then
                compteur <= (others => '0');
                led_int <= not led_int;  -- Bascule la LED
            else
                compteur <= compteur + 1;
            end if;
        end if;
    end process;
    
    led <= led_int;

end Behavioral;
