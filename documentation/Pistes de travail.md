# Pistes de travail

## Commandes à créer

## Remarques

Deux adjustbox successifs font planter la compilation (ajouter un \vspace{0pt} entre les deux permet de résoudre le problème, sûrement un problème de passage vertical/horinzontal mode)

Adjustbox est très inconsistant : le fix de \vspace{0pt} avant et après semble suffisant.


## Numérotation

Conflit de numérotation avec le type 'basique'

## Conflits de package

### Adjustbox/pstricks

Redéfinir ```\clipbox``` dans ```pstricks``` plutôt que de la supprimer, en s'aidant des hooks, si cela est nécessaire. A priori pas nécessaire, mais à voir en fonction.

### ProfCollege et ???

Colonne X déjà définie pour le tableur créé avec ```nicematrix```.

## Implémentations à venir

### TOC

TOC à mettre en forme (suppression des numéros des subsubsections ou transformation en 1/A)

### Rétrocompatibilité

Supprimer les commandes obsolètes de la classe.

### Documentation

  - Personnalisation du style
