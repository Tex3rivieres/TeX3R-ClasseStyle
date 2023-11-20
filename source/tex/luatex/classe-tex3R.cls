\NeedsTeXFormat{LaTeX2e}[2022-11-01]

\ProvidesClass{classe-tex3R}[19/11/2023 - Version 2.0 de la classe-tex3R]

\LoadClass{scrartcl}%Classe KOMA-SCRIPT
\PassOptionsToPackage{table,svgnames}{xcolor}

\RequirePackage{iftex}
\ifluatex
  \RequirePackage{luacode}
\else
  \ClassError{Lualatex only}{Ce document doit êtres compilé en LuaLaTeX}{}\stop
\fi

%Formatage de la page et du texte
\RequirePackage{geometry}
\RequirePackage{silence}
\RequirePackage[np]{numprint}

\RequirePackage{pstricks}
\RequirePackage{pst-plot}
\RequirePackage{pst-eucl}
\let\clipbox\undefined
%La commande clipbox de pstricks n'est plus définie : attention à son utilisation
\RequirePackage[export]{adjustbox}

\RequirePackage{xcolor}
\RequirePackage{fontspec}
\RequirePackage{anyfontsize}
\RequirePackage[french]{babel}
\RequirePackage{enumitem}
\RequirePackage{tasks}

%Formatages divers
\RequirePackage{fontawesome5}
\RequirePackage[minimal]{lua-ul}
\RequirePackage{soul}
\RequirePackage{tcolorbox}
  \tcbuselibrary{skins,breakable}
\RequirePackage{environ}
\RequirePackage[autoenlargeheadfoot=false]{scrlayer-scrpage}
\RequirePackage{bookmark}

\RequirePackage{etoolbox}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{subfiles}

\RequirePackage{ProfCollege}
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}
\let\oldusetikzlibrary\usetikzlibrary
\renewcommand{\usetikzlibrary}[1]{%
  \ifstrequal{#1}{bending}{}{\oldusetikzlibrary{#1}}%
}
\RequirePackage{scratch3}
\catcode`\_11
\renewcommand{\turn_arrow}[1]{%
\tikz[baseline=.25ex,x=6.5ex,y=6.5ex,#1]
\draw[-{Triangle[angle=110:0.6ex 0.15ex]},line width=.3333ex](0,0) arc[start angle=-80,end angle=190,radius=1ex];%
}
\scr_restorecatcode

\RequirePackage{pgf}
\RequirePackage{pgfplots}
  \pgfplotsset{compat=1.13}
  \usetikzlibrary{arrows,calc,fit,patterns,plotmarks,shapes.geometric,shapes.misc,shapes.symbols,shapes.arrows,shapes.callouts, shapes.multipart, shapes.gates.logic.US,shapes.gates.logic.IEC, er, automata,backgrounds,chains,topaths,trees,petri,mindmap,matrix, calendar, folding,fadings,through,positioning,scopes,decorations.fractals,decorations.shapes,decorations.text,decorations.pathmorphing,decorations.pathreplacing,decorations.footprints,decorations.markings,shadows,babel}%Charge toutes les librairies de Tikz
 


\RequirePackage{pdflscape}
\RequirePackage{tabularx}
\RequirePackage{listings}

\RequirePackage{tkz-fct,tkz-tab}
\RequirePackage{tkz-euclide}

\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{mathrsfs}	
\RequirePackage{bbding}						
\RequirePackage[misc]{ifsym}
\RequirePackage{cancel}
\RequirePackage{url} 	      
\RequirePackage{fancybox}	
\RequirePackage{colortbl}
\RequirePackage{setspace}	
\RequirePackage{multirow}	
\RequirePackage{import}
\RequirePackage[]{qrcode}
\RequirePackage{tikzsymbols}
\RequirePackage{ccicons}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SUPPRESSIONS DE WARNINGS ABUSIFS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\WarningsOff[scrlayer-scrpage]


%%%%%%%%%%%%%%%%%%%%%%
% BOOLÉENS DU FORMAT %
%%%%%%%%%%%%%%%%%%%%%%

\newif\ifdiapo
\newif\iffiche
\newif\ifheader
\newif\ifprint

\begin{luacode}
  PARAMETRES = {}
--Formatage de la page d'après les paramètres utilisateurs
  function FormatDocument(PAGE,PARAMETRES)

    local HEADER = PARAMETRES.header
    local FORMAT = PARAMETRES.format
    local PRINT = PARAMETRES.print

    tex.sprint(
      '\\setlength{\\parindent}{' .. PAGE.parindent ..'}' ..
      '\\setlength{\\parskip}{' .. PAGE.parskip ..'}' ..
      '\\frenchbsetup{ItemLabeli=' .. PAGE.itemi .. '}' ..
      '\\frenchbsetup{ItemLabelii=' .. PAGE.itemii ..'}' ..
      '\\setlist[enumerate,1]{label=' .. PAGE.enumi .. '}' ..
      '\\setlist[enumerate,2]{label=' .. PAGE.enumii .. '}' ..
      '\\DeclareInstance{tasks}{enumerate}{default}{label =' .. PAGE.enumi .. ',label-width=1.125em}' ..
      '\\DeclareInstance{tasks}{itemize}{default}{label = ' .. PAGE.itemi .. ',label-width=1.125em}' ..
      '\\renewcommand*{\\sectionformat}{' .. PAGE.sectionnumber .. '}' ..
      '\\renewcommand*{\\subsectionformat}{' .. PAGE.subsectionnumber .. '}' ..
      '\\renewcommand*{\\subsubsectionformat}{' .. PAGE.subsubsectionnumber .. '}' ..
      '\\setkomafont{section}{' .. PAGE.sectionname .. '}' ..
      '\\setkomafont{subsection}{' .. PAGE.subsectionname .. '}' ..
      '\\setkomafont{subsubsection}{' .. PAGE.subsubsectionname .. '}' ..
      '\\renewcommand*{\\sectionlinesformat}[4]{' .. PAGE.sectionsformat .. '}'
    )

    if FORMAT =='fiche' then
      tex.sprint('\\fichetrue')
    elseif FORMAT == 'diapo' then
      tex.sprint('\\diapotrue')
    end

    if HEADER then
      tex.sprint('\\headertrue')
      tex.sprint(
      '\\setkomafont{pagehead}{\\normalfont}' ..
      '\\ihead{\\vspace*{-1em}{\\titreactif}}' ..
        '\\ohead{}' ..
        '\\chead{}' ..        
        '\\ofoot{}' .. 
        '\\cfoot{}' ..         
        '\\ifoot{}'
      )
    else
      tex.sprint(
        '\\setkomafont{pagehead}{\\normalfont}' ..
        '\\ihead{}' ..
        '\\ohead{}' ..
        '\\chead{}' ..        
        '\\ofoot{}' .. 
        '\\cfoot{}' ..         
        '\\ifoot{}' 
      )
    end

    if PRINT then
      tex.sprint('\\printtrue')
    end

    tex.sprint('\\geometry{paperwidth=' .. PAGE.width .. ',paperheight=' .. PAGE.height ..'}')

    tex.sprint(
      '\\gdef\\FormatPage{' ..
        '\\newgeometry{' ..
          'top=' .. PAGE.top ..
          ',bottom=' .. PAGE.bottom ..
          ',right=' .. PAGE.right ..
          ',left=' .. PAGE.left ..
          ',includehead' ..
          ',includefoot' ..
          ',marginparsep=' .. PAGE.marginparsep ..
          ',marginparwidth=' .. PAGE.marginparwidth ..
          ',headheight=' .. PAGE.headheight ..
          ',headsep=' .. PAGE.headsep ..
          ',footskip=' .. PAGE.footskip ..
        '}' ..
      '}'
    )
    tex.sprint('\\AtBeginDocument{\\FormatPage}')

    if not HEADER then
      tex.sprint('\\AtBeginDocument{\\titreactif}')
      -- Chargement police se fait après
    end
  end
\end{luacode}


%%%%%%%%%%%%%%%%%%%
% AUTRES BOOLÉENS %
%%%%%%%%%%%%%%%%%%%

%type
\newif\ifactivite
\newif\ifbasique
\newif\ifbilan
\newif\ifcorrige
\newif\ifcours
\newif\ifTD
\newif\ifflash
\newif\ifDM
\newif\ifDS
\newif\ifinterro

\newif\ifcorrection
\newif\ifenonce
\newif\ifvisible

\newif\ifdifficulte
\newif\ifcompetence
\newif\ifsource
\newif\iftheme

\newif\ifstretch

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FONCTION LUA REMPLAÇANT L'ANCIENNE FONCTION TEX PARAMETRE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode*}
function BooleensDocument(PARAMETRES) -- PARAMETRES liste stockant tous les paramètres
  -- tex.sprint(
  --   '\\activitefalse' ..
  --   '\\basiquefalse' ..
  --   '\\bilanfalse' ..
  --   '\\corrigefalse' ..
  --   '\\coursfalse' ..
  --   '\\flashfalse' ..
  --   '\\TDfalse' ..
  --   '\\DMfalse' ..
  --   '\\DSfalse' ..
  --   '\\interrofalse' ..
  --   '\\flashfalse'
  -- )

  if PARAMETRES.type == 'activite' then
    tex.sprint('\\activitetrue')
  elseif PARAMETRES.type == 'basique' then
    tex.sprint('\\basiquetrue')
  elseif PARAMETRES.type == 'bilan' then
    tex.sprint('\\bilantrue')
  elseif PARAMETRES.type == 'corrige' then
    tex.sprint('\\corrigetrue')
  elseif PARAMETRES.type == 'cours' then
    tex.sprint('\\courstrue')
  elseif PARAMETRES.type == 'flash' then
    tex.sprint('\\flashtrue')
  elseif PARAMETRES.type == 'TD' then
    tex.sprint('\\TDtrue')
  elseif PARAMETRES.type == 'DM' then
    tex.sprint('\\DMtrue')
      elseif PARAMETRES.type == 'DS' then
    tex.sprint('\\DStrue')
  elseif PARAMETRES.type == 'interro' then
    tex.sprint('\\interrotrue')
  end

  if PARAMETRES.correction then
    tex.sprint('\\correctiontrue')
  end
  if PARAMETRES.enonce then
    tex.sprint('\\enoncetrue')
  end
    if PARAMETRES.visible then
    tex.sprint('\\visibletrue')
  end

  if PARAMETRES.competence then
    tex.sprint('\\competencetrue')
  end
  if PARAMETRES.difficulte then
    tex.sprint('\\difficultetrue')
  end
  if PARAMETRES.source then
    tex.sprint('\\sourcetrue')
  end
  if PARAMETRES.theme then
    tex.sprint('\\themetrue')
  end

  if PARAMETRES.stretch then
    tex.sprint('\\stretchtrue')
  end
end
\end{luacode*}

%%%%%%%%%%%%%
% COMPTEURS %
%%%%%%%%%%%%%

%Création
\newcounter{compteurfeuille}

\newcounter{compteurenonce}
\newcounter{compteurcorrection}

\newcounter{compteurinterro}
\newcounter{compteurflash}
\newcounter{compteurDM}
\newcounter{compteurDS}
\newcounter{compteurTD}

%Initialisation
\setcounter{compteurfeuille}{1}

\setcounter{compteurenonce}{0}
\setcounter{compteurcorrection}{0}

\setcounter{compteurinterro}{0}
\setcounter{compteurflash}{0}
\setcounter{compteurDM}{0}
\setcounter{compteurDS}{0}
\setcounter{compteurTD}{0}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMANDES PERSONNELLES %
%%%%%%%%%%%%%%%%%%%%%%%%%%

%Commandes de mise en page
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

\newcommand{\important}[1]{}

\newcommand{\sautdeligne}{\vspace{\baselineskip}}
\newcommand{\sautdiapo}{\ifdiapo \newpage \fi}
\newcommand{\sautfiche}{\iffiche \newpage \fi}

%Commandes des environnements
%
\newcommand{\contenuchapitre}{}
\newcommand{\contenuniveau}{}

\newcommand{\contenucompetence}{}
\newcommand{\contenudifficulte}{}
\newcommand{\contenusource}{}
\newcommand{\contenutheme}{}

\newcommand{\contenurepere}{}

%
\begin{luacode}
  function Difficulte(nombre)
    if nombre then
      for i=1,nombre do
        tex.sprint('\\faStar')
      end
    end
  end

  function Chapitre(nombre)
    if nombre then
      tex.sprint('\\setcounter{part}{#1}')
    end
  end
\end{luacode}


\newcommand{\chapitre}[2]{\directlua{#1}\renewcommand{\contenuchapitre}{#2}}
\newcommand{\niveau}[1]{\renewcommand{\contenuniveau}{#1}}

\newcommand{\competence}[1]{\renewcommand{\contenucompetence}{#1}}
\newcommand{\difficulte}[1]{\renewcommand{\contenudifficulte}{\directlua{Difficulte(#1)}}}
\newcommand{\source}[1]{\renewcommand{\contenusource}{#1}}
\newcommand{\theme}[1]{\renewcommand{\contenutheme}{#1}}

\newcommand{\repere}[1]{\renewcommand{\contenurepere}{#1}}

%Commandes de lignes
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

\newcommand{\tracecarreaux}[1]{
  \hfill\begin{tikzpicture}
      \draw[xstep=0.5,ystep=0.5, color=couleurcarreau] (0,0) grid (\linewidth-0.8pt,#1);
  \end{tikzpicture}\hfill
}

\newcommand{\tracesurligne}[1]{%
  \begin{tikzpicture}[overlay]
    \foreach \i in {0,2,...,#1} {%
    \fill [couleursurlignelignea] ($(0,-0.15)+(0,-\i*\baselineskip)$) rectangle ($(0,-0.15)+(\linewidth,-\i*\baselineskip-\baselineskip)$);
    \fill [couleursurligneligneb] ($(0,-0.15)+(0,-\i*\baselineskip-\baselineskip)$) rectangle ($(0,-0.15)+(\linewidth,-\i*\baselineskip-2\baselineskip)$);
    }%
\end{tikzpicture}%
}%


%Nouveau soulignement pour le titre, utilisant lua-ul
\newunderlinetype\beginUnderLine{\cleaders\hbox{%
  \setlength\unitlength{.1ex}%
  \begin{picture}(4,0)(0,1)
    \thicklines
    \put(0,-4){\line(1,0){4}}
    \put(0,-4.5){\line(1,0){4}}
  \end{picture}%
}}

\NewDocumentCommand\underLine{+m}{{\beginUnderLine#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DÉFINITION DES COULEURS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode}
  function CouleursDocument(COULEURS)

    tex.sprint(
      '\\colorlet{couleurligne}{' .. COULEURS.ligne .. '}' ..
      '\\colorlet{couleurinterligne}{' .. COULEURS.interligne .. '}' ..
      '\\colorlet{couleursection}{' .. COULEURS.section .. '}' ..
      '\\colorlet{couleursubsection}{' .. COULEURS.subsection .. '}' ..
      '\\colorlet{couleursubsubsection}{' .. COULEURS.subsubsection .. '}' ..
      '\\colorlet{couleurcarreau}{' .. COULEURS.carreau .. '}' ..
      '\\colorlet{couleursurlignelignea}{' .. COULEURS.surlignelignea .. '}' ..
      '\\colorlet{couleursurligneligneb}{' .. COULEURS.surligneligneb .. '}' ..
      '\\colorlet{couleurboitecours}{' .. COULEURS.boitecours .. '}' ..
      '\\colorlet{couleurbackground}{' .. COULEURS.background .. '}' ..
      '\\colorlet{couleurapplication}{' .. COULEURS.application .. '}' ..
      '\\colorlet{couleurdefinition}{' .. COULEURS.definition .. '}' ..
      '\\colorlet{couleurconvention}{' .. COULEURS.convention .. '}' ..
      '\\colorlet{couleurexercice}{' .. COULEURS.exercice .. '}' ..
      '\\colorlet{couleurexemple}{' .. COULEURS.exemple .. '}' ..
      '\\colorlet{couleurmethode}{' .. COULEURS.methode .. '}' ..
      '\\colorlet{couleurpreuve}{' .. COULEURS.preuve .. '}' ..
      '\\colorlet{couleurpropriete}{' .. COULEURS.propriete .. '}' ..
      '\\colorlet{couleurremarque}{' .. COULEURS.remarque .. '}' ..
      '\\colorlet{couleurenonce}{' .. COULEURS.enonce .. '}' ..
      '\\colorlet{couleurcorrection}{' .. COULEURS.correction .. '}' ..
      '\\colorlet{couleursurligne}{' .. COULEURS.surligne .. '}' ..
      '\\colorlet{rouge}{' .. COULEURS.rouge .. '}' ..
      '\\colorlet{vert}{' .. COULEURS.vert .. '}' ..
      '\\colorlet{bleu}{' .. COULEURS.bleu .. '}'
    )

    tex.sprint('\\sethlcolor{couleursurligne}')

  end 
\end{luacode}

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FORMATAGES DIVERS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode}
  function PoliceDocument(POLICE,PARAMETRES)
    local TAILLE = PARAMETRES.taille
    local FORMAT = PARAMETRES.format

    if TAILLE == nil then
      if FORMAT == 'fiche' then
        tex.sprint('\\KOMAoption{fontsize}{'.. POLICE.taillefiche ..'}')
      elseif FORMAT == 'diapo' then
        tex.sprint('\\KOMAoption{fontsize}{'.. POLICE.taillediapo ..'}')
      end
    else
      tex.sprint('\\KOMAoption{fontsize}{' .. TAILLE ..'}')
    end
    tex.sprint('\\renewcommand{\\important}[1]{'.. POLICE.important ..'}')

  tex.sprint(
    '\\IfFontExistsTF{' .. POLICE.texte ..'}{\\setmainfont{' .. POLICE.texte .. '}}\\n' ..
    '\\IfFontExistsTF{' .. POLICE.math .. '}{\\setmathfont{' .. POLICE.math .. '}}{}' ..
    '\\IfFontExistsTF{' .. POLICE.mathcal .. '}{\\setmathfont{' .. POLICE.mathcal .. '}[range=cal]}{}'
  )
  end
\end{luacode}

\newfontfamily\myfontScratch{FreeSans}%Pour les blocs Scratch de ProfCollege
\AtBeginEnvironment{scratch}{\KOMAoption{fontsize}{12pt}}%Scaling plutôt que taille de police

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CRÉATION DES LOGOS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\logoactif}{}

\begin{luacode}
  function LogosDocument(PARAMETRES,LOGOS)

    local TYPE = PARAMETRES.type

    if TYPE == 'activite' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.activite ..'}')
    elseif TYPE == 'basique' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.basique ..'}')
    elseif TYPE == 'bilan' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.bilan ..'}')
    elseif TYPE == 'corrige' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.corrige ..'}')
    elseif TYPE == 'cours' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.cours ..'}')
    elseif TYPE == 'DM' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.DM ..'}')
    elseif TYPE == 'DS' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.DS ..'}')
    elseif TYPE == 'flash' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.flash ..'}')
    elseif TYPE == 'interro' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.interro ..'}')
    elseif TYPE == 'TD' then
      tex.sprint('\\renewcommand{\\logoactif}{' .. LOGOS.TD ..'}')
    end
  end
\end{luacode}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CRÉATION DES TITRES %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\titre}[1]{}
\newcommand{\titreactif}[1]{}
\newcommand{\styleactif}[1]{}
\newcommand{\stylesections}[3]{}

\begin{luacode}
  function StylesTitresDocument(PARAMETRES,STYLESTITRES)

    local TYPE = PARAMETRES.type
    local HEADER = PARAMETRES.header

    if HEADER then
      tex.sprint('\\renewcommand{\\titre}[1]{'.. STYLESTITRES.titre ..'}')
    else
      tex.sprint('\\renewcommand{\\titre}[1]{'.. STYLESTITRES.titre .. '\\vspace{' .. STYLESTITRES.espacement ..'}}')
    end

    if TYPE == 'activite' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.activite ..'}')
    elseif TYPE == 'basique' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.basique ..'}')
    elseif TYPE == 'bilan' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.bilan ..'}')
    elseif TYPE == 'corrige' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.corrige ..'}')
    elseif TYPE == 'cours' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.cours ..'}')
    elseif TYPE == 'DM' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.DM ..'}')
    elseif TYPE == 'DS' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.DS ..'}')
    elseif TYPE == 'flash' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.flash ..'}')
    elseif TYPE == 'interro' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.interro ..'}')
    elseif TYPE == 'TD' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' .. STYLESTITRES.TD ..'}')
    end
  end
\end{luacode}

\begin{luacode}
  function TitresDocument(TITRE)
    tex.sprint('\\renewcommand{\\titreactif}{\\styleactif{' .. TITRE .. '}}')
  end
\end{luacode}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ENVIRONNEMENT ET COMMANDE VISIBLE %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifvisible

\begin{luacode}

function VerificationVisible(FLAG,PARAMETRES)
  local VISIBLE = tostring(PARAMETRES.visible)

  if FLAG == VISIBLE then
    tex.sprint('\\visibletrue')
  else
    tex.sprint('\\visiblefalse')
  end
end

\end{luacode}


\NewEnviron{visible*}[1][true]{%
  \directlua{VerificationVisible('#1',PARAMETRES)}
  \ifvisible
    \BODY
  \fi
}

\newcommand{\visible}[2][true]{%
  \directlua{VerificationVisible('#1',PARAMETRES)}
  \ifvisible
    #2
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ENVIRONNEMENTS DE COURS ET EXERCICES %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\formatEnvCours}[2][]{}

\NewEnviron{application}[1][]{\BODY}
\NewEnviron{definition}[1][]{\BODY}
\NewEnviron{convention}[1][]{\BODY}
\NewEnviron{exercice}[1][]{\BODY}
\NewEnviron{exemple}[1][]{\BODY}
\NewEnviron{methode}[1][]{\BODY}
\NewEnviron{preuve}[1][]{\BODY}
\NewEnviron{propriete}[1][]{\BODY}
\NewEnviron{remarque}[1][]{\BODY}

\NewEnviron{correction}[1][]{\BODY}
\NewEnviron{enonce}[1][]{\BODY}

\begin{luacode*}
  function EnvironnementsDocument(ENVIRONNEMENTS)
    ENVIRONNEMENTS.formatcours = string.gsub(ENVIRONNEMENTS.formatcours, "\n", "")
    ENVIRONNEMENTS.enonce = string.gsub(ENVIRONNEMENTS.enonce, "\n", "")
    ENVIRONNEMENTS.correction = string.gsub(ENVIRONNEMENTS.correction, "\n", "")

    tex.sprint('\\renewcommand{\\formatEnvCours}[2][]{\\ifstretch\\vfill\\fi'.. ENVIRONNEMENTS.formatcours ..'}')
    tex.sprint('\\RenewEnviron{enonce}{\\stepcounter{compteurcorrection}\\ifenonce\\ifstretch\\vfill\\fi\\stepcounter{compteurenonce}' .. ENVIRONNEMENTS.enonce .. '\\fi}' )
    tex.sprint('\\RenewEnviron{correction}{\\ifcorrection\\ifstretch\\vfill\\fi' .. ENVIRONNEMENTS.correction .. '\\fi}' )

    tex.sprint([[\RenewEnviron{application}[1][Application]{\formatEnvCours[#1]{couleurapplication}}]])
    tex.sprint([[\RenewEnviron{definition}[1][Définition]{\formatEnvCours[#1]{couleurdefinition}}]])
    tex.sprint([[\RenewEnviron{convention}[1][Convention]{\formatEnvCours[#1]{couleurconvention}}]])
    tex.sprint([[\RenewEnviron{exercice}[1][Exercice]{\formatEnvCours[#1]{couleurexercice}}]])
    tex.sprint([[\RenewEnviron{exemple}[1][Exemple]{\formatEnvCours[#1]{couleurexemple}}]])
    tex.sprint([[\RenewEnviron{methode}[1][Méthode]{\formatEnvCours[#1]{couleurmethode}}]])
    tex.sprint([[\RenewEnviron{preuve}[1][Preuve]{\formatEnvCours[#1]{couleurpreuve}}]])
    tex.sprint([[\RenewEnviron{propriete}[1][Propriété]{\formatEnvCours[#1]{couleurpropriete}}]])
    tex.sprint([[\RenewEnviron{remarque}[1][Remarque]{\formatEnvCours[#1]{couleurremarque}}]])
  end
\end{luacode*}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CRÉATION DU TITRE SELON LE HEADER %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \begin{luacode}
%   function TitreDocument(PARAMETRES)
%     local HEADER = PARAMETRES.header

%     -- tex.sprint('\\AtBeginDocument{\\titreactif}')
%     if HEADER then
%     -- tex.sprint('\\AddToHook{shipout/after}{TEST}')
%     end
%   end
% \end{luacode}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% COMMANDES DE COMPATIBILITÉ AVEC LA VERSION 1.0 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewEnviron{lignes}{\BODY}
\NewEnviron{lignes*}{\BODY}
\newcommand{\rivcorrection}[2]{\ifvisible #1 \else #2 \fi}
\newcommand{\rivimportant}[1]{\important{#1}}
\newcommand{\ajoutlignes}[1]{}
\providecommand{\adjustbox}[2]{#2}
\newcommand{\parametres}[1]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% COMMANDE PARAMETRAGE PERMETTANT DE MODIFIER LES OPTIONS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\parametrage}{
  \directlua{
  PARAMETRES.format = Format
  PARAMETRES.type = Type
  PARAMETRES.print = Impression
  PARAMETRES.header = Header
  PARAMETRES.taille = Taille

  PARAMETRES.correction = Correction
  PARAMETRES.enonce = Enonce
  PARAMETRES.visible = Visible

  PARAMETRES.competence = Competence
  PARAMETRES.difficulte = Difficulte
  PARAMETRES.source = Source
  PARAMETRES.theme = Theme

  PARAMETRES.stretch = Stretch

    POLICE = PoliceUtilisateur()
    PoliceDocument(POLICE,PARAMETRES)

    PAGE = FormatUtilisateur(PARAMETRES)
    FormatDocument(PAGE,PARAMETRES)



    COULEURS = CouleursUtilisateur(PARAMETRES)
    CouleursDocument(COULEURS)

    LOGOS = LogosUtilisateur()
    LogosDocument(PARAMETRES,LOGOS)

    BooleensDocument(PARAMETRES)

    STYLESTITRES = StylesTitresUtilisateur(PARAMETRES)
    StylesTitresDocument(PARAMETRES,STYLESTITRES)
    TITRE = TitresUtilisateur(PARAMETRES)
    TitresDocument(TITRE)
    ENVIRONNEMENTS = EnvironnementsUtilisateur()
    EnvironnementsDocument(ENVIRONNEMENTS)
  }
}

