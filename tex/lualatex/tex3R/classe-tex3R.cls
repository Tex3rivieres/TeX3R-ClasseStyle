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

\begin{luacode*}
  PARAMETRES = {}
  PAGE = {}
  POLICE = {}
  COULEURS = {}
  LOGOS = {}
  STYLESTITRES = {}
  TITRES = {}
  ENVIRONNEMENTS = {}
  PARAMETRES.premier = true
\end{luacode*}

\DeclareOption{fiche}{\directlua{PARAMETRES.format = "fiche"}}
\DeclareOption{diapo}{\directlua{PARAMETRES.format = "diapo"}}
\ProcessOptions\relax

\begin{luacode*}
  Format = PARAMETRES.format
\end{luacode*}

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
% \RequirePackage{tcolorbox}

\RequirePackage{environ}
\RequirePackage[autoenlargeheadfoot=false]{scrlayer-scrpage}
\RequirePackage{bookmark}

\RequirePackage{etoolbox}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{subfiles}

\RequirePackage{ProfCollege}
  \tcbuselibrary{skins,breakable}
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
\RequirePackage{circledsteps}

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
\newif\ifsubfile

\newcommand{\FormatPage}

\begin{luacode*}

  function FormatageString(string)
  -- local newString = ''
  if string ~= nil then
    newString = string.gsub(string, "\n", "")
    newString = string.gsub(newString, "^%s+", "")
    newString = string.gsub(newString, "%s+$", "")
  end
    return newString
  end

  function RestoreHeader()
    if PARAMETRES.header then
    tex.sprint('\\headertrue')
    end
  end

--Formatage de la page d'après les paramètres utilisateurs
  function FormatDocument()

    local HEADER = PARAMETRES.header
    local FORMAT = PARAMETRES.format
    local PRINT = PARAMETRES.print
    local PREMIER = PARAMETRES.premier

    if PREMIER then

      tex.sprint(
        '\\setlength{\\parindent}{' ..  FormatageString(PAGE.parindent) ..'}' ..
        '\\setlength{\\parskip}{' ..  FormatageString(PAGE.parskip) ..'}' ..
        '\\frenchbsetup{ItemLabeli=' ..  FormatageString(PAGE.itemi) .. '}' ..
        '\\frenchbsetup{ItemLabelii=' ..  FormatageString(PAGE.itemii) ..'}' ..
        '\\setlist[enumerate,1]{label=' ..  FormatageString(PAGE.enumi) .. '}' ..
        '\\setlist[enumerate,2]{label=' ..  FormatageString(PAGE.enumii) .. '}' ..
        '\\DeclareInstance{tasks}{enumerate}{default}{label =' ..  FormatageString(PAGE.enumi) .. ',label-width=1.125em}' ..
        '\\DeclareInstance{tasks}{itemize}{default}{label = ' ..  FormatageString(PAGE.itemi) .. ',label-width=1.125em}' ..
        '\\renewcommand*{\\sectionformat}{' ..  FormatageString(PAGE.sectionnumber) .. '}' ..
        '\\renewcommand*{\\subsectionformat}{' ..  FormatageString(PAGE.subsectionnumber) .. '}' ..
        '\\renewcommand*{\\subsubsectionformat}{' ..  FormatageString(PAGE.subsubsectionnumber) .. '}' ..
        '\\setkomafont{section}{' ..  FormatageString(PAGE.sectionname) .. '}' ..
        '\\setkomafont{subsection}{' ..  FormatageString(PAGE.subsectionname) .. '}' ..
        '\\setkomafont{subsubsection}{' ..  FormatageString(PAGE.subsubsectionname) .. '}' ..
        '\\renewcommand*{\\sectionlinesformat}[4]{' ..  FormatageString(PAGE.sectionsformat) .. '}' ..
        '\\renewcommand*\\partlineswithprefixformat[3]{\\thispagestyle{empty}'.. FormatageString(PAGE.partformat) .. '}' ..
        '\\renewcommand{\\formatchapitrenormal}{' .. FormatageString(PAGE.chapitrenormalformat) .. '}' ..
        '\\renewcommand{\\formatchapitreetoile}{' .. FormatageString(PAGE.chapitreetoileformat) .. '}'
      )

      if FORMAT =='fiche' then
        tex.sprint('\\fichetrue')
      elseif FORMAT == 'diapo' then
        tex.sprint('\\diapotrue')
      end
    end

    if PRINT then
      tex.sprint('\\printtrue')
    end

    if PREMIER then
      tex.sprint('\\newcommand{\\mygeometry}{\\geometry{paperwidth=' ..  FormatageString(PAGE.width) .. ',paperheight=' ..  FormatageString(PAGE.height) ..'}}')
    end

    tex.sprint(
          '\\newgeometry{' ..
          'top=' ..  FormatageString(PAGE.top) ..
          ',bottom=' ..  FormatageString(PAGE.bottom) ..
          ',right=' ..  FormatageString(PAGE.right) ..
          ',left=' ..  FormatageString(PAGE.left) ..
          ',includehead' ..
          ',includefoot' ..
          ',marginparsep=' ..  FormatageString(PAGE.marginparsep) ..
          ',marginparwidth=' ..  FormatageString(PAGE.marginparwidth) ..
          ',headheight=' ..  FormatageString(PAGE.headheight) ..
          ',headsep=' ..  FormatageString(PAGE.headsep) ..
          ',footskip=' ..  FormatageString(PAGE.footskip) ..
        '}' ..
        '\\savegeometry{Normal}'
    )

    tex.sprint(
      '\\newgeometry{' ..
      'top=' ..  FormatageString(PAGE.headertop) ..
      ',bottom=' ..  FormatageString(PAGE.headerbottom) ..
      ',right=' ..  FormatageString(PAGE.headerright) ..
      ',left=' ..  FormatageString(PAGE.headerleft) ..
      ',includehead' ..
      ',includefoot' ..
      ',marginparsep=' ..  FormatageString(PAGE.headermarginparsep) ..
      ',marginparwidth=' ..  FormatageString(PAGE.headermarginparwidth) ..
      ',headheight=' ..  FormatageString(PAGE.headerheadheight) ..
      ',headsep=' ..  FormatageString(PAGE.headerheadsep) ..
      ',footskip=' ..  FormatageString(PAGE.headerfootskip) ..
    '}' ..
    '\\savegeometry{Header}'
    )

    if HEADER then
      tex.sprint('\\headertrue\\loadgeometry{Header}')
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
      tex.sprint('\\loadgeometry{Normal}')
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

  end
\end{luacode*}

\AtBeginDocument{\loadgeometry{Normal}}

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

\newif\ifbareme
\newif\ifdifficulte
\newif\ifcompetence
\newif\ifsource
\newif\iftheme

\newif\ifstretch

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FONCTION LUA REMPLAÇANT L'ANCIENNE FONCTION TEX PARAMETRE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode*}
function BooleensDocument()
  local bool =[[
    \activitefalse
    \basiquefalse
    \bilanfalse
    \corrigefalse
    \coursfalse
    \flashfalse
    \TDfalse
    \DMfalse
    \DSfalse
    \interrofalse
    \flashfalse
    \baremefalse
    \correctionfalse
    \enoncefalse
    \visiblefalse
    \competencefalse
    \difficultefalse
    \sourcefalse
    \themefalse
    \stretchfalse
  ]]
  tex.sprint(FormatageString(bool))

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

  if PARAMETRES.bareme then
    tex.sprint('\\baremetrue')
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

\newcounter{compteurexercice}

\newcounter{compteurinterro}
\newcounter{compteurflash}
\newcounter{compteurDM}
\newcounter{compteurDS}
\newcounter{compteurTD}

%Initialisation
\setcounter{compteurfeuille}{1}

\setcounter{compteurexercice}{0}

\setcounter{compteurinterro}{0}
\setcounter{compteurflash}{0}
\setcounter{compteurDM}{0}
\setcounter{compteurDS}{0}
\setcounter{compteurTD}{0}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMANDES PERSONNELLES %
%%%%%%%%%%%%%%%%%%%%%%%%%%

%Commandes de mise en page

\begin{luacode*}
  function TailleTexteLua(nombre)
    if nombre == -4 then
      tex.sprint('\\tiny')
    elseif nombre == -3 then
      tex.sprint('\\scriptsize')
    elseif nombre == -2 then
      tex.sprint('\\footnotesize')
    elseif nombre == -1 then
      tex.sprint('\\small')
    elseif nombre == 1 then
      tex.sprint('\\large')
    elseif nombre == 2 then
      tex.sprint('\\Large')
    elseif nombre == 3 then
      tex.sprint('\\LARGE')
    elseif nombre == 4 then
      tex.sprint('\\huge') 
    else
      tex.sprint('\\normalsize')
    end
  end

  function SautLua(arg)
    if arg == 'ligne' then
      tex.sprint('\\sautligne')
    elseif arg =='fiche' then
      tex.sprint('\\sautfiche')
    elseif arg == 'diapo' then
      tex.sprint('\\sautdiapo')
    end
  end
\end{luacode*}

\newcommand{\tailletexte}[1]{
  \directlua{TailleTexteLua(#1)}
}

\newcommand{\important}[1]{}

\newcommand{\sautligne}{\vspace{\baselineskip}}
\newcommand{\sautdiapo}{\ifdiapo \newpage \fi}
\newcommand{\sautfiche}{\iffiche \newpage \fi}
\newcommand{\saut}[1]{\directlua{SautLua("#1")}}



%Commandes des environnements
%
\newcommand{\contenuchapitre}{}
\newcommand{\contenuniveau}{}

\newcommand{\contenubareme}{}
\newcommand{\contenucompetence}{}
\newcommand{\contenudifficulte}{}
\newcommand{\contenusource}{}
\newcommand{\contenutheme}{}

%
\begin{luacode}
  function DifficulteLua(nombre)
    if nombre then
      for i=1,nombre do
        tex.sprint('\\faStar')
      end
    end
  end

  function ChapitreLua(nombre)
    if nombre then

      tex.sprint('\\setcounter{part}{' .. nombre ..'}')
    end
  end

  function NiveauDocument(str)
    if str then
      tex.sprint('\\niveaucustomfalse')
      tex.sprint('\\renewcommand{\\contenuniveau}{' .. str ..'}')
    else
      tex.sprint('\\niveaucustomtrue')
    end
  end
  
  function BaremeLua(arg)
    if arg then
      tex.sprint('\\renewcommand{\\contenubareme}{' .. arg .. '}')      
    else
      tex.sprint('\\renewcommand{\\contenubareme}{?}')
    end
  end
\end{luacode}


\newcommand{\definirchapitre}[2]{\directlua{ChapitreLua(#1)}\renewcommand{\contenuchapitre}{#2}}

\newif\ifniveaucustom

\newcommand{\definirniveau}[1]{\directlua{NiveauUtilisateur([[#1]])}\ifniveaucustom \renewcommand{\contenuniveau}{#1}\fi}

\newcommand{\bareme}[1]{\directlua{BaremeLua(#1)}}
\newcommand{\competence}[1]{\renewcommand{\contenucompetence}{#1}}
\newcommand{\difficulte}[1]{\renewcommand{\contenudifficulte}{\directlua{DifficulteLua(#1)}}}
\newcommand{\source}[1]{\renewcommand{\contenusource}{#1}}
\newcommand{\theme}[1]{\renewcommand{\contenutheme}{#1}}

\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}}%Column P centrée verticalement

%%% COMMANDES POUR LE CHAPITRE AVEC/SANS ETOILE%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\formatchapitreetoile}{}
\newcommand{\formatchapitrenormal}{}

\newif\ifpartetoile

\newcommand{\formatchapitre}{\ifpartetoile \formatchapitreetoile \else \formatchapitrenormal \fi}

\newcommand{\chapitrenormal}[1]{
  \partetoilefalse
  \part{#1}
  \renewcommand{\contenuchapitre}{#1}
}

\newcommand{\chapitreetoile}[1]{
  \partetoiletrue
  \part*{#1}
  \phantomsection\addcontentsline{toc}{part}{#1}
  \renewcommand{\contenuchapitre}{#1}
}

\newcommand{\partienormal}[1]{\subsection{#1}}
\newcommand{\partieetoile}[1]{\subsection*{#1}}
\newcommand{\souspartienormal}[1]{\subsubsection{#1}}
\newcommand{\souspartieetoile}[1]{\subsubsection*{#1}}

\makeatletter
\def\chapitre{\@ifstar\chapitreetoile\chapitrenormal}
\def\partie{\@ifstar\partieetoile\partienormal}
\def\souspartie{\@ifstar\souspartieetoile\souspartienormal}
\makeatother


%Commandes de lignes

\begin{luacode}

function LignesLua(str,nombre)
  
  if nombre == nil then
    nombre = 1
  end

  if str == 'carreaux' or str == 'carreau' then
    tex.sprint('\\tracecarreaux{' ..nombre ..'}')
  elseif str == 'surligne' then
    tex.sprint('\\tracesurligne{' ..nombre ..'}')
  else
    tex.sprint('\\tracelignes{' ..nombre ..'}')
  end

end

\end{luacode}

\newcommand{\lignes}[2]{\directlua{LignesLua("#1",#2)}}


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
  function CouleursDocument()

    local PREMIER = PARAMETRES.premier

    tex.sprint(
      '\\colorlet{couleurligne}{' ..  FormatageString(COULEURS.ligne) .. '}' ..
      '\\colorlet{couleurinterligne}{' ..  FormatageString(COULEURS.interligne) .. '}' ..
      '\\colorlet{couleursection}{' ..  FormatageString(COULEURS.section) .. '}' ..
      '\\colorlet{couleursubsection}{' ..  FormatageString(COULEURS.subsection) .. '}' ..
      '\\colorlet{couleursubsubsection}{' ..  FormatageString(COULEURS.subsubsection) .. '}' ..
      '\\colorlet{couleurcarreau}{' ..  FormatageString(COULEURS.carreau) .. '}' ..
      '\\colorlet{couleursurlignelignea}{' ..  FormatageString(COULEURS.surlignelignea) .. '}' ..
      '\\colorlet{couleursurligneligneb}{' ..  FormatageString(COULEURS.surligneligneb) .. '}' ..
      '\\colorlet{couleurboitecours}{' ..  FormatageString(COULEURS.boitecours) .. '}' ..
      '\\colorlet{couleurbackground}{' ..  FormatageString(COULEURS.background) .. '}' ..
      '\\colorlet{couleurapplication}{' ..  FormatageString(COULEURS.application) .. '}' ..
      '\\colorlet{couleurdefinition}{' ..  FormatageString(COULEURS.definition) .. '}' ..
      '\\colorlet{couleurconvention}{' ..  FormatageString(COULEURS.convention) .. '}' ..
      '\\colorlet{couleurexercice}{' ..  FormatageString(COULEURS.exercice) .. '}' ..
      '\\colorlet{couleurexemple}{' ..  FormatageString(COULEURS.exemple) .. '}' ..
      '\\colorlet{couleurmethode}{' ..  FormatageString(COULEURS.methode) .. '}' ..
      '\\colorlet{couleurpreuve}{' ..  FormatageString(COULEURS.preuve) .. '}' ..
      '\\colorlet{couleurpropriete}{' ..  FormatageString(COULEURS.propriete) .. '}' ..
      '\\colorlet{couleurremarque}{' ..  FormatageString(COULEURS.remarque) .. '}' ..
      '\\colorlet{couleurenonce}{' ..  FormatageString(COULEURS.enonce) .. '}' ..
      '\\colorlet{couleurcorrection}{' ..  FormatageString(COULEURS.correction) .. '}' ..
      '\\colorlet{couleursurligne}{' ..  FormatageString(COULEURS.surligne) .. '}' ..
      '\\colorlet{couleursurlignevisible}{' ..  FormatageString(COULEURS.surlignevisible) .. '}' ..
      '\\colorlet{bleu}{' ..  FormatageString(COULEURS.bleu) .. '}' ..
      '\\colorlet{rouge}{' ..  FormatageString(COULEURS.rouge) .. '}' ..
      '\\colorlet{vert}{' ..  FormatageString(COULEURS.vert) .. '}' ..
      '\\colorlet{bleu}{' ..  FormatageString(COULEURS.bleu) .. '}'
    )

    tex.sprint('\\sethlcolor{couleursurligne}')
    tex.sprint('\\pagecolor{' .. COULEURS.background ..'}')

  end 
\end{luacode}

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FORMATAGES DIVERS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode}
  function PoliceDocument()
    local TAILLE = PARAMETRES.taille
    local FORMAT = PARAMETRES.format
    local PREMIER = PARAMETRES.premier

    if TAILLE == nil then
      if FORMAT == 'fiche' then
        tex.sprint('\\KOMAoption{fontsize}{'..  FormatageString(POLICE.taillefiche) ..'}')
      elseif FORMAT == 'diapo' then
        tex.sprint('\\KOMAoption{fontsize}{'..  FormatageString(POLICE.taillediapo) ..'}')
      end
    else
      tex.sprint('\\KOMAoption{fontsize}{' .. TAILLE ..'}')
    end

    if PREMIER then
      tex.sprint('\\renewcommand{\\important}[1]{'..  FormatageString(POLICE.important) ..'}')
    end

  tex.sprint(
    '\\IfFontExistsTF{' ..  FormatageString(POLICE.texte) ..'}{\\setmainfont{' ..  FormatageString(POLICE.texte) .. '}}\\n' ..
    '\\IfFontExistsTF{' ..  FormatageString(POLICE.math) .. '}{\\setmathfont{' ..  FormatageString(POLICE.math) .. '}}{}' ..
    '\\IfFontExistsTF{' ..  FormatageString(POLICE.mathcal) .. '}{\\setmathfont{' ..  FormatageString(POLICE.mathcal) .. '}[range=cal]}{}'
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
  function LogosDocument()

    local TYPE = PARAMETRES.type

    if TYPE == 'activite' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.activite) ..'}')
    elseif TYPE == 'basique' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.basique) ..'}')
    elseif TYPE == 'bilan' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.bilan) ..'}')
    elseif TYPE == 'corrige' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.corrige) ..'}')
    elseif TYPE == 'cours' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.cours) ..'}')
    elseif TYPE == 'DM' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.DM) ..'}')
    elseif TYPE == 'DS' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.DS) ..'}')
    elseif TYPE == 'flash' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.flash) ..'}')
    elseif TYPE == 'interro' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.interro) ..'}')
    elseif TYPE == 'TD' then
      tex.sprint('\\renewcommand{\\logoactif}{' ..  FormatageString(LOGOS.TD) ..'}')
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

\newcommand{\montitre}[2][\hspace{-0.25em}]{\renewcommand{\logoactif}{#1}\ifheader\ihead{\titre{#2}}\else\titre{#2}\fi}



\begin{luacode}
  function StylesTitresDocument()

    local TYPE = PARAMETRES.type
    local HEADER = PARAMETRES.header

    if HEADER then
      tex.sprint('\\renewcommand{\\titre}[1]{'..  FormatageString(STYLESTITRES.titre) ..'}')
    else
      tex.sprint('\\renewcommand{\\titre}[1]{'..  FormatageString(STYLESTITRES.titre) .. '\\vspace{' ..  FormatageString(STYLESTITRES.espacement) ..'}}')
    end

    if TYPE == 'activite' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.activite) ..'}')
    elseif TYPE == 'basique' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.basique) ..'}')
    elseif TYPE == 'bilan' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.bilan) ..'}')
    elseif TYPE == 'corrige' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.corrige) ..'}')
    elseif TYPE == 'cours' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.cours) ..'}')
    elseif TYPE == 'DM' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.DM) ..'}')
    elseif TYPE == 'DS' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.DS) ..'}')
    elseif TYPE == 'flash' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.flash) ..'}')
    elseif TYPE == 'interro' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.interro) ..'}')
    elseif TYPE == 'TD' then
      tex.sprint('\\renewcommand{\\styleactif}[1]{' ..  FormatageString(STYLESTITRES.TD) ..'}')
    end
  end
\end{luacode}

\newcommand{\motcletitretoc}{}
\newif\iftitretoc


\begin{luacode}
  function TitresDocument()
    local TYPE = PARAMETRES.type
    local PREMIER = PARAMETRES.premier

    if TYPE == 'basique' then
      tex.sprint('\\titretocfalse')
    else
      tex.sprint('\\titretoctrue')
    end

    if TYPE == 'activite' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocactivite) ..'}')
    elseif TYPE == 'basique' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocbasique) ..'}')
    elseif TYPE == 'bilan' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocbilan) ..'}')
    elseif TYPE == 'corrige' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.toccorrige) ..'}')
    elseif TYPE == 'cours' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.toccours) ..'}')
    elseif TYPE == 'DM' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocDM) ..'}')
    elseif TYPE == 'DS' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocDS) ..'}')
    elseif TYPE == 'flash' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocflash) ..'}')
    elseif TYPE == 'interro' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocinterro) ..'}')
    elseif TYPE == 'TD' then
      tex.sprint('\\renewcommand{\\motcletitretoc}{' ..  FormatageString(TITRES.tocTD) ..'}')
    end

    tex.sprint('\\renewcommand{\\titreactif}{\\styleactif{' ..  FormatageString(TITRES.format) .. '}}')
 
  end
\end{luacode}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ENVIRONNEMENT ET COMMANDE VISIBLE %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifmontre

\begin{luacode}

function VerificationVisible(flag)
  local VISIBLE = PARAMETRES.visible
  local str = tostring(VISIBLE)
  local flg = tostring(flag)

  if VISIBLE == true then
    tex.sprint('\\visibletrue')
  else
    tex.sprint('\\visiblefalse')
  end

  print('MESSAGE')
  print(str)
  if flg == str then
    tex.sprint('\\montretrue')
  else
    tex.sprint('\\montrefalse')
  end
end

\end{luacode}

\NewEnviron{visible}[1][true]{%
  \directlua{VerificationVisible(#1)}
  \ifmontre
    \BODY
  \fi
}

\newcommand{\visiblecmd}[2][true]{%
  \directlua{VerificationVisible(#1)}
  \ifmontre
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
\NewEnviron{exemple}[1][]{\BODY}
\NewEnviron{methode}[1][]{\BODY}
\NewEnviron{preuve}[1][]{\BODY}
\NewEnviron{propriete}[1][]{\BODY}
\NewEnviron{remarque}[1][]{\BODY}

\NewEnviron{correction}[1][]{\BODY}
\NewEnviron{enonce}[1][]{\BODY}

\begin{luacode*}
  function EnvironnementsDocument()

    local PREMIER = PARAMETRES.premier
    local TYPE = PARAMETRES.type

    if PREMIER then

      tex.sprint('\\renewcommand{\\formatEnvCours}[2][]{\\ifstretch\\vfill\\fi'..  FormatageString(ENVIRONNEMENTS.formatcours) ..'}')

      tex.sprint([[\RenewEnviron{application}[1][Application]{\formatEnvCours[#1]{couleurapplication}}]])
      tex.sprint([[\RenewEnviron{definition}[1][Définition]{\formatEnvCours[#1]{couleurdefinition}}]])
      tex.sprint([[\RenewEnviron{convention}[1][Convention]{\formatEnvCours[#1]{couleurconvention}}]])
      tex.sprint([[\RenewEnviron{exemple}[1][Exemple]{\formatEnvCours[#1]{couleurexemple}}]])
      tex.sprint([[\RenewEnviron{methode}[1][Méthode]{\formatEnvCours[#1]{couleurmethode}}]])
      tex.sprint([[\RenewEnviron{preuve}[1][Preuve]{\formatEnvCours[#1]{couleurpreuve}}]])
      tex.sprint([[\RenewEnviron{propriete}[1][Propriété]{\formatEnvCours[#1]{couleurpropriete}}]])
      tex.sprint([[\RenewEnviron{remarque}[1][Remarque]{\formatEnvCours[#1]{couleurremarque}}]])
    end

    if TYPE == 'cours' then

        tex.sprint([[\RenewEnviron{enonce}[1][Énoncé]{\formatEnvCours[#1]{couleurenonce}}]])

        tex.sprint([[\RenewEnviron{correction}[1][Correction]{\formatEnvCours[#1]{couleurcorrection}}]])

      else

        tex.sprint('\\RenewEnviron{enonce}[1][]{\\stepcounter{compteurexercice}\\phantomsection\\addcontentsline{toc}{subsection}{'..  FormatageString(ENVIRONNEMENTS.tocexercice) ..'~\\thecompteurexercice}\\ifenonce\\phantomsection\\addcontentsline{toc}{subsubsection}{'..  FormatageString(ENVIRONNEMENTS.tocenonce) ..'}\\ifstretch\\vfill\\fi' ..  FormatageString(ENVIRONNEMENTS.enonce) .. '\\fi}')

        tex.sprint('\\RenewEnviron{correction}[1][]{\\ifcorrection\\phantomsection\\addcontentsline{toc}{subsubsection}{' ..  FormatageString(ENVIRONNEMENTS.toccorrection) .. '}\\ifstretch\\vfill\\fi' ..  FormatageString(ENVIRONNEMENTS.correction) .. '\\fi}')

      end
  end
\end{luacode*}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% COMMANDES DE COMPATIBILITÉ AVEC LA VERSION 1.0 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \NewEnviron{lignes}{\BODY}
% \NewEnviron{lignes*}{\BODY}
\newcommand{\rivcorrection}[2]{\ifvisible~#1 \else #2 \fi}
\newcommand{\rivimportant}[1]{\important{#1}}
\newcommand{\ajoutlignes}[1]{}
\providecommand{\adjustbox}[2]{#2}
\newcommand{\parametres}[1]{}
\newcommand{\sautdeligne}{\sautligne}
\newcommand{\niveau}{\definirniveau}
\NewEnviron{exercice}[1]{\begin{enonce}[#1] \BODY\end{enonce}}

%%%

\begin{luacode*}

  function TitreLua()
    local HEADER = PARAMETRES.header
    local PREMIER = PARAMETRES.premier
    local TYPE = PARAMETRES.type

    if PREMIER then

      if not HEADER then
        tex.sprint('\\AtBeginDocument{\\titreactif}')

        if TYPE ~= 'basique' then
          tex.sprint('\\phantomsection\\addcontentsline{toc}{section}{\\motcletitretoc}')
        end

      end

    else

      if not HEADER then
        tex.sprint('\\titreactif')
      end
    tex.sprint('\\phantomsection\\addcontentsline{toc}{section}{\\motcletitretoc}')

    end

    PARAMETRES.premier = false
  end 
\end{luacode*}

\begin{luacode*}
  function mesParametres(str)
  end
\end{luacode*}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% COMMANDE PARAMETRAGE PERMETTANT DE MODIFIER LES OPTIONS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode*}
  function ParametrageDocument()

    if Format == nil then
      PARAMETRES.format = 'fiche'
    else
      PARAMETRES.format = Format
    end

    if Type == nil then
      PARAMETRES.type = 'basique'
    else
      PARAMETRES.type = Type
    end

    if Impression == nil then
    PARAMETRES.print = false
    else
    PARAMETRES.print = Impression
    end 

    if Header == nil then
    PARAMETRES.header = false
    else
    PARAMETRES.header = Header
    end 

    PARAMETRES.taille = Taille

    if Correction == nil then
    PARAMETRES.correction = false
    else
    PARAMETRES.correction = Correction
    end 

    if Enonce == nil then
    PARAMETRES.enonce = false
    else
    PARAMETRES.enonce = Enonce
    end 

    if Visible == nil then
    PARAMETRES.visible = false
    else
    PARAMETRES.visible = Visible
    end 

    if Bareme == nil then
    PARAMETRES.bareme = false
    else
    PARAMETRES.bareme = Bareme
    end 

    if Competence == nil then
    PARAMETRES.competence = false
    else
    PARAMETRES.competence = Competence
    end 

    if Difficulte == nil then
    PARAMETRES.difficulte = false
    else
    PARAMETRES.difficulte = Difficulte
    end 

    if Source == nil then
    PARAMETRES.source = false
    else
    PARAMETRES.source = Source
    end 

    if Theme == nil then
    PARAMETRES.theme = false
    else
    PARAMETRES.theme = Theme
    end 

    if Stretch == nil then
    PARAMETRES.stretch = false
    else
    PARAMETRES.stretch = Stretch
    end 

    PoliceUtilisateur()
    PoliceDocument()

    FormatUtilisateur()
    FormatDocument()

    CouleursUtilisateur()
    CouleursDocument()

    LogosUtilisateur()
    LogosDocument()

    BooleensDocument()

    StylesTitresUtilisateur()
    StylesTitresDocument()
    TitresUtilisateur()
    TitresDocument()
    EnvironnementsUtilisateur()
    EnvironnementsDocument()
    TitreLua()

    Type = nil
    Impression = nil
    Header = nil
    Taille = nil
    Correction = nil
    Enonce = nil
    Visible = nil
    Competence = nil
    Bareme = nil
    Difficulte = nil
    Source = nil
    Theme = nil
    Stretch = nil
  end
\end{luacode*}

\newcommand{\parametrage}{\ifsubfile\else\directlua{ParametrageDocument()}\setcounter{compteurexercice}{0}\fi}