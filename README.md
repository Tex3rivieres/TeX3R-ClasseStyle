# Tex3R

Tex3R est un travail collaboratif initié par @vcrombez et @fleothaud, visant à faciliter la présentation de cours de maths au collège. Ce travail comporte notamment :
- Une classe LaTeX (classe-tex3R.cls)
- Un style LaTeX associé (style-tex3R.sty)
- Une extension pour VS Code et VS Codium associée (nécessitant l'excellente extension latex-workshop)

Le projet n'est pas achevé (voir le dossier issues pour plus de détails)

Les nouveaux paramètres en début de document s'utilisent comme suit :

```latex
\documentclass{classe-tex3R}
\usepackage{style-tex3R}

\begin{luacode}

  -- Paramètres généraux du document
  Format = 'fiche'
  Type = 'cours'
  Impression = false
  Header = true
  Taille = nil

  -- Paramètres des environnements
  Correction = true
  Enonce = true
  Visible = true
  
  Competence = true
  Difficulte = false
  Source = true
  Theme = true

\end{luacode}

% Application des options
\parametrage

\begin{document}

\end{document}
 ```