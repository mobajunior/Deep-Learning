# Introduction

Au cours de cet exercice, nous allons traiter une base de données d’images comportant  différentes classes selon sa rotation (les différentes classes de rotation sont 0,  90, 180 et 270 degré). Notre travail consistera à détecter l’orientation d’une  image à travers une architecture de classification supervisée qui sera le réseau  de neurones convolutionnel VGG dans notre cas, créé avec la base de données  énumérée précédemment. Ainsi avec l’utilisation de VGG nous allons nous
pouvons faire l’entraînement et la validation de nos images pour pouvoir créer  un modèle qui va nous permettre de prédire de nouvelles images.
Le VGG est une architecture de réseau convolutionnel qui aborde un aspect
important de la conception d’architecture Conv-net la profondeur. À cette fin, on  fixe d'autres paramètres de l'architecture et augmentons régulièrement la  profondeur du réseau en ajoutant plus de couches convolutives, ce qui est  possible grâce à l'utilisation de très petits filtres à convolution (3 × 3) dans toutes  les couches.

# Description de la base de données

À partir du fichier ORL_64x64.mat, nous allons extraire la matrice fea de  dimension 400x4095 qui contient les 400 images de taille 64x64 sous forme de  vecteur de dimension 4096 (64x64). Avec notre fichier main.m, nous allons  extraire les images de la matrice, puis faire des rotations de 90, 180, 270 pour  chaque image et les enregistrer dans des dossiers selon le nom des classes.

![rotation](https://user-images.githubusercontent.com/26171556/36400811-9bd49b78-15a9-11e8-9d68-3748ba6c7590.png)

# Description de l’expérimentation avec la méthodologie

Pour atteindre notre but, on a dû entrainer plusieurs modèles avec différents  paramètres. En changeant le taux d’apprentissage, voilà les résultats qu’on a pu  obtenir :


Noms | Taux d'apprentissage | nb_epoch | Accuracy
-- | -- | -- | --
vgg7 | 0.0001 | 7 | 97.92%
vgg8 | 0.001 | 7 | 34.58%
vgg9 | 0.01 | 7 | 25.00%
vgg10 | 0.0001 | 10 | 100%

# Analyse  des résultats

Après analyse des données, on constate plus on itère plus notre accuracy augmente et nous avons de meilleures prédictions. On constate aussi plus le taux d’apprentissage est grand, plus l’accuracy prend du temps pour augmenter. 

![image](https://user-images.githubusercontent.com/26171556/36400939-6b292588-15aa-11e8-9d72-726f730e7afe.png)
<br />**Légende**

![image](https://user-images.githubusercontent.com/26171556/36400959-8d4f2ffe-15aa-11e8-9a14-827da3884066.png)
<br />**Accuracy des différents models**
<br /> On peut voir dans ce graphe comment l’accuracy augmente en fonction du nombre d’itérations et du taux d’apprentissage.

![image](https://user-images.githubusercontent.com/26171556/36401014-e570f8a2-15aa-11e8-8072-cf25b75c6406.png)

Pour notre meilleur model vgg_face10, après un certain nombre d’itérations l’accuracy devient constamment à 1.

![image](https://user-images.githubusercontent.com/26171556/36401034-0ec1ec34-15ab-11e8-92e8-87f1b49eed77.png)

On voit aussi comment notre pourcentage de perte diminue par rapport à la validation.

![image](https://user-images.githubusercontent.com/26171556/36401054-3c142454-15ab-11e8-8388-24f9eb509e36.png)

![image](https://user-images.githubusercontent.com/26171556/36401090-7aae98fc-15ab-11e8-98c2-b5107024954c.png)

![image](https://user-images.githubusercontent.com/26171556/36401113-a1206010-15ab-11e8-82bf-e9d5e655f503.png)

On constate pour la couche complétement connectée, la convergence de données.
Pour nos prédictions, à partir de notre meilleur modèle vgg_face10, on constate que toutes les images ont été bien classifiées suivant la manière dont on avait classifié nos images les 60 premières images de class 0 degré, les 60 prochaines images de classe 90 degré, les 60 prochaines de classe 180 degré et les 60 dernières de classe 270. Vous trouverez le pourcentage pour chaque image dans le fichier texte result_97_9167.txt.

# Conclusion 

À travers cet exercice, nous avons pu voir comment le réseau convolutionnel fonctionne, à travers les différentes couches comment l’entraînement, la validation et le testing se fait.

# Description des répertoires

Dans le dossier data, vous trouverez tous les fichiers contenat le chemin des images et leurs classes. Dans le dossier scripts, vous trouverez un fichier main.m pour extraire les images, un fichier access_file.py pour écrire les chemins avec leurs classes. Le fichier vgg.py pour générer un réseau convolutionnel de 16 couches. Le fichier data_utils.py pour les fonction helpers permettant de générer la base de données d’images associées aux classes.
