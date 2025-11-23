# Projets_FPGA


## Prise en main du logiciel: Porte ET 
### Schéma:
<img width="919" height="277" alt="imagen" src="https://github.com/user-attachments/assets/4347dff7-f50d-4ad2-8f60-09ce808bb686" />

### Simulation:
<img width="947" height="305" alt="imagen" src="https://github.com/user-attachments/assets/bf2045ae-1405-462f-b2cc-b9259fab127e" />

On observe la sortie à l’état haut lorsque les deux entrées sont à l’état haut ; dans les autres cas, la sortie est à l’état bas. Cela correspond bien à la table de vérité de la porte ET.

## Projet 1: Comptage et affichage des secondes de 0 à 9

### A : Réalisation du décodeur BCD / 7segments : 
#### Schéma:
<img width="1240" height="900" alt="imagen" src="https://github.com/user-attachments/assets/67d9838d-6bbc-4d44-92e3-75bd85ba2d1c" />

#### Code VHDL mode concurrent:


#### Code VHDL mode séquentiel:

#### Simulation avec blocs:
<img width="1792" height="281" alt="imagen" src="https://github.com/user-attachments/assets/8571cd0a-c231-4f1e-8a6f-bdeaf4bac20d" />

#### Simulation avec code VHDL mode concurrent:
<img width="1071" height="347" alt="imagen" src="https://github.com/user-attachments/assets/9595c0e3-ab9c-43cd-a67b-441987f7a863" />

#### Simulation avec code VHDL mode séquentiel:

Pour les valeurs comprises entre 0 et 9, les segments correspondants au chiffre décimal sont allumés de manière standard.
Par exemple, le chiffre 1 s'affiche en allumant uniquement les segments b et c, ce qui correspond à un affichage correct.  
Pour toute valeur hors de cet intervalle (par exemple, 10, 11, etc.), on choisit d’afficher la lettre 'E' (pour Erreur).
Ainsi, pour le code 10, les segments a, d, e, f, g sont activés, formant visuellement la lettre 'E' sur l’afficheur 7-segments.

### B : Réalisation d’un compteur BCD :
#### B1 : Réalisation du compteur BCD simple cmpt1 :
#### B2 : Réalisation du compteur BCD simple cmpt2 :
#### B3 : Réalisation du compteur BCD simple cmpt3 :

###  C : Génération du signal de 1 Hz :

## Génération d’une PWM :
