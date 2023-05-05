\NeedsTeXFormat{LaTeX2e}[2022-11-01]

\ProvidesClass{classe-rivieres}[21/03/2023|Classe rivieres|Voir la documentation pour plus d'informations]

\RequirePackage{silence}
  \WarningFilter{latex}{Label}%Désactive les Warning dûs à subfiles
  \WarningFilter{latex}{Unused global option}%Désactive les Warning dûs à l'emploi de l'option globale graine 
  \WarningFilter{lastpage}{Rerun to get}%Désactive les Warning dûs à lastpage

\LoadClass{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% VÉRIFICATION DE LA COMPILATION EN LUALATEX %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{iftex}
\ifluatex
\RequirePackage{luacode}
\else
\ClassError{Lualatex only}{This document can only be compiled with LuaLaTeX}{}\stop
\fi

\RequirePackage{shellesc}
\RequirePackage{etoolbox}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% OPTIONS DE CLASSE PERMETTANT DE FAIRE UNE COMPILATION SIMPLE A PARTIR D'UNE GRAINE %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifTDmultiple
\newif\ifcoursmultiple
\newif\ifflashmultiple
\newif\ifDSmultiple
\newif\ifmulti

\TDmultiplefalse
\coursmultiplefalse
\flashmultiplefalse
\DSmultiplefalse
\multifalse

\RequirePackage{xkeyval}

\DeclareOptionX{graine}{\newcommand{\conditionmacro}[0]{#1}}
\ProcessOptionsX\relax

\DeclareOption{diapo}{\newcommand{\conditionmacro}[0]{3}}
\DeclareOption{fiche}{\newcommand{\conditionmacro}[0]{2}}
\DeclareOption{multiTD}{\TDmultipletrue\multitrue}
\DeclareOption{multicours}{\coursmultipletrue\multitrue}
\DeclareOption{multiflash}{\flashmultipletrue\multitrue}
\DeclareOption{multiDS}{\DSmultipletrue\multitrue}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DÉFINITION DE LA COMMANDE RUNLUALATEX QUI PERMET DE LANCER UNE INVITE DE COMMANDE POUR EXECUTER UNE INSTANCE DE COMPILATION %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifx\conditionmacro\undefined
\newcommand{\runlualatex}[2]{%#1=nom du fichier ; #2=graine
\ShellEscape{%
  lualatex --interaction=nonstopmode --halt-on-error --shell-escape --jobname="\jobname-#1"
  "\gdef\string\conditionmacro{#2}\string\input\space\jobname"
}%
\ShellEscape{%
  lualatex --interaction=nonstopmode --halt-on-error --shell-escape --jobname="\jobname-#1"
  "\gdef\string\conditionmacro{#2}\string\input\space\jobname"
}%
\ShellEscape{%
  lualatex --interaction=nonstopmode --halt-on-error --shell-escape --jobname="\jobname-#1"
  "\gdef\string\conditionmacro{#2}\string\input\space\jobname"
}%
}%
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% EXÉCUTION DE PLUSIEURS COMPILATIONS EN FONCTION DE L'OPTION DE CLASSE %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifx\conditionmacro\undefined%pour l'option multiTD
  \ifTDmultiple
    \runlualatex{TD-fiche-enonce}{590}
    \runlualatex{TD-fiche-correction}{826}
    \runlualatex{TD-fiche-enonce-correction}{4130}
    \runlualatex{TD-diapo-enonce}{25665}
    \runlualatex{TD-diapo-enonce-correction-lignes}{4132065}
    \expandafter\stop
  \fi
  \ifcoursmultiple%pour l'option multicours
      \runlualatex{cours-fiche}{86}
      \runlualatex{cours-fiche-trame}{144394}
      \runlualatex{cours-diapo}{3741}
      \runlualatex{cours-diapo-trame}{86043}
      \expandafter\stop
  \fi
  \ifflashmultiple%pour l'option multiflash
    \runlualatex{flash-fiche-enonce}{28130}
    \runlualatex{flash-fiche-correction}{4528930}
    \runlualatex{flash-fiche-enonce-correction}{196910}
    \runlualatex{flash-diapo-enonce}{42195}
    \runlualatex{flash-diapo-enonce-correction}{295365}
    \expandafter\stop
  \fi
  \ifDSmultiple
  \runlualatex{DS-fiche-enonce}{148070}
  \runlualatex{DS-fiche-correction}{938}
  \expandafter\stop
\fi
  \def\conditionmacro{2}%si aucune option n'a été sélectionnée, type=fiche
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% CHARGEMENT DES PRINCIPAUX PACKAGES, POUR CHACUNE DES COMPILATIONS %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test

\RequirePackage[no-math]{fontspec}%
\RequirePackage{anyfontsize}
\RequirePackage[french]{babel}
\RequirePackage{enumitem}
\RequirePackage[np]{numprint}
\RequirePackage{subfiles}
\RequirePackage{environ}
\RequirePackage{ProfCollege}
\RequirePackage[export]{adjustbox}
\RequirePackage{pgf}
\tcbuselibrary{skins,breakable}
  \usetikzlibrary{arrows,calc,fit,patterns,plotmarks,shapes.geometric,shapes.misc,shapes.symbols,shapes.arrows,shapes.callouts, shapes.multipart, shapes.gates.logic.US,shapes.gates.logic.IEC, er, automata,backgrounds,chains,topaths,trees,petri,mindmap,matrix, calendar, folding,fadings,through,positioning,scopes,decorations.fractals,decorations.shapes,decorations.text,decorations.pathmorphing,decorations.pathreplacing,decorations.footprints,decorations.markings,shadows,babel}%Charge toutes les librairies de Tikz
\RequirePackage{pstricks}
\RequirePackage{pst-plot}
\RequirePackage{bookmark}
\RequirePackage{pdflscape}
\RequirePackage{tabularx}
\RequirePackage{listings}
\RequirePackage{calc}
\RequirePackage{tkz-fct,tkz-tab}
\RequirePackage{tkz-euclide}
\RequirePackage{amsmath,amsfonts,mathrsfs}
\RequirePackage{bbding}						
\RequirePackage[misc]{ifsym}
\RequirePackage{soul}	
\RequirePackage{cancel}		
\RequirePackage{url} 	
  \urlstyle{sf}         
\RequirePackage{fancybox}			
\RequirePackage{colortbl} 		
\RequirePackage{setspace}				
\RequirePackage{multirow}			
\RequirePackage{import}			
\RequirePackage[]{qrcode}
\RequirePackage{tikzsymbols}
\RequirePackage{tasks}
\RequirePackage{lastpage}
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}
\WarningsOff[scrlayer-scrpage]%Le package refuse d'avoir des en-têtes et pieds pages nuls, désactivation des Warnings du package
\RequirePackage[autoenlargeheadfoot=false]{scrlayer-scrpage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% COMMANDES ET BOOLÉENS UTILISÉS DANS STYLE-RIVIERES %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Commande modulo permettant d'initialiser les booléens

\begin{luacode}
  function rivmodulo(arg,mod)
      arg=arg%mod
      tex.sprint(math.floor(arg))
  end
\end{luacode}
  
\newcommand{\rivmodulo}[2]{\directlua{rivmodulo("#1","#2")}}

%Booléens

\newif\ifdiapo
\newif\iffiche
\newif\ifheader

\ifnum\rivmodulo{\conditionmacro}{2}=0 \fichetrue \else \fichefalse \fi
\ifnum\rivmodulo{\conditionmacro}{3}=0 \diapotrue \else \diapofalse \fi
\ifnum\rivmodulo{\conditionmacro}{29}=0 \headertrue \else \headerfalse \fi

%Longueurs pour les marges et polices du document

%Fiche
\newlength{\fichehaut}
\newlength{\fichebas}
\newlength{\fichedroite}
\newlength{\fichegauche}
\newlength{\fichetitre}
\newlength{\ficheseparationtitre}
\newlength{\fichepied}

%Diapo
\newlength{\diapohaut}
\newlength{\diapobas}
\newlength{\diapodroite}
\newlength{\diapogauche}
\newlength{\diapotitre}
\newlength{\diaposeparationtitre}

%Format de la page
\RequirePackage{geometry}
\iffiche%Pour les formats A4
    \geometry{
        paperwidth=21cm,
        paperheight=29.7cm,
    }%
    \newcommand{\formatfichetitre}{
        \newgeometry{
        top=\fichehaut,
        bottom=\fichebas,
        right=\fichedroite,
        left=\fichegauche,
        includehead,
        includefoot,
        marginparsep=0cm,
        marginparwidth=0cm,
        headheight=\fichetitre,
        headsep=\ficheseparationtitre,
        footskip=\fichepied
        }%
    }
    \newcommand{\formatfiche}{
        \newgeometry{
            top=\fichehaut,
            bottom=\fichebas,
            right=\fichedroite,
            left=\fichegauche,
            includehead,
            includefoot,
            marginparsep=0cm,
            marginparwidth=0cm,
            headheight=0cm,
            headsep=0cm,
            footskip=\fichepied
        }%
    }
    \newcommand{\formatdiapo}{}
    \newcommand{\formatdiapotitre}{}
    \ifheader
        \AtBeginDocument{\formatfichetitre}
    \else
        \AtBeginDocument{\formatfiche}
    \fi
\else
    \ifdiapo%Pour les diaporamas
        \geometry{
            paperwidth=28.8cm,
            paperheight=18cm
        }%
        \newcommand{\formatdiapotitre}{
            \newgeometry{
                top=\diapohaut,
                bottom=\diapobas,
                right=\diapodroite,
                left=\diapogauche,
                includehead,
                includefoot,
                marginparsep=0cm,
                marginparwidth=0cm,
                headheight=\diapotitre,
                headsep=\diaposeparationtitre,
                footskip=0cm
            }%
        }
        \newcommand{\formatdiapo}{
            \newgeometry{
                top=\diapohaut,
                bottom=\diapobas,
                right=\diapodroite,
                left=\diapogauche,
                includehead,
                includefoot,
                marginparsep=0cm,
                marginparwidth=0cm,
                headheight=0cm,
                headsep=0cm,
                footskip=0cm
            }%
        }
        \newcommand{\formatfiche}{}
        \newcommand{\formatfichetitre}{}
        \ifheader
            \AtBeginDocument{\formatdiapotitre}
        \else
            \AtBeginDocument{\formatdiapo}
        \fi
    \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DÉFINITION DES DIFFÉRENTES COMMANDES %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Commande tailletexte #1=niveau de taille du texte par rapport à 0 (remplace Large, LARGE, tiny etc)
\newcommand{\tailletexte}[1]{
    \ifnum#1=-4
        \tiny
    \else
        \ifnum#1=-3
            \scriptsize
        \else
            \ifnum#1=-2
            \footnotesize
            \else
                \ifnum#1=-1
                \small
                \else
                    \ifnum#1=0
                    \normalsize
                    \else
                        \ifnum#1=1
                        \large
                        \else
                            \ifnum#1=2
                            \Large
                            \else
                                \ifnum#1=3
                                \LARGE
                                \else
                                    \ifnum#1=4
                                    \huge
                                    \fi
                                \fi
                            \fi
                        \fi
                    \fi
                \fi
            \fi
        \fi
    \fi
}

\newcommand{\sautdeligne}{\vspace{\baselineskip}}

%Définition des booléens gérant l'affichage
\newif\ifenonce
\newif\ifcorrection
\newif\iftheme
\newif\ifdifficulte
\newif\ifcompetence
\newif\ifsource
\newif\ifbareme
\newif\ifdocumentation
\newif\ifactivite
\newif\ifbasique
\newif\ifbrevet
\newif\ifcorrige
\newif\ifcours
\newif\ifTD
\newif\ifflash
\newif\ifDM
\newif\ifDS
\newif\ifinterro

%Initialisation des booléens gérant l'affichage
\ifnum\rivmodulo{\conditionmacro}{5}=0 \enoncetrue \else \enoncefalse \fi
\ifnum\rivmodulo{\conditionmacro}{7}=0 \correctiontrue \else \correctionfalse \fi
\ifnum\rivmodulo{\conditionmacro}{11}=0 \themetrue \else \themefalse \fi
\ifnum\rivmodulo{\conditionmacro}{13}=0 \difficultetrue \else \difficultefalse \fi
\ifnum\rivmodulo{\conditionmacro}{17}=0 \competencetrue \else \competencefalse \fi
\ifnum\rivmodulo{\conditionmacro}{19}=0 \sourcetrue \else \sourcefalse \fi
\ifnum\rivmodulo{\conditionmacro}{107}=0 \baremetrue \else \baremefalse \fi
\ifnum\rivmodulo{\conditionmacro}{31}=0 \activitetrue \else \activitefalse \fi
\ifnum\rivmodulo{\conditionmacro}{37}=0 \basiquetrue \else \basiquefalse \fi
\ifnum\rivmodulo{\conditionmacro}{41}=0 \corrigetrue \else \corrigefalse \fi
\ifnum\rivmodulo{\conditionmacro}{43}=0 \courstrue \else \coursfalse \fi
\ifnum\rivmodulo{\conditionmacro}{59}=0 \TDtrue \else \TDfalse \fi
\ifnum\rivmodulo{\conditionmacro}{61}=0 \DMtrue \else \DMfalse \fi
\ifnum\rivmodulo{\conditionmacro}{67}=0 \DStrue \else \DSfalse \fi
\ifnum\rivmodulo{\conditionmacro}{71}=0 \interrotrue \else \interrofalse \fi
\ifnum\rivmodulo{\conditionmacro}{97}=0 \flashtrue \else \flashfalse \fi
\ifnum\rivmodulo{\conditionmacro}{109}=0 \brevettrue \else \brevetfalse \fi
\documentationfalse

%Définition et initialisation des compteurs
\newcounter{compteurfeuille}
  \setcounter{compteurfeuille}{1}
\newcounter{compteurDM}
  \setcounter{compteurDM}{0}
\newcounter{compteurDS}
  \setcounter{compteurDS}{0}
\newcounter{compteurinterro}
  \setcounter{compteurinterro}{0}
\newcounter{compteurexercice}
  \setcounter{compteurexercice}{0}
\newcounter{compteurbareme}
  \setcounter{compteurbareme}{0}
\newcounter{difficulte}
  \setcounter{difficulte}{0}

%Définition des commandes utilisées dans les environnements
\newcommand{\rivtheme}{}
\newcommand{\rivdifficulte}{\multido{\i=0+1}{\thedifficulte}{\faStar}}%
\newcommand{\rivcompetence}{}
\newcommand{\rivsource}{}
\newcommand{\rivrepere}{}

\newcommand{\theme}[1]{\renewcommand{\rivtheme}{#1}}
\newcommand{\difficulte}[1]{\setcounter{difficulte}{#1}}
\newcommand{\competence}[1]{\renewcommand{\rivcompetence}{#1}}
\newcommand{\source}[1]{\renewcommand{\rivsource}{#1}}
\newcommand{\repere}[1]{\renewcommand{\rivrepere}{#1}}

\newcommand{\rivchapitre}{}
\newcommand{\chapitre}[2]{\setcounter{part}{#1}\renewcommand{\rivchapitre}{#2}}
\newcommand{\rivniveau}{}
\newcommand{\niveau}[1]{\renewcommand{\rivniveau}{#1$^\text{ème}$}}
\newcommand{\feuille}[1]{\setcounter{compteurfeuille}{#1}}

%Commandes pour la mise en page de brevet

\def\monthyear{\ifcase\month\or
  Janvier\or Février\or Mars\or Avril\or Mai\or Juin\or
  Juillet\or Août\or Septembre\or Octobre\or Novembre\or Décembre\fi
  \space\number\year
}

\newwrite\myauxbrevet
\newcommand{\rivbareme}{}
\newcommand{\bareme}[1]{
  \renewcommand{\rivbareme}{#1 points}
  \ifbrevet
    \stepcounter{compteurbareme}
    \immediate\write\myauxbrevet{\string\hline}\relax
    \immediate\write\myauxbrevet{Exercice\thecompteurbareme\string & \rivbareme\string\\}\relax
  \fi
}


\AtEndDocument{
  \ifbrevet
    \immediate\write\myauxbrevet{\string\hline}\relax
    \immediate\write\myauxbrevet{\string\end{tabular}}\relax
    \immediate\closeout\myauxbrevet
  \fi
}

\newcommand{\rivtextebrevet}{}
\newcommand{\textebrevet}[1]{\renewcommand{\rivtextebrevet}{#1}}
\newcommand{\rivseriebrevet}{Générale}
\newcommand{\seriebrevet}[1]{\renewcommand{\rivseriebrevet}{#1}}

\newcommand{\titrebrevet}{
  \begin{center}
    \tailletexte{4}\bfseries BREVET BLANC
    
    \tailletexte{4}\bfseries \monthyear
    
    \sautdeligne
    
  \end{center}
  
  \begin{tcolorbox}[
    colframe = black, 
    colback=black!0,
    coltitle=white,
    sharp corners,
    valign=center,
    top=2cm,
    bottom=0.5cm,
    left=0.5cm,
    enhanced,
    before skip=0cm,
  ]
  \begin{center}
    \tailletexte{4}
    \textbf{ MATHÉMATIQUES}
    
    Série \rivseriebrevet
    
    \sautdeligne
    
    \tailletexte{0}
    
    Durée de l'épreuve : 2h00 \hfill 100 points
  \end{center}
  \end{tcolorbox}
  
  \vfill
  
  \begin{center}
    \tailletexte{0}
    Dès que le sujet vous est remis, assurez-vous qu’il est complet.
  
    %\sautdeligne
  
    Il comporte \textbf{\pageref{LastPage}} pages numérotées de la page \textbf{1} sur \textbf{\pageref{LastPage}} à la page \textbf{\pageref{LastPage}} sur \textbf{\pageref{LastPage}}.
  \end{center}
  
  \sautdeligne
  
  \begin{center}
    \tailletexte{0}
    L'usage de calculatrice avec mode examen actif est autorisé.
  
    %\sautdeligne
    
    L'usage de calculatrice sans mémoire << type collège >> est autorisé.
    
    %\sautdeligne
  
    L'usage du dictionnaire est interdit.
  \end{center}

  \sautdeligne

  \begin{center}
      \rivtextebrevet
  \end{center}
  
  
  \begin{center}
    \tailletexte{0}
    \tableaubrevet
  \end{center}
  
  \vfill
  
  \hfill
  
  \newpage
}

\RequirePackage{style-rivieres}

%Réglage de la persistance ou non du titre

\newcommand{\motcletitretoc}{}%Mot clé du titre pour la TOC
\newcommand{\renewmotcletitretoc}{%Renomme 
  \ifactivite
      \renewcommand{\motcletitretoc}{Activité} 
  \else
    \ifcorrige
      \renewcommand{\motcletitretoc}{Correction} 
    \else
      \ifcours
        \renewcommand{\motcletitretoc}{Cours} 
      \else
        \ifTD
          \renewcommand{\motcletitretoc}{Exercices} 
        \else
          \ifflash
            \renewcommand{\motcletitretoc}{Exercices} 
          \else
            \ifDM
              \renewcommand{\motcletitretoc}{DM} 
            \else
              \ifDS
                \renewcommand{\motcletitretoc}{DS} 
              \else
                \ifinterro
                  \renewcommand{\motcletitretoc}{Interrogation} 
                \else
                  \ifbrevet
                  \renewcommand{\motcletitretoc}{Brevet} 
                  \fi
                \fi
              \fi
            \fi
          \fi
        \fi
      \fi
    \fi
  \fi
}

\newcommand{\titretoc}{%Choisit le mot clé du titre et ajoute à la toc si c'est la première feuille d'une série ou la première page
\renewmotcletitretoc
    \phantomsection
    \addcontentsline{toc}{section}{\motcletitretoc}
}

\newcommand{\selectiontitre}{%Imprime le titre
  \ifactivite
      \titreactivite
  \else
    \ifcorrige
        \titrecorrige
    \else
      \ifcours
          \titrecours
      \else
        \ifTD
          \titreTD
        \else
          \ifflash
            \titreflash
          \else
            \ifDM
              \titreDM
            \else
              \ifDS
                \titreDS
              \else
                \ifinterro
                  \titreinterro
                \else
                  \ifbrevet
                    \titrebrevet
                  \fi
                \fi
              \fi
            \fi
          \fi
        \fi
      \fi
    \fi
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DÉFINITION DES ENVIRONNEMENTS LIGNES/LIGNES* %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{lineno}

%Booléen \ifFirstCompile permettant de savoir si on est à la première ou deuxième compilation

\newif\ifFirstCompile
\FirstCompiletrue

\makeatletter
\ifFirstCompile
\write\@auxout{\noexpand\global\noexpand\FirstCompilefalse}
\fi
\makeatother

% Définition des compteurs

\newcounter{ligneun}
\newcounter{lignedeux}
\newcounter{lignediff}
\newcounter{numerotation}
\setcounter{numerotation}{0}

%Définition des couleurs de lignes seyes

\colorlet{couleurligne}{SlateBlue}
\colorlet{couleurinterligne}{LightSteelBlue}

%Définition des booléens et initialisation

\newif\iflignes
\newif\ifseyes
\newif\ifsurligne
\newif\ifcarreaux
\newif\iflignesetoile
\newif\ifseyesetoile
\newif\ifsurligneetoile
\newif\ifcarreauxetoile

\ifnum\rivmodulo{\conditionmacro}{23}=0 \lignestrue \else \lignesfalse \fi
\ifnum\rivmodulo{\conditionmacro}{73}=0 \lignesetoiletrue \else \lignesetoilefalse \fi

\ifnum\rivmodulo{\conditionmacro}{83}=0 \seyestrue\carreauxfalse\surlignefalse \else \seyesfalse\carreauxtrue\surlignefalse \fi
\ifnum\rivmodulo{\conditionmacro}{101}=0 \seyesfalse\carreauxfalse\surlignetrue \else \seyesfalse\carreauxtrue\surlignefalse \fi

\ifnum\rivmodulo{\conditionmacro}{89}=0 \seyesetoiletrue\carreauxetoilefalse\surligneetoilefalse \else \seyesetoilefalse\carreauxetoiletrue\surligneetoilefalse \fi
\ifnum\rivmodulo{\conditionmacro}{103}=0 \seyesetoilefalse\carreauxetoilefalse\surligneetoiletrue \else \seyesetoilefalse\carreauxetoiletrue\surligneetoilefalse \fi

%Définition de la commande tracelignes #1=nombre de lignes

\newcommand{\tracelignes}[1]{
    \hfill\begin{tikzpicture}[x=\linewidth-0.8pt,y=0.2cm]
        \draw[color=couleurligne,line width=0.8pt] (0,4)--(1,4);
        \foreach \j in {1,...,#1}{
            \foreach \i in{1,2,3}{
                \draw[color=couleurinterligne,line width=0.5pt] (0,\i+4*\j)--(1,\i+4*\j);
            }
            \draw[color=couleurligne,line width=0.8pt] (0,4*\j+4)--(1,4*\j+4);
        }
    \end{tikzpicture}\hfill
}

%Définition de la commande tracecarreaux #1=nombre de lignes (2 carreaux par ligne)
\newcommand{\tracecarreaux}[1]{
    \hfill\begin{tikzpicture}
        \draw[xstep=0.5,ystep=0.5, color=blue!25] (0,0) grid (\linewidth-0.8pt,#1);
    \end{tikzpicture}\hfill
}

\newcommand{\tracesurligne}[1]{
  \begin{tikzpicture}[overlay]
    \foreach \i in {0,2,...,#1} {
    \fill [lightgray] ($(0,-0.15)+(0,-\i*\baselineskip)$) rectangle ($(0,-0.15)+(\linewidth,-\i*\baselineskip-\baselineskip)$);
    }
\end{tikzpicture}%
}

    %Définition de lignes
\NewEnviron{lignes}{
  \iflignes
      \ifFirstCompile
      \setcounter{ligneun}{\thelinenumber}
      \internallinenumbers
      \BODY\par
      \setcounter{lignedeux}{\thelinenumber}
      \setcounter{lignediff}{\thelignedeux-\theligneun+\theajoutlignes}
      \stepcounter{numerotation}
      \newcounter{bloc\number\thenumerotation}
      \setcounter{bloc\number\thenumerotation}{\thelignediff}
      \newwrite\myauxfile
          \immediate\openout\myauxfile=lignes\thenumerotation.aux\relax
          \immediate\write\myauxfile{\string\setcounter{bloc\number\thenumerotation}{\thelignediff}}\relax
          \immediate\closeout\myauxfile
      \else
        \stepcounter{numerotation}
        \newcounter{bloc\number\thenumerotation}
        \input{lignes\thenumerotation.aux}
        \ifsurligne
          \setcounter{ligneun}{\arabic{bloc\number\thenumerotation}-2}
          
         \tracesurligne{\theligneun}

          \vspace{-\baselineskip}

          \BODY
        \else
          \ifseyes \tracelignes{\arabic{bloc\number\thenumerotation}} \fi
          \ifcarreaux \tracecarreaux{\arabic{bloc\number\thenumerotation}} \fi
        \fi
      \fi
  \else
  \BODY
  \fi
  \setcounter{ajoutlignes}{0}
  }

  %Définition de lignes*
  \NewEnviron{lignes*}{
    \iflignesetoile
        \ifFirstCompile
        \setcounter{ligneun}{\thelinenumber}
        \internallinenumbers
        \BODY\par
        \setcounter{lignedeux}{\thelinenumber}
        \setcounter{lignediff}{\thelignedeux-\theligneun+\theajoutlignes}
        \stepcounter{numerotation}
        \newcounter{bloc\number\thenumerotation}
        \setcounter{bloc\number\thenumerotation}{\thelignediff}
        \newwrite\myauxfile
            \immediate\openout\myauxfile=lignes\thenumerotation.aux\relax
            \immediate\write\myauxfile{\string\setcounter{bloc\number\thenumerotation}{\thelignediff}}\relax
            \immediate\closeout\myauxfile
        \else
          \stepcounter{numerotation}
          \newcounter{bloc\number\thenumerotation}
          \input{lignes\thenumerotation.aux}
          \ifsurligneetoile
            \setcounter{ligneun}{\arabic{bloc\number\thenumerotation}-2}
            
           \tracesurligne{\theligneun}
  
            \vspace{-\baselineskip}
  
            \BODY
          \else
            \ifseyesetoile \tracelignes{\arabic{bloc\number\thenumerotation}} \fi
            \ifcarreauxetoile \tracecarreaux{\arabic{bloc\number\thenumerotation}} \fi
          \fi
        \fi
    \else
    \BODY
    \fi
    \setcounter{ajoutlignes}{0}
    }

%Définition de la commande ajoutlignes permettant d'ajuster au besoin le nombre de lignes générées par l'environnement lignes
\newcounter{ajoutlignes}
  \setcounter{ajoutlignes}{0}
\newcommand{\ajoutlignes}[1]{\setcounter{ajoutlignes}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DÉFINITION DE LA COMMANDE PARAMÈTRES QUI PERMET DE MODIFIER LES BOOLÉENS D'AFFICHAGE EN COURS DE DOCUMENT %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Définition des clés
\def\cleFaux{false}
\def\cleVrai{true}
\def\cleActivite{activite}
\def\cleBasique{basique}
\def\cleCorrige{corrige}
\def\cleCours{cours}
\def\cleTD{TD}
\def\cleDM{DM}
\def\cleDS{DS}
\def\cleFlash{flash}
\def\cleInterro{interro}
\def\cleBrevet{brevet}
\def\cleSeyes{seyes}
\def\cleCarreaux{carreaux}
\def\cleSurligne{surligne}

\newif\ifaffichagetitre
\affichagetitrefalse

%Définition et initialisation du trousseau
\makeatletter
\define@key{parametres}{titre}[true]{\def\choixheader{#1}}
\define@key{parametres}{enonce}[true]{\def\choixenonce{#1}}
\define@key{parametres}{bareme}[true]{\def\choixbareme{#1}}
\define@key{parametres}{correction}[true]{\def\choixcorrection{#1}}
\define@key{parametres}{theme}[true]{\def\choixtheme{#1}}
\define@key{parametres}{difficulte}[true]{\def\choixdifficulte{#1}}
\define@key{parametres}{competence}[true]{\def\choixcompetence{#1}}
\define@key{parametres}{source}[true]{\def\choixsource{#1}}
\define@key{parametres}{type}{\def\choixtype{#1}}
\define@key{parametres}{lignes}[true]{\def\choixlignes{#1}}
\define@key{parametres}{lignes*}[true]{\def\choixlignesetoile{#1}}

\makeatother

\newcommand{\parametresnormal}[1]{%Définition de paramètres, #1=liste de type clé=valeur (ou clé, si par défaut true)

  \ifnum\thepage=1
  \else
    \newpage
  \fi

  \setcounter{compteurfeuille}{1}
  \setcounter{compteurexercice}{0}

  \affichagetitrefalse

  \enoncefalse
  \correctionfalse

  \themefalse
  \difficultefalse
  \competencefalse
  \sourcefalse
  \baremefalse

  \activitefalse
  \basiquefalse
  \corrigefalse
  \coursfalse
  \TDfalse
  \DMfalse
  \DSfalse
  \interrofalse
  \flashfalse
  \brevetfalse

  \lignesfalse
  \seyesfalse
  \carreauxfalse
  \surlignefalse

  \lignesetoilefalse
  \seyesetoilefalse
  \carreauxetoilefalse
  \surligneetoilefalse

  \setcounter{ajoutlignes}{0}

  \setkeys{parametres}{#1}%

  \ifx \choixtype\cleBrevet
    \setlength{\fichepied}{0.5cm}
    \brevettrue
  \fi

  \ifbrevet 
  \ifFirstCompile
    \newcommand{\tableaubrevet}{}
    \immediate\openout\myauxbrevet=brevet.aux\relax
    \immediate\write\myauxbrevet{\string\begin{tabular}{|c|c|}}\relax
      % \makeatletter
      % \write\@auxout{\noexpand\global\noexpand\brevettrue}
      % \makeatother
  \else
    \newcommand{\tableaubrevet}{\input{brevet.aux}}
  \fi
\fi



  \ifx\choixheader\cleVrai%Load geometry en fonction de header
    \iffiche
      \formatfichetitre
      \affichagetitretrue
    \else
      \ifdiapo
        \formatdiapotitre
        \affichagetitretrue
      \fi
    \fi
  \else
    \iffiche
      \formatfiche
    \else
      \ifdiapo
        \formatdiapo
      \fi
    \fi
  \fi

  \ifx\choixenonce\cleVrai
  \enoncetrue
  \fi
  \ifx\choixcorrection\cleVrai
  \correctiontrue
  \fi

  \ifx\choixbareme\cleVrai
  \baremetrue
  \fi
  \ifx\choixtheme\cleVrai
  \themetrue
  \fi
  \ifx\choixdifficulte\cleVrai
  \difficultetrue
  \fi
  \ifx\choixcompetence\cleVrai
  \competencetrue
  \fi
  \ifx\choixsource\cleVrai
  \sourcetrue
  \fi

  \ifx\choixtype\cleActivite
      \activitetrue
  \else
      \ifx\choixtype\cleBasique
          \basiquetrue
      \else
          \ifx\choixtype\cleCorrige
              \corrigetrue
          \else
              \ifx\choixtype\cleCours
                  \courstrue
              \else
                  \ifx\choixtype\cleTD
                      \TDtrue
                  \else
                      \ifx\choixtype\cleDM
                          \DMtrue
                      \else
                          \ifx\choixtype\cleDS
                              \DStrue
                          \else
                              \ifx\choixtype\cleInterro
                                  \interrotrue
                              \else
                                \ifx\choixtype\cleFlash
                                    \flashtrue
                                    \else
                                      \ifx \choixtype\cleBrevet
                                        \brevettrue
                                        \else
                                          \basiquetrue
                                      \fi
                                  \fi
                              \fi
                          \fi
                      \fi
                  \fi
              \fi
          \fi
      \fi
  \fi

  \ifx\choixlignes\cleVrai
      \lignestrue
      \carreauxtrue
  \else
      \ifx\choixlignes\cleSeyes
          \lignestrue
          \seyestrue
      \else
          \ifx\choixlignes\cleCarreaux
              \lignestrue
              \carreauxtrue
          \else 
            \ifx\choixlignes\cleSurligne
              \lignestrue
              \surlignetrue
            \fi
          \fi
      \fi
  \fi

  \ifx\choixlignesetoile\cleVrai
    \lignesetoiletrue
    \carreauxetoiletrue
  \else
    \ifx\choixlignesetoile\cleSeyes
        \lignesetoiletrue
        \seyesetoiletrue
    \else
      \ifx\choixlignesetoile\cleCarreaux
          \lignesetoiletrue
          \carreauxetoiletrue
      \else
          \ifx\choixlignesetoile\cleSurligne
          \lignesetoiletrue
          \surligneetoiletrue
          \fi
      \fi
    \fi
  \fi

\titretoc
\ifaffichagetitre
  \setkomafont{pagehead}{\normalfont}
  \ohead{\selectiontitre}
  \cfoot{
    \ifbrevet
      \mdseries \textbf{\rivrepere} \hfill Page \textbf{\thepage{}} sur \pageref{LastPage}
    \fi
  }
\else
  \ohead{}
  \cfoot{
    \ifbrevet
      \mdseries \textbf{\rivrepere} \hfill Page \textbf{\thepage{}} sur \pageref{LastPage}
    \fi
  }
  \selectiontitre

  \iffiche
    \vspace{\ficheseparationtitre}
  \else
    \ifdiapo
      \vspace{\diaposeparationtitre}
    \fi
  \fi
\fi
}

%Parametresetoile

\newcommand{\parametresetoile}[1]{

\setkeys{parametres}{#1}%

\ifx\choixenonce\cleVrai
\enoncetrue
\else
\ifx\choixenonce\cleFaux
  \enoncefalse
\fi
\fi

\ifx\choixcorrection\cleVrai
\correctiontrue
\else
\ifx\choixcorrection\cleFaux
  \correctionfalse
\fi
\fi

\ifx\choixtheme\cleVrai
\themetrue
\else
\ifx\choixtheme\cleFaux
  \themefalse
\fi
\fi

\ifx\choixdifficulte\cleVrai
\difficultetrue
\else
\ifx\choixdifficulte\cleFaux
  \difficultefalse
\fi
\fi

\ifx\choixcompetence\cleVrai
\competencetrue
\else
\ifx\choixcompetence\cleFaux
  \competencefalse
\fi
\fi

\ifx\choixsource\cleVrai
\sourcetrue
\else
\ifx\choixsource\cleFaux
  \sourcefalse
\fi
\fi

\ifx\choixbareme\cleVrai
\baremetrue
\else
\ifx\choixbareme\cleFaux
  \baremefalse
\fi
\fi

\ifx\choixlignes\cleVrai
\lignestrue
\carreauxtrue
\seyesfalse
\surlignefalse
\else
  \ifx\choixlignes\cleSeyes
    \lignestrue
    \seyestrue
    \carreauxfalse
    \surlignefalse
  \else
    \ifx\choixlignes\cleCarreaux
        \lignestrue
        \carreauxtrue
        \seyesfalse
        \surlignefalse
    \else
      \ifx \choixlignes\cleSurligne
        \lignestrue
        \carreauxfalse
        \seyesfalse
        \surlignetrue
      \else
        \ifx\choixlignes\cleFaux
        \lignesfalse
        \seyesfalse
        \carreauxtrue
        \surlignefalse
        \fi
      \fi
    \fi
  \fi
\fi

\ifx\choixlignesetoile\cleVrai
\lignesetoiletrue
\carreauxetoiletrue
\seyesetoilefalse
\surligneetoilefalse
\else
  \ifx\choixlignesetoile\cleSeyes
    \lignesetoiletrue
    \seyesetoiletrue
    \carreauxetoilefalse
    \surligneetoilefalse
  \else
    \ifx\choixlignesetoile\cleCarreaux
        \lignesetoiletrue
        \seyesetoilefalse
        \carreauxetoiletrue
        \surligneetoilefalse
    \else
      \ifx\choixligneetoiles\cleSurligne
        \lignesetoiletrue
        \seyesetoilefalse
        \carreauxetoilefalse
        \surligneetoiletrue
      \else
        \ifx\choixlignesetoile\cleFaux
          \lignesetoilefalse
          \seyesetoilefalse
          \carreauxetoiletrue
          \surligneetoilefalse
        \fi
      \fi
    \fi
  \fi
\fi
}

\ifmulti
  \def\parametres#1{}
\else
  \makeatletter
  \def\parametres{\@ifstar\parametresetoile\parametresnormal}
  \makeatother
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% RÉGLAGES DE LA TOC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{atbegshi}

\AtBeginShipout{\stepcounter{compteurfeuille}}

\newif\ifmegadoctoc
  \megadoctocfalse

\newif\ifmegadoc
  \megadocfalse

  \ifnum\conditionmacro=2
    \megadoctrue
  \else
    \ifnum\conditionmacro=3
      \megadoctrue
    \else 
      \ifnum\conditionmacro=158
        \megadoctoctrue
      \else
        \ifnum\conditionmacro=237
          \megadoctoctrue
        \fi
      \fi
    \fi
  \fi

\ifmegadoc

\else
  \ifmegadoctoc
    \AtBeginDocument{\tableofcontents}
  \else
    \iffiche
      \ifheader
        \setkomafont{pagehead}{\normalfont}
        \ohead{\selectiontitre}
        \cfoot{}
        \AtBeginDocument{\titretoc\pagestyle{scrheadings}}
      \else
        \ohead{}
        \cfoot{}
        \AtBeginDocument{\pagestyle{scrheadings}\titretoc\selectiontitre}
      \fi
    \else
      \ifdiapo
        \ifheader
          \setkomafont{pagehead}{\normalfont}
          \ohead{\selectiontitre}
          \cfoot{
            \ifbrevet
              \mdseries \textbf{\rivrepere} \hfill Page \textbf{\thepage{}} sur \pageref{LastPage}
            \fi
            }
          \AtBeginDocument{\titretoc\pagestyle{scrheadings}}
        \else
          \ohead{}
          \cfoot{
            \ifbrevet
              \mdseries \textbf{\rivrepere} \hfill Page \textbf{\thepage{}} sur \pageref{LastPage}
            \fi
            }
          \AtBeginDocument{\pagestyle{scrheadings}\titretoc\selectiontitre}
        \fi
      \fi
    \fi
  \fi
\fi
