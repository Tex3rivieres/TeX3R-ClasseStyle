# Pistes de travail


## Adjustbox

Deux adjustbox successifs font planter la compilation (ajouter un \vspace{0pt} entre les deux permet de résoudre le problème, sûrement un problème de passage vertical/horizontal mode)

Adjustbox est très inconsistant : le fix de \vspace{0pt} avant et après semble suffisant (cela a l'air de se produire vis à vis de l'emplacement dans la page : à voir, sinon il va falloir se débarasser d'adjustbox :/).

Cela ne se prduisait pas dans l'ancienne version de la classe, avant le changement de fonctionnement des hooks LaTeX.

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
