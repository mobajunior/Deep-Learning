# Introduction

Au cours de ce tp, nous allons essayer classifier les pixels d’images, selon feu ou pas feu. Pour cela, nous allons utiliser SVM qui va nous permettre de trouver des vecteurs de support dont la projection maximise la marge entre les classes.

# Description de la base de données

Notre base de données contient 30 images qui montrent des régions de feux à prédominance rouge (RGB), en plus des 30 images Groud truth qui montrent la segmentation des régions de feux en noir et blanc.

![image](https://user-images.githubusercontent.com/26171556/36399211-319cc882-15a1-11e8-9734-afbefbb45389.png)
![image](https://user-images.githubusercontent.com/26171556/36399227-4c2ee2de-15a1-11e8-9211-526b6d41bafa.png)

# Liste images  et coordonnées utilisées pour apprentissages

- Coordonnées: dans le dossier courant, vous trouverez un fichier excel qui a pour nom coord_fire, qui comporte les noms des images, avec les coordonnées d’extractions des différentes zones de feu, selon leurs numéros. 
- Liste images: vous trouverez dans le dossier fire_regions toutes les images qu’on a pris pour l’apprentissage avec les zones de feu délimitées par des carrés.

# Description de l’expérimentation et approche

Afin de trouver trois zones de feu de 10x10 px, on récupère d’abord la zone de feu complète de l’image dans une matrice, puis on se positionne sur le centre de cette zone et on cherche aléatoirement des zones de 10x10 px en  partant du centre.
On fait de même pour les zones de non feu, mais on ne se base pas sur le centre de la zone.
Après avoir obtenu 3 régions de feu et de non feu 10x10 px pour 15 images, on extrait leurs caractéristiques selon plusieurs canaux et on les met dans une matrice de 9000 x 16, dont les 4500 premières rangées représentent les valeurs  des pixels feu selon leur canaux et les 4500 autres les non feux. Vous trouverez les images des caractéristiques des zones de feu extraites dans les dossiers correspondants aux noms des canaux.

# Exemples
