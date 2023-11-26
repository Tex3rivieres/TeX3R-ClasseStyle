# Pistes de travail

## Conflits de package

### Bugs connus

Fonctions lua ne prennent pas en compte les arguments (lignes)
Visible : commande lua n'affecte pas le booléen correctement
Enonce : ne prend pas l'argument pour être renommé en mode cours
Diapo cassé


### Adjustbox/pstricks

Redéfinir ```\clipbox``` dans ```pstricks``` plutôt que de la supprimer, en s'aidant des hooks, si cela est nécessaire. A priori pas nécessaire, mais à voir en fonction.

### ProfCollege et ???

Colonne X déjà définie pour le tableur créé avec ```nicematrix```.

## Extension VS Code / VS Codium

- Définir les commandes à ajouter/supprimer dans le panel > voir Recap commandes.md
- Modifier les snippets

## Implémentations à venir

### TOC

TOC à mettre en forme (suppression des numéros des subsubsections ou transformation en 1/A)

### Subfiles

Tester les exercices en subfile pour les fiches de TD. (Réfléchir à comment ignorer l'environnement luacode dans un document ? Dans documentation utiliser ifSubfile ?)

```latex
\ifSubfilesClassLoaded{% then branch
. . . commands executed when the subfile is typeset . . .
}{% else branch
. . . commands executed when the main file is typeset . . .
}
```


### Rétrocompatibilité

Supprimer les commandes obsolètes de la classe.

### Templates

* Template de brevet
* Template Evaluation + remédiation

### Documentation

Trois documentations à écrire :
  - Installation d'un environnement LaTeX
  - Utilisation des commandes de la classe
  - Personnalisation du style

### Style utilisateur

Améliorer l'ergonomie de la modification du style.