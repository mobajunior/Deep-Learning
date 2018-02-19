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

![canaux](https://user-images.githubusercontent.com/26171556/36399470-68d341ae-15a2-11e8-8b1b-e104d1dbbf43.png)

Pour l’apprentissage, on a utilisé quatre algorithmes SVM pour l’apprentissage:
- Linéaire
- RBF
- Gaussien
- Polynomial
Afin de trouver les meilleurs paramètres pour ces algorithmes, on a utilisé la fonction fitcsvm en passant en paramètres OptimizeHyperparameters. Ce dernier nous permet de trouver automatiquement les meilleurs BoxConstraint et les meilleurs KernelScale pour nos SVM.
<br /> Après avoir éxécuté cette fonction  et obtenu notre SVMModel, on l’applique sur 10 images et on calcule la moyenne des F1 score, il en ressort que  sur les 4 SVM, les 3 meilleurs sont de type: linéaire, gaussien et polynomial.

Noms | Moyennes   F1 score | Écarts   type F1 score
-- | -- | --
Linéaire | 0.697 | 0.26
RBF | 0.61 | 0.271
Gaussien | 0.65 | 0.23
Polynomial | 0.64 | 0.25

**Résultats F1 score après apprentissage sur 10 images**

# Images résultantes de la segmentation et analyse

Vous trouverez toutes les images de segmentations de zones correspondantes aux 3 meilleurs algorithmes dans les dossiers ayant les noms du type d’algorithme utilisé.
- Bons résultats:
  - Linéaire
  ![linear](https://user-images.githubusercontent.com/26171556/36399803-f3f802d2-15a3-11e8-9a30-93d8802ecb2e.png)
  
  On obtient de bons résultats pour la segmentation, même si, sur quelles zones de l’image, notre SVM classifie des zones blanches comme feu, ceci est dû à l’extraction des zones de feu. Dans la zone de feu extraire, il se peut qu’on est choisi des zones blanches, au lieu de rouge.

  - Gaussien
  ![gaussien](https://user-images.githubusercontent.com/26171556/36399935-89be7a44-15a4-11e8-84c3-452a9bbb46de.png)
Dans ce cas aussi, on remarque que notre SVM n’a pas pu différencier la combinaison et le casque rouge du pompier comme non feu.

  - Polynomial
  ![polynomial](https://user-images.githubusercontent.com/26171556/36400046-042adf20-15a5-11e8-96fd-8f511a1a2f66.png)
<br />
De nos résultats, on peut déduire que l’extraction des caractéristiques des zones de feux et non feu, joue sur la performance de notre SVM a pouvoir bien classifier les images. Surtout lorsqu’un pixel non feu est extrait des caractéristiques de zones feu, prédomine dans l’image, comme c’était le cas avec les pixels blancs avec l’image montrant le ciel tout blanc.
On pu constater que le modèle linéaire prenait plus en compte les pixels blancs comme feu que les autres modèles.

# Les paramètres des SVM qui ont obtenus les meilleurs résultats

Nom   image | Box   constraint | Kernel scale
-- | -- | --
Linéaire | 0.001 | 0.00106
Gaussien | 46.25 | 0.759
Polynomial | 0.0234 | 0.66


