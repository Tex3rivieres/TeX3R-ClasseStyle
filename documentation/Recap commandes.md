# Récapitulatif des commandes

## Lors de la rédaction de documents

```latex
  ///////////////
 // PRÉAMBULE //
///////////////

Au choix :
-----------------
\documentclass[fiche]{classe-tex3R}
\documentclass[diapo]{classe-tex3R}
\documentclass{classe-tex3R}
-----------------
\usepackage{style-tex3R}

-----------------

  //////////////
 // DOCUMENT //
//////////////

\definirniveau{texte}
\definirchapitre{nombre ou nil}{nom}

Au choix :
-----------------
\begin{luacode}
mesParametres('TD')
\end{luacode}
\parametrage

\begin{luacode}
Type = 'basique' -- 'activite' ; 'bilan' ; 'corrige' ; 'cours' ; 'DM' ; 'DS' ; 'flash' ; 'interro' ; 'TD'
Impression = true -- false
Header = true -- false
Taille = '14pt' -- nil
Stretch = true -- false

Correction = true -- false
Enonce = true -- false
Visible = true -- false

Competence = true -- false
Bareme = true -- false
Difficulte = true -- false
Source = true -- false
Theme = true -- false

\end{luacode}
\parametrage


\important{texte}

\sautligne
\sautdiapo
\sautfiche

\chapitre{Une part en LaTeX}
\partie{Une subsection en LaTeX}
\souspartie{Une subsubsection en LaTeX}

\bareme{texte}
\competence{texte}
\difficulte{nombre ou nil}
\source{texte}
\theme{texte}

\lignes{carreau/carreaux/surligne/seyes}{nombre ou nil}

\titre{texte}
\styleactif{\titre{texte}}
\titreactif

Au choix : 
----------------
\begin{visible}
  Visible si Visible = true
\end{visible}

\begin{visible}[true]
  Visible si Visible = true
\end{visible}
-----------------
\begin{visible}[false]
  Visible si Visible = false
\end{visible}

\begin{application}[Titre de remplacement ou nil]
  Contenu
\end{application}

\begin{definition}[Titre de remplacement ou nil]
  Contenu
\end{definition}

\begin{convention}[Titre de remplacement ou nil]
  Contenu
\end{convention}

\begin{exercice}[Titre de remplacement ou nil]
  Contenu
\end{exercice}

\begin{exemple}[Titre de remplacement ou nil]
  Contenu
\end{exemple}

\begin{methode}[Titre de remplacement ou nil]
  Contenu
\end{methode}

\begin{preuve}[Titre de remplacement ou nil]
  Contenu
\end{preuve}

\begin{propriete}[Titre de remplacement ou nil]
  Contenu
\end{propriete}

\begin{remarque}[Titre de remplacement ou nil]
  Contenu
\end{remarque}

\begin{enonce}[Titre de remplacement ou nil (si courstrue)]
  Contenu
\end{enonce}

\begin{correction}[Titre de remplacement ou nil (si courstrue)]
  Contenu
\end{correction}
```

## Pour personnaliser le style

```latex
\contenuchapitre
\contenuniveau

\contenubareme
\contenucompetence
\contenudifficulte
\contenutheme
\contenusource
```

## Commandes maths à rajouter 

```latex
$\geqslant$
$\leqslant$
$\perp$
$\in$
$\notin$
Remplacer x° : ^\circ par ° ou le supprimer carrément ?
Enlever les \mathrm ? Les utilise-t-on systématiquement ?  Les remplacer par \text ?
```

## Liste des booléens LaTeX 

```latex

%Booléens définis et initialisés par le parametrage LUA
\ifdiapo
\iffiche
\ifheader
\ifprint

\ifactivite
\ifbasique
\ifbilan
\ifcorrige
\ifcours
\ifTD
\ifflash
\ifDM
\ifDS
\ifinterro

\ifcorrection
\ifenonce
\ifvisible

\ifbareme
\ifdifficulte
\ifcompetence
\ifsource
\iftheme

\ifstretch

%Booléen pour appeler des exercices en subfile (pour empêcher le formatage de l'exercice et le saut de page)

\ifsubfile

%Booléens pour des réglages internes à la classe
\ifpartetoile
\ifmontre
\iftitretoc






```
