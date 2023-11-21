# Changelog

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