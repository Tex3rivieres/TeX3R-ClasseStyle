\NeedsTeXFormat{LaTeX2e}[2022-11-01]

\ProvidesClass{classe-tex3R-2-1}[14/11/2023-Branche test de TEX3R]

\LoadClass{scrartcl}

\RequirePackage{iftex}
\ifluatex
  \RequirePackage{luacode}
\else
  \ClassError{Lualatex only}{Ce document doit êtres compilé en LuaLaTeX}{}\stop
\fi

\RequirePackage{geometry}
\RequirePackage{showframe}