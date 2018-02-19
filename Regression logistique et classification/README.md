# Introduction

Au cours de l'exercice, nous allons utiliser la régression logistique pour prédire les chances d'admission d'un étudiant dans un programme d'étude à partir de deux examens standardisés.

# Données d'entraînement

Veuillez télécharger le fichier tp2data.txt contenant les notes des deux examens standardisés.
Vous pouvez visualiser les données données d'entraînement dans la figure ci-dessous.

![donnees_apprentissage 1](https://user-images.githubusercontent.com/26171556/36231499-a0c75560-11b4-11e8-8329-a90da84ab566.png)

# Sigmoïde

Nous allons utiliser la fonction sigmoïde, pour pouvoir répartir nos données.
La formule est la suivante: 
<br /> ![image](https://user-images.githubusercontent.com/26171556/36397884-cee20992-159a-11e8-9517-4463b88fde3c.png)

Résultats obtenus:

Z | sigmoïde
-- | --
0 | 0.5
5 | 0.993307
-5 | 0.006693

# Fonction de coût et gradient

Nous allons implémenter une fonction de coût  qui va nous permettre de calculer les gradients  dans costFunction.m
<br /> function [J, grad] = costFunction(theta, X, y)
<br /> Les équations de la fonction de coût et des gradients:
<br />![fct_cout_gradient](https://user-images.githubusercontent.com/26171556/36398344-0c6569d8-159d-11e8-913a-46bbb8041c87.png)
<br /> La fonction de coût trouvée pour Thétas initialisés à 0 est de : 0.693147

# Probabilité de prédiction

Après avoir trouvé les thétas et la fonction de coût, nous avons pu prédire qu’ un étudiant qui a eu à l’examen 1 = 45 et l’examen 2 = 85; aura une probabilité de 77.4324 pourcents d’être admis.



