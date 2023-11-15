\NeedsTeXFormat{LaTeX2e}[2022-11-01]

\ProvidesClass{classe-tex3R-2-1}[14/11/2023-Branche test de TEX3R]

\LoadClass{scrartcl}

\RequirePackage{iftex}
\ifluatex
  \RequirePackage{luacode}
\else
  \ClassError{Lualatex only}{Ce document doit êtres compilé en LuaLaTeX}{}\stop
\fi

%Formatage de la page et du texte
\RequirePackage{geometry}
\RequirePackage[svgnames]{xcolor}
\RequirePackage{fontspec}
\RequirePackage{anyfontsize}
\RequirePackage[french]{babel}
\RequirePackage{unicode-math}
\RequirePackage{enumitem}
\RequirePackage{tasks}

%Formatages divers
\RequirePackage{fontawesome5}
\RequirePackage[minimal]{lua-ul}
\RequirePackage{soul}

\RequirePackage{tikz}



\RequirePackage{showframe}

%%%%%%%%%%%%%%%%%%%%%%
% BOOLÉENS DU FORMAT %
%%%%%%%%%%%%%%%%%%%%%%

\newif\ifdiapo
\newif\iffiche
\newif\ifheader
\newif\ifprint

\begin{luacode}
--Formatage de la page d'après les paramètres utilisateurs
  function FormatDocument(PAGE,DOC,DOC_HEADER,PARAMETRES)

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
      '\\DeclareInstance{tasks}{enumerate}{default}{label =' .. PAGE.enumi .. ',label-width=1em}' ..
      '\\DeclareInstance{tasks}{itemize}{default}{label = ' .. PAGE.itemi .. ',label-width=1em}' ..
      '\\renewcommand*{\\sectionformat}{' .. PAGE.sectionnumber .. '}' ..
      '\\renewcommand*{\\subsectionformat}{' .. PAGE.subsectionnumber .. '}' ..
      '\\renewcommand*{\\subsubsectionformat}{' .. PAGE.subsubsectionnumber .. '}' ..
      '\\setkomafont{section}{' .. PAGE.sectionname .. '}' ..
      '\\setkomafont{subsection}{' .. PAGE.subsectionname .. '}' ..
      '\\setkomafont{subsubsection}{' .. PAGE.subsubsectionname .. '}'
    )

    if FORMAT =='fiche' then
      tex.sprint('\\fichetrue')
    elseif FORMAT == 'diapo' then
      tex.sprint('\\diapotrue')
    end

    if HEADER then
      tex.sprint('\\headertrue')
    end

    if PRINT then
      tex.sprint('\\printtrue')
    end

    tex.sprint('\\geometry{paperwidth=' .. PAGE.width .. ',paperheight=' .. PAGE.height ..'}')

    tex.sprint(
      '\\gdef\\FormatDoc{' ..
        '\\newgeometry{' ..
          'top=' .. DOC.top ..
          ',bottom=' .. DOC.bottom ..
          ',right=' .. DOC.right ..
          ',left=' .. DOC.left ..
          ',includehead' ..
          ',includefoot' ..
          ',marginparsep=' .. DOC.marginparsep ..
          ',marginparwidth=' .. DOC.marginparwidth ..
          ',headheight=' .. DOC.headheight ..
          ',headsep=' .. DOC.headsep ..
          ',footskip=' .. DOC.footskip ..
        '}' ..
      '}' ..
      '\\gdef\\FormatDocHeader{' ..
        '\\newgeometry{' ..
          'top=' .. DOC_HEADER.top ..
          ',bottom=' .. DOC_HEADER.bottom ..
          ',right=' .. DOC_HEADER.right ..
          ',left=' .. DOC_HEADER.left ..
          ',includehead' ..
          ',includefoot' ..
          ',marginparsep=' .. DOC_HEADER.marginparsep ..
          ',marginparwidth=' .. DOC_HEADER.marginparwidth ..
          ',headheight=' .. DOC_HEADER.headheight ..
          ',headsep=' .. DOC_HEADER.headsep ..
          ',footskip=' .. DOC_HEADER.footskip ..
        '}' ..
      '}'
    )

    if HEADER then
      tex.sprint('\\AtBeginDocument{\\FormatDocHeader}')
    else
      tex.sprint('\\AtBeginDocument{\\FormatDoc}')
    end
  end
\end{luacode}


%%%%%%%%%%%%%%%%%%%
% AUTRES BOOLÉENS %
%%%%%%%%%%%%%%%%%%%

%type
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

\newif\ifbareme
\newif\ifcache
\newif\ifdifficulte
\newif\ifenonce
\newif\ifcompetence
\newif\ifcorrection
\newif\ifsource
\newif\iftheme

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FONCTION LUA REMPLAÇANT L'ANCIENNE FONCTION TEX PARAMETRE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode*}
function BooleensDocument(PARAMETRES) -- PARAMETRES liste stockant tous les paramètres
  tex.sprint(
    '\\activitefalse' ..
    '\\basiquefalse' ..
    '\\brevetfalse' ..
    '\\corrigefalse' ..
    '\\coursfalse' ..
    '\\flashfalse' ..
    '\\TDfalse' ..
    '\\DMfalse' ..
    '\\DSfalse' ..
    '\\interrofalse' ..
    '\\flashfalse'
  )

  if PARAMETRES.type == 'activite' then
    tex.sprint('\\activitetrue')
  elseif PARAMETRES.type == 'basique' then
    tex.sprint('\\basiquetrue')
  elseif PARAMETRES.type == 'brevet' then
    tex.sprint('\\brevettrue')
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
  elseif PARAMETRES.type == 'basique' then
    tex.sprint('\\flashtrue')
  end

  if PARAMETRES.bareme then
    tex.sprint('\\baremetrue')
  end

  if PARAMETRES.cache then
    tex.sprint('\\cachetrue')
  end

  if PARAMETRES.competence then
    tex.sprint('\\competencetrue')
  end

  if PARAMETRES.correction then
    tex.sprint('\\correctiontrue')
  end

  if PARAMETRES.difficulte then
    tex.sprint('\\difficultetrue')
  end

  if PARAMETRES.enonce then
    tex.sprint('\\enoncetrue')
  end

  if PARAMETRES.source then
    tex.sprint('\\sourcetrue')
  end

  if PARAMETRES.theme then
    tex.sprint('\\themetrue')
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

\newcounter{compteurbareme}

%Initialisation
\setcounter{compteurfeuille}{1}

\setcounter{compteurenonce}{0}
\setcounter{compteurcorrection}{0}

\setcounter{compteurinterro}{0}
\setcounter{compteurflash}{0}
\setcounter{compteurDM}{0}
\setcounter{compteurDS}{0}
\setcounter{compteurTD}{0}

\setcounter{compteurbareme}{0}

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

\newcommand{\sautdeligne}{\vspace{\baselineskip}}
\newcommand{\sautdiapo}{\ifdiapo \newpage \fi}
\newcommand{\sautfiche}{\iffiche \newpage \fi}

%Commandes des environnements
%
\newcommand{\rivchapitre}{}
\newcommand{\rivniveau}{}

\newcommand{\rivcompetence}{}
\newcommand{\rivdifficulte}{}%
\newcommand{\rivsource}{}
\newcommand{\rivtheme}{}

\newcommand{\rivrepere}{}

%
\begin{luacode}
  function Difficulte(nombre)
    if nombre then
      for i=1,nombre do
        tex.sprint('\\faStar')
      end
    end
  end
\end{luacode}

\newcommand{\chapitre}[2]{\setcounter{part}{#1}\renewcommand{\rivchapitre}{#2}}
\newcommand{\niveau}[1]{\renewcommand{\rivniveau}{#1}}

\newcommand{\competence}[1]{\renewcommand{\rivcompetence}{#1}}
\newcommand{\difficulte}[1]{\renewcommand{\rivdifficulte}{\directlua{Difficulte(#1)}}}
\newcommand{\source}[1]{\renewcommand{\rivsource}{#1}}
\newcommand{\theme}[1]{\renewcommand{\rivtheme}{#1}}

\newcommand{\repere}[1]{\renewcommand{\rivrepere}{#1}}

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
      '\\colorlet{couleursubsubsection}{' .. COULEURS.subsubsection .. '}'
    )

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

\begin{luacode}
  function LogosDocument(LOGOS)
    tex.sprint(
      '\\def\\logoactivite{' .. LOGOS.activite ..'}' ..
      '\\def\\logobasique{' .. LOGOS.basique ..'}' ..
      '\\def\\logocorrige{'.. LOGOS.corrige ..'}' ..
      '\\def\\logocours{'.. LOGOS.cours ..'}' ..
      '\\def\\logoDM{' .. LOGOS.DM ..'}' ..
      '\\def\\logoDS{' .. LOGOS.DS .. '}' ..  
      '\\def\\logoflash{'.. LOGOS.flash .. '}' ..
      '\\def\\logointerro{' .. LOGOS.interro .. '}' ..
      '\\def\\logoTD{'.. LOGOS.TD .. '}'
    )
  end
\end{luacode}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CRÉATION DES TITRES %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\titre}[2]{{\bfseries\LARGE #1  \underLine{#2}}}
\newcommand{\titreactivite}{
  \titre{\logoactivite}{Activité\hfill \mdseries\large\rivniveau$^\text{ème}$}
}
\newcommand{\titrebasique}{}
\newcommand{\titrecorrige}{
  \titre{\logocorrige}{Correction~\mdseries|~\rivchapitre\hfill\large\rivniveau$^\text{ème}$}
}

\newcommand{\titrecours}{
  \titre{\logocours}{Chapitre \thepart~\mdseries|~\rivchapitre\hfill\large\rivniveau$^\text{ème}$}
}
\newcommand{\titreDM}{%
    \titre{\logoDM}{DM n°\stepcounter{compteurDM}\thecompteurDM~\mdseries|~{\mdseries\large NOM :} \hfill {\large\mdseries Prénom :} \hfill \mdseries\large\rivniveau$^\text{ème}$}%
}%
\newcommand{\titreDS}{
    \titre{\logoDS}{DS n°\stepcounter{compteurDS}\thecompteurDS~\mdseries|~{\large\mdseries NOM :} \hfill {\large\mdseries Prénom :} \hfill \mdseries\large\rivniveau$^\text{ème}$}
}
\newcommand{\titreflash}{
  \iffiche
    \titre{\logoflash}{Questions Flash n°\stepcounter{compteurflash}\thecompteurflash~\mdseries|~{\large\mdseries NOM :}\hfill{\large\mdseries Prénom :}\hfill}
  \else
    \titre{\logoflash}{Questions Flash n°\stepcounter{compteurflash}\thecompteurflash\hfill}
  \fi
}
\newcommand{\titreinterro}{
  \titre{\logointerro}{Interrogation n°\stepcounter{compteurinterro}\thecompteurinterro~\mdseries|~{\large\mdseries NOM :} \hfill {\large\mdseries Prénom :} \hfill \mdseries\large\rivniveau$^\text{ème}$}
}
\newcommand{\titreTD}{
  \titre{\logoTD}{TD~\mdseries|~\rivchapitre \hfill \large \rivniveau$^\text{ème}$}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CRÉATION DU TITRE SELON LE HEADER %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode}
  function TitreDocument(PARAMETRES)
    local HEADER = PARAMETRES.header

    if HEADER then

    else

    end
  end
\end{luacode}



























%Commande de paramétrage
\newcommand{\rivparametrage}{
  \directlua{
  PAGE,DOC,DOC_HEADER = FormatUtilisateur(PARAMETRES)
  COULEURS = CouleursUtilisateur(PARAMETRES)
  POLICE = PoliceUtilisateur()
  LOGOS = LogosUtilisateur()
  CouleursDocument(COULEURS)
  FormatDocument(PAGE,DOC,DOC_HEADER,PARAMETRES)
  BooleensDocument(PARAMETRES)
  PoliceDocument(POLICE,PARAMETRES)
  LogosDocument(LOGOS)
  }
}

