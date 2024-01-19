% By Radost Waszkiewicz
% 2023-11-14
% The following latex class is MIT licensed.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{doctoral}

\RequirePackage[utf8]{inputenc}

\def\@baseclass{report}

\PassOptionsToClass{a4paper}{\@baseclass}
\ProcessOptions

\LoadClass{\@baseclass}

\RequirePackage[yyyymmdd]{datetime}
\renewcommand{\dateseparator}{--}

\RequirePackage[margin=1in]{geometry}

\renewcommand\maketitle{%
  \begin{titlepage}%    
    \begin{center}%
      {\LARGE \textbf{\@title}\par}
      \vspace{1cm}
      {\Large {\@author}\par}
      \vspace{2cm}
      {\includegraphics[width=4cm]{./logos/UW_logo.pdf}\par}
      \vspace{2cm}
      {\Large \sc{\@affiliation}\par}
      \vspace{2cm plus 1fill}       
      {\large A dissertation submitted to the University of Warsaw\\
      for the degree of Doctor of Philosophy\\
      under the supervision of {\@supervisor}\par}
      \vspace{2cm}
      {\large Warsaw, \today\par}
    \end{center}    
  \end{titlepage}%
}

\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{pdfpages}
\RequirePackage{amssymb}
\RequirePackage{amsmath}

% keep floats inside sections
\RequirePackage[section]{placeins}

\RequirePackage[maxbibnames=10]{biblatex}
% intext cites should print all authors
\preto\fullcite{\AtNextCite{\defcounter{maxnames}{99}}}
% Bibliography section name
\defbibheading{bibchapter}[\bibname]{%
  %\section*{#1}%
  \chapter{#1}%
  \markboth{#1}{#1}}

\RequirePackage[colorlinks,citecolor=blue,urlcolor=blue,linkcolor=blue]{hyperref}

% No numbers before chapter names
\titleformat{\chapter}[display]
  {\normalfont\bfseries}{}{0pt}{\Large}

% Make line breaks less terrible
\emergencystretch 3em%
\vfuzz \hfuzz  

\def\supervisor#1{\gdef\@supervisor{#1}}
\def\affiliation#1{\gdef\@affiliation{#1}}

\endinput
