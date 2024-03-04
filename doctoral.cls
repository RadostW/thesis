%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% doctoral.cls 
% LaTeX Class for Doctoral Dissertations 
% at the University of Warsaw
%
% Copyright (c) 2024 Radost Waszkiewicz
% License: MIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

\renewcommand\maketitle{
    \begin{titlepage}        
        \begin{center}
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
    \end{titlepage}    
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
\defbibheading{bibchapter}[\bibname]{
    \chapter{#1}
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

\newcounter{publications}
\setcounter{publications}{1}

\newcommand{\pubtitle}[1]{%
    \citefield{#1}{title}%
}

\newcommand{\pubauthors}[1]{%
    \AtNextCite{%
        \DeclareNameAlias{labelname}{given-family}%
        \AtEachCitekey{\defcounter{maxnames}{999}}%
    }%
    \citeauthor{#1}%
}

\renewcommand{\thepublications}{\Roman{publications}}

% publication page environment
% #1 - bibtex key for the publication
% #2 - plaintext title for pdf table of contents
\newenvironment{publicationpage}[2]{
    \section{Paper \thepublications: \texorpdfstring{\emph{\pubtitle{#1}}}{#2}}
    \begin{center}
        \hrule
        \vspace{0.7em}
        {\Large \textsc{Paper \thepublications}}\\
        \vspace{0.7em}
        \hrule
        \vspace{2em}
        {\Large ``\emph{\pubtitle{#1}}''}\\
        \vspace{2em}
        {\Large \pubauthors{#1}}\\
        \vspace*{3em}
    \end{center}

    \long\def\commentary##1{
        \begin{center}
            \textsc{Commentary}
        \end{center}
        ##1 % Content of the commentary
        \par
    }
}{
    \stepcounter{publications}
    \clearpage
}

% Other research activity citation page style
% #1 - cictaion key

\newcommand{\publicationblock}[1]{%
    \AtNextCite{%
        \DeclareNameAlias{labelname}{given-family}%
        \AtEachCitekey{\defcounter{maxnames}{999}}%
    }%
    \abstractfullcite{#1}%
}

\DeclareCiteCommand{\abstractfullcite}
  {\usebibmacro{prenote}}
  {\usedriver
     {\DeclareNameAlias{sortname}{default}}
     {\thefield{entrytype}}}
  {\multicitedelim}
  {
    \par    
    \usebibmacro{printabstract}
    \usebibmacro{postnote}
    \rule{\linewidth}{0.4pt}
  }

\newbibmacro{printabstract}{%
  \textsc{Abstract}: \printfield{abstract}%
}

\endinput
