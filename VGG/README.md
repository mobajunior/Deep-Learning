# Introduction

Au cours de cet exercice, nous allons traiter une base de données d’images comportant  différentes classes selon sa rotation (les différentes classes de rotation sont 0,  90, 180 et 270 degré). Notre travail consistera à détecter l’orientation d’une  image à travers une architecture de classification supervisée qui sera le réseau  de neurones convolutionnel VGG dans notre cas, créé avec la base de données  énumérée précédemment. Ainsi avec l’utilisation de VGG nous allons nous
pouvons faire l’entraînement et la validation de nos images pour pouvoir créer  un modèle qui va nous permettre de prédire de nouvelles images.
Le VGG est une architecture de réseau convolutionnel qui aborde un aspect
important de la conception d’architecture Conv-net la profondeur. À cette fin, on  fixe d'autres paramètres de l'architecture et augmentons régulièrement la  profondeur du réseau en ajoutant plus de couches convolutives, ce qui est  possible grâce à l'utilisation de très petits filtres à convolution (3 × 3) dans toutes  les couches.

# Description de la base de données

À partir du fichier ORL_64x64.mat, nous allons extraire la matrice fea de  dimension 400x4095 qui contient les 400 images de taille 64x64 sous forme de  vecteur de dimension 4096 (64x64). Avec notre fichier main.m, nous allons  extraire les images de la matrice, puis faire des rotations de 90, 180, 270 pour  chaque image et les enregistrer dans des dossiers selon le nom des classes.
