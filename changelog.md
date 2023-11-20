# Changelog

## 20/11/2023

Package ```adjustbox``` rajouté à la classe. Le conflit entre ```adjustbox``` et ```pstricks``` a été résolu en supprimant la commande ```\clipbox``` de ```pstricks```. 

L'utilisation de la commande ```\clipbox``` dans ```pstricks``` devrait donc normalement provoquer des erreurs. 

Possibilité si nécessité de stocker la commande ```\clipbox``` de ```adjustbox``` et de ```pstricks``` dans deux commandes distinctes, et de ```\renewcommand``` ```\clipbox``` avec un hook an début de chacun des envrionnements.

## 19/11/2023

Push de la classe et du style tex3R recodés en lua. 

Restructuration du dépôt Github.