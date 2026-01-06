# Projets_FPGA


## Prise en main du logiciel: Porte ET 
### Schéma:
<img width="919" height="277" alt="imagen" src="https://github.com/user-attachments/assets/4347dff7-f50d-4ad2-8f60-09ce808bb686" />

### Simulation:
<img width="947" height="305" alt="imagen" src="https://github.com/user-attachments/assets/bf2045ae-1405-462f-b2cc-b9259fab127e" />

**Commentaire:**
On observe la sortie à l’état haut lorsque les deux entrées sont à l’état haut ; dans les autres cas, la sortie est à l’état bas. 
Cela correspond bien à la table de vérité de la porte ET.

## Projet 1: Comptage et affichage des secondes de 0 à 9

### A : Réalisation du décodeur BCD / 7segments : 
#### Travail préparatoire:
![IMG20251123220151](https://github.com/user-attachments/assets/13de2cb7-1e16-4809-988d-b9d089119dcd)
![IMG20251123220200](https://github.com/user-attachments/assets/d852e936-b654-4900-ad20-4ba5120379e6)
![IMG20251123220213](https://github.com/user-attachments/assets/92d44859-03ff-4f15-b32a-6de986626b9c)




#### Schéma:
<img width="1240" height="900" alt="imagen" src="https://github.com/user-attachments/assets/67d9838d-6bbc-4d44-92e3-75bd85ba2d1c" />

#### Code VHDL affectation inconditionnelle:
```vhdl
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
```

#### Code VHDL affectation conditionnelle:
```vhdl
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
```

#### Simulation avec blocs:
<img width="1792" height="281" alt="imagen" src="https://github.com/user-attachments/assets/8571cd0a-c231-4f1e-8a6f-bdeaf4bac20d" />

**Commentaire**:
Pour les valeurs comprises entre 0 et 9, les segments correspondants au chiffre décimal sont allumés de manière standard.
Par exemple, le chiffre 1 s'affiche en allumant uniquement les segments b et c, ce qui correspond à un affichage correct.  
Pour toute valeur hors de cet intervalle (par exemple, 10, 11, etc.), on choisit d’afficher la lettre 'E' (pour Erreur).
Ainsi, pour le code 10, les segments a, d, e, f, g sont activés, formant visuellement la lettre 'E' sur l’afficheur 7-segments.

#### Simulation avec code VHDL affectation inconditionnelle:
<img width="1071" height="347" alt="imagen" src="https://github.com/user-attachments/assets/9595c0e3-ab9c-43cd-a67b-441987f7a863" />

**Commentaire**:
On remarque le même fonctionnement qu’avec la simulation précédente,
mais cette fois-ci, on regroupe les entrées A, B, C et D dans une seule entrée appelée INPUT.
À cette entrée, on attribue un compteur allant de 0 à F afin de tester toutes les combinaisons possibles.

#### Simulation avec code VHDL affectation conditionnelle:

**Commentaire**: 
On obtient exactement la même simulation que pour le code concurrent, sauf que l’approche séquentielle simplifie le code.

#### Assignation des pins sur le FPGA:
<img width="1888" height="957" alt="image" src="https://github.com/user-attachments/assets/4cc40f16-51c4-4f67-adf4-3cde53d570ff" />


### B : Réalisation d’un compteur BCD :
#### B1 : Réalisation du compteur BCD simple cmpt1 :
#### Travail préparatoire:
![66124](https://github.com/user-attachments/assets/9fe0e577-a8fd-4577-b423-d722e31a8f8b)
![66125](https://github.com/user-attachments/assets/53f821e8-16dd-4994-84e3-c45258b58030)
![66126](https://github.com/user-attachments/assets/52ba780e-4d5f-4f20-b62c-0ce605a8a5cd)


#### Schéma avec blocs et bascules:
<img width="1412" height="532" alt="image" src="https://github.com/user-attachments/assets/7bbb8684-4bc9-40e5-b9cf-c2e347ce2656" />


#### Simulation avec bascule:
<img width="1749" height="239" alt="image" src="https://github.com/user-attachments/assets/84bede65-9186-419b-a351-2d73729ea54d" />

#### Code VHDL cmpt1:
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cmpt1 is
    Port (
        H : in  STD_LOGIC;  -- Horloge
        Q : out STD_LOGIC_VECTOR(3 downto 0)  -- Sortie binaire (0 à 15)
    );
end cmpt1;

architecture arch_cmpt1 of cmpt1 is
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

    process(H)
    begin
        if rising_edge(H) then
            if count = "1111" then  -- 15 en binaire (F en hexa)
                count <= "0000";    -- Revenir à 0
            else
                count <= count + 1; -- Incrémenter
            end if;
        end if;
    end process;

    Q <= count;

end arch_cmpt1;
```

#### Simulation fonctionnelle:

#### Assignation des pins sur le FPGA:
<img width="1735" height="834" alt="image" src="https://github.com/user-attachments/assets/3684ecb2-6178-4d37-bcbb-b1721eaec519" />


#### B2 : Réalisation du compteur BCD simple cmpt2 :
```vhdl
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
```
#### Simulation fonctionnelle:
#### B3 : Réalisation du compteur BCD simple cmpt3 :

#### Code VHDL cmpt1:

```vhdl
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
```

###  C : Génération du signal de 1 Hz :

## Génération d’une PWM :
