# Implémentations à venir 

## Conflits de package

### Adjustbox/pstricks

Redéfinir ```\clipbox``` dans ```pstricks``` plutôt que de la supprimer, en s'aidant des hooks, si cela est nécessaire. A priori pas nécessaire, mais à voir en fonction.

## Rétrocompatibilité

Les commandes et environnements suivants sont encore maintenus le temps de modifier les anciens documents, mais sont voué à disparaître :

```latex
\NewEnviron{lignes}{\BODY}
\NewEnviron{lignes*}{\BODY}
\newcommand{\rivcorrection}[2]{\ifvisible #1 \else #2 \fi}
\newcommand{\rivimportant}[1]{\important{#1}}
\newcommand{\ajoutlignes}[1]{}
\newcommand{\adjustbox}[2]{#2}
```
## Implémentations à venir

### Megadocument

- ```\part``` à redéfinir comme équivalent du chapitre
- Coder les ```enonce``` et ```correction``` dans la TOC en tant que subsection
- Coder ```\titreactif``` en tant que section dans la TOC
- Adapter la compatibilité avec ```subfile```
- Modifier les parametres dans le code lua pour qu'ils soient persistants (rajouter compteur d'exécution, et adapter en cas d'exécution $\geqslant$ 2)

### Brevet

- Rajouter le type ```brevet``` et tout le code autour

### Documentation

Trois documentations à écrire :
  - Installation d'un environnement LaTeX
  - Utilisation des commandes de la classe
  - Personnalisation du style

### Nom du document

Générer le nom du pdf en fonction du ```Type``` choisi dans les options

### Style utilisateur

Améliorer l'ergonomie de la modification du style.

### Environnement ```parametres```

Création d'un environnement parametres afin de fusionner la commande ```\parametre``` et l'environnement ```luacode``` en début de document. 

Nécessité de définir le scope de cet environnement dans le settings.json afin d'apparaître comme du lua. Faire de même avec ```\directlua``` tant qu'à faire.

### Commande ```\chapitre```

- Permettre que la commande ```\chapitre``` puisse avoir deux arguments nuls (définition de chapitre à 0 si le numéro n'est pas spécifié)
- Désactivation de la commande ```\chapitre``` en cas de megadoc

### Paramètres par défaut

- Création des paramètres par défaut choisis par l'utilisateur en cas d'absence de paramétrage en début de document.
- Prédéfinition de paramètres personnalisés (monparam = TD initialise les booléens voulus à certaines valeurs par exemple)

## Extension VS Code / VS Codium

- Définir les commandes à ajouter/supprimer dans le panel
- Modifier les svg des icônes
- Modifier les snippets