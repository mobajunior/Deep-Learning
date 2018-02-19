# Introduction

Au cours de ce tp, nous allons essayer classifier les pixels d’images, selon feu ou pas feu. Pour cela, nous allons utiliser SVM qui va nous permettre de trouver des vecteurs de support dont la projection maximise la marge entre les classes.

# Description de la base de données

Notre base de données contient 30 images qui montrent des régions de feux à prédominance rouge (RGB), en plus des 30 images Groud truth qui montrent la segmentation des régions de feux en noir et blanc.

![image](https://user-images.githubusercontent.com/26171556/36399211-319cc882-15a1-11e8-9734-afbefbb45389.png)
![image](https://user-images.githubusercontent.com/26171556/36399227-4c2ee2de-15a1-11e8-9211-526b6d41bafa.png)

# Liste images  et coordonnées utilisées pour apprentissages

- Coordonnées: dans le dossier courant, vous trouverez un fichier excel qui a pour nom coord_fire, qui comporte les noms des images, avec les coordonnées d’extractions des différentes zones de feu, selon leurs numéros. 
<br /> - Liste images: vous trouverez dans le dossier fire_regions toutes les images qu’on a pris pour l’apprentissage avec les zones de feu délimitées par des carrés.
