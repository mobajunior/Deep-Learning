# Nom: Moussa Bâ

import os
d = " 4"
user_file = "data_270.txt"
list = os.listdir('/home/mb/vgg/db/img_270')
for fichier in list:
	name = fichier + d
	fichier = open(user_file, "a")		
	fichier.write(name)
	fichier.write("\n")

fichier.close()
