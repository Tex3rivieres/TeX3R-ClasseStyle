# Changelog

## [3.3.0] - XX

- Ajout du fichier `flashcards-tex3R.sty`
- Modification du template Année complète
- Fix de `\montitre` en mode diapo
- 

## [3.2.8] - 12/02/24

- `\parametres` est désormais automatiquement exécuté s'il manque dans le préambule.
- Mise à jour des templates pour fonctionner avec les modifications de la classe.
- Nettoyage de code dans la classe (et suppression des anciennes commandes de compatibilité)
- Suppression du dossier `old`

## [3.2.7] - 31/01/24

- Ajustements de la hauteur des numérotations des sous-parties dans le style
- Modification de enonce dans le style : possibilité de changer optionnellement le nom d'un exercice

## [3.2.6] - 27/01/24

- Changement de format du changelog + déplacement du fichier à la racine
- Ajout du template Flashcards
- Suppression du template HelloWorld

## 25/01/24

- Fix de `\structure*`, mal défini dans la classe

## 24/01/24

- Commande `\exercice` renommée `\structure` pour pouvoir l'appliquer à d'autre endroits des documents.
- Réinitialisation des commandes d'exercice (bareme, competence, etc) à la fin de l'énoncé dans la classe pour ne pas impacter le suivant.

## 17/01/24

- Ajout de np dans `contenubareme` pour formater les nombres décimaux
- Ajout de la commande `\exercice` (commande vide permettant de s'afficher dans la structure)
- Ajout des commandes \Com, \Cal, \Rai, \Che,\Mod, \Rep

## 15/01/24

- Ajout de l'option POLICE.tableau dans le style, afin de modifier l'espacement naturel des tableaux.
- Documentation mise à jour vis à vis des compteurs
- Suppression du dossier old

## 23/12/23

- Options de classe supprimées, ajout d'un parametrage supplémentaire dans le préambule regroupant Format, Chapitre Numéro et  Niveau. Ajout du paramétrage Compteur dans le corps du document.
- Documentation de classe-tex3R modifiée en conséquence. 
- Documentation style-tex3R continuée
- Documentation basique corrigée.

## 22/12/23

Documentation du style commencée.

Ajout de la syntaxe `\np{8.e10}` possible.

## 16/12/23

Fix du coloriage de la flèche de Scratch

Documentation `tkz-euclide` continuée

Documentation `basique créée`

## 13/12/23

Documentation `tkz-euclide` continuée.

Fix du `\n` dans la déclaration des polices

Option `lua` ajoutée à tkz-euclide pour optimiser le calcul des figures.

Modification du style par défaut dans `tkz-euclide`

Changement du texte par défaut en 'Propriété (admise)' pour l'environnement `propriete`

## 11/12/23

Fix de la flèche de Scratch

Compétences passées en `\large` dans leur affichage dans l'énoncé.

Suppression du changement de taille de police au début d'un environnement `scratch` (sujet à bugs)

Début de la documentation `tkz-euclide`

## 10/12/23

Ajout d'un paramètre `handdrawn` pour les segments de tkz euclide.

Remarques ajoutées à Pistes de travail

## 09/12/23

Fix de `\lignes{surligne}`

Écriture de la première documentation (classe-tex3R)

Ajustement des marges de bas de page pour la numérotation

Suppression de `compteurfeuille` (non utilisé)

Ajout des compteurs à la documentation `classe-tex3R`

## 08/12/23

Commande `\titrecustom` renommée en `\montitre`

## 06/12/23

- Création de la commande `\visiblecmd`
- Debug de la commande `\definirniveau`
- Création des versions étoilées de `\partie` et `\souspartie`
- Template autonome de 'Évaluation' rajouté 
- Commande `\titrecustom` rajoutée

## 27/11/2023

Diapo réparé

---------------------

Commande `lignes` réparée.

-----------------

Environnement `visible` réparé

-----------------------

L'environnement `enonce` avec un paramètre fonctionne désormais correctement en type cours et en type autre.

------------------

Template Subfiles - TD créé (légère modification de la classe avec ajout d'un booléen LaTeX \ifsubfile)

-------------------

Template Paysage créé + template Brevet

------------

Ajout de la fonction `NiveauUtilisateur()` dans le style

---------------
Tests divers. Versions stable.

## 26/11/2023

Changements dans la fonction `parametrage` de la classe. Utilisation de `loadgeometry` et clean global du code de `parametrage`.

-----------------

Dossier template : Exemple de subfile pour créer un mega-document, création d'un fichier de parcours en luatex.



## 24/11/2023

Fusion des environnements `exercice` et `enonce`, réglages dans la TOC, différenciation selon cours et selon le reste.

-----------------

Ajout d'un dossier templates pour mettre des templates d'idées au cas où.

-----------
Modification de gitignore pour ignorer les fichier .synctex

---------
Ajout de la couleur d'arrière plan dans le style.

## 23/11/2023

Réglages pour la `\part*`

-----------

Réparation de `difficulte`

------------

.md groupés dans documentation

-----------------

Inversion de * entre l'environnement et la commande `visible` et ajout de l'arrière plan du contenu de visible ainsi que de sa couleur correspondante.

--------------------

Bugfix divers.

----------------

Ajout d'une fonction lua pour conserver des paramètres utilisateurs fréquents.
Paramètres réinitialisés à chaque appel de `\parametrage` pour le mega-document.

## 22/11/2023

Changement de l'utilisation de `parametrage` pour offrir la possibilité de faire un mega-document.

-------
TOC des chapitres. Nouvelles commandes `\chapitre `, `\partie` et `\souspartie` pour remplacer et utiliser `part`, `subsection` et `subsubsection` de manière plus naturelle. Transformation de l'ancien `\chapitre` en `\definirchapitre`

## 21/11/2023

Ajout de `enonce` et `correction` à la TOC en tant que `subsubsection` d'un exercice lui même en `subsection`.

---------------



## 20/11/2023

Package `adjustbox` rajouté à la classe. Le conflit entre `adjustbox` et `pstricks` a été résolu en supprimant la commande `\clipbox` de `pstricks`.

L'utilisation de la commande `\clipbox` dans `pstricks` devrait donc normalement provoquer des erreurs. 

Possibilité si nécessité de stocker la commande `\clipbox` de `adjustbox` et de `pstricks` dans deux commandes distinctes, et de `\renewcommand` `\clipbox` avec un hook an début de chacun des envrionnements.

------------------------
Commande `\chapitre` modifiée pour tolérer un argument vide.

---------------

Ajout du paramètre `stretch`.

-----------------

Ergonomie du style utilisateur améliorée pour la modification.

-------------------------

Ajout des titres de fiches dans la TOC en tant que sections.

## 19/11/2023

Push de la classe et du style tex3R recodés en lua. 

Restructuration du dépôt Github.