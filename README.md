# Projets_FPGA


## Prise en main du logiciel: Porte ET 
### Schéma:
<img width="919" height="277" alt="imagen" src="https://github.com/user-attachments/assets/4347dff7-f50d-4ad2-8f60-09ce808bb686" />

### Simulation:
<img width="947" height="305" alt="imagen" src="https://github.com/user-attachments/assets/bf2045ae-1405-462f-b2cc-b9259fab127e" />

On observe la sortie à l’état haut lorsque les deux entrées sont à l’état haut ; dans les autres cas, la sortie est à l’état bas. 
Cela correspond bien à la table de vérité de la porte ET.

## Projet 1: Comptage et affichage des secondes de 0 à 9

### A : Réalisation du décodeur BCD / 7segments : 
#### Schéma:
<img width="1240" height="900" alt="imagen" src="https://github.com/user-attachments/assets/67d9838d-6bbc-4d44-92e3-75bd85ba2d1c" />

#### Code VHDL mode concurrent:
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

#### Code VHDL mode séquentiel:
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

Pour les valeurs comprises entre 0 et 9, les segments correspondants au chiffre décimal sont allumés de manière standard.
Par exemple, le chiffre 1 s'affiche en allumant uniquement les segments b et c, ce qui correspond à un affichage correct.  
Pour toute valeur hors de cet intervalle (par exemple, 10, 11, etc.), on choisit d’afficher la lettre 'E' (pour Erreur).
Ainsi, pour le code 10, les segments a, d, e, f, g sont activés, formant visuellement la lettre 'E' sur l’afficheur 7-segments.

#### Simulation avec code VHDL mode concurrent:
<img width="1071" height="347" alt="imagen" src="https://github.com/user-attachments/assets/9595c0e3-ab9c-43cd-a67b-441987f7a863" />

On remarque le même fonctionnement qu’avec la simulation précédente,
mais cette fois-ci, on regroupe les entrées A, B, C et D dans une seule entrée appelée INPUT.
À cette entrée, on attribue un compteur allant de 0 à F afin de tester toutes les combinaisons possibles.

#### Simulation avec code VHDL mode séquentiel:



### B : Réalisation d’un compteur BCD :
#### B1 : Réalisation du compteur BCD simple cmpt1 :
#### B2 : Réalisation du compteur BCD simple cmpt2 :
#### B3 : Réalisation du compteur BCD simple cmpt3 :

###  C : Génération du signal de 1 Hz :

## Génération d’une PWM :
