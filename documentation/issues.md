# Implémentations à venir 

## Conflits de package

### Adjustbox/pstricks

Redéfinir ```\clipbox``` dans ```pstricks``` plutôt que de la supprimer, en s'aidant des hooks, si cela est nécessaire. A priori pas nécessaire, mais à voir en fonction.

### ProfCollege et ???

Colonne X déjà définie pour le tableur créé avec ```nicematrix```.

## Rétrocompatibilité

Les commandes et environnements suivants sont encore maintenus le temps de modifier les anciens documents, mais sont voué à disparaître :

```latex
\newcommand{\rivcorrection}[2]{\ifvisible #1 \else #2 \fi}
\newcommand{\rivimportant}[1]{\important{#1}}
\newcommand{\ajoutlignes}[1]{}
```
## Implémentations à venir

### Megadocument

- Adapter la compatibilité avec ```subfile```

### Brevet

- Rajouter le type ```brevet``` et tout le code autour
-> Créer un template de brevet plutôt que l'intégrer dans la classe.

### Documentation

Trois documentations à écrire :
  - Installation d'un environnement LaTeX
  - Utilisation des commandes de la classe
  - Personnalisation du style

### Nom du document

Générer le nom du pdf en fonction du ```Type``` choisi dans les options
-> Semble peu réaliste ; trop compliqué à mettre en place pour le gain

### Style utilisateur

Améliorer l'ergonomie de la modification du style.

## Extension VS Code / VS Codium

- Définir les commandes à ajouter/supprimer dans le panel
- Modifier les svg des icônes
- Modifier les snippets