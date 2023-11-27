# Changelog

## 27/11/2023

Diapo réparé

---------------------

Commande ```lignes``` réparée.

-----------------

Environnement ```visible``` réparé

-----------------------

L'environnement ```enonce``` avec un paramètre fonctionne désormais correctement en type cours et en type autre.

------------------

Template Subfiles - TD créé (légère modification de la classe avec ajout d'un booléen LaTeX \ifsubfile)

-------------------

Template Paysage créé

## 26/11/2023

Changements dans la fonction ```parametrage``` de la classe. Utilisation de ```loadgeometry``` et clean global du code de ```parametrage```.

-----------------

Dossier template : Exemple de subfile pour créer un mega-document, création d'un fichier de parcours en luatex.



## 24/11/2023

Fusion des environnements ```exercice``` et ```enonce```, réglages dans la TOC, différenciation selon cours et selon le reste.

-----------------

Ajout d'un dossier templates pour mettre des templates d'idées au cas où.

-----------
Modification de gitignore pour ignorer les fichier .synctex

---------
Ajout de la couleur d'arrière plan dans le style.

## 23/11/2023

Réglages pour la ```\part*```

-----------

Réparation de ```difficulte```

------------

.md groupés dans documentation

-----------------

Inversion de * entre l'environnement et la commande ```visible``` et ajout de l'arrière plan du contenu de visible ainsi que de sa couleur correspondante.

--------------------

Bugfix divers.

----------------

Ajout d'une fonction lua pour conserver des paramètres utilisateurs fréquents.
Paramètres réinitialisés à chaque appel de ```\parametrage``` pour le mega-document.

## 22/11/2023

Changement de l'utilisation de ```parametrage``` pour offrir la possibilité de faire un mega-document.

-------
TOC des chapitres. Nouvelles commandes ```\chapitre ```, ```\partie``` et ```\souspartie``` pour remplacer et utiliser ```part```, ```subsection``` et ```subsubsection``` de manière plus naturelle. Transformation de l'ancien ```\chapitre``` en ```\definirchapitre```

## 21/11/2023

Ajout de ```enonce``` et ```correction``` à la TOC en tant que ```subsubsection``` d'un exercice lui même en ```subsection```.

---------------



## 20/11/2023

Package ```adjustbox``` rajouté à la classe. Le conflit entre ```adjustbox``` et ```pstricks``` a été résolu en supprimant la commande ```\clipbox``` de ```pstricks```.

L'utilisation de la commande ```\clipbox``` dans ```pstricks``` devrait donc normalement provoquer des erreurs. 

Possibilité si nécessité de stocker la commande ```\clipbox``` de ```adjustbox``` et de ```pstricks``` dans deux commandes distinctes, et de ```\renewcommand``` ```\clipbox``` avec un hook an début de chacun des envrionnements.

------------------------
Commande ```\chapitre``` modifiée pour tolérer un argument vide.

---------------

Ajout du paramètre ```stretch```.

-----------------

Ergonomie du style utilisateur améliorée pour la modification.

-------------------------

Ajout des titres de fiches dans la TOC en tant que sections.

## 19/11/2023

Push de la classe et du style tex3R recodés en lua. 

Restructuration du dépôt Github.