%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[11pt]{memoir}

\RequirePackage[T1]{fontenc}
\RequirePackage[brazilian]{babel}
\RequirePackage{xtab,comment,graphicx,ulem,textcomp,lastpage,textcase,manyfoot}
\RequirePackage[squarebr]{gmverse}
\RequirePackage{ucs}

\defineshorthand{"-}{\discretionary{-}{-}{-}}

\RequirePackage{fontspec,xltxtra,xunicode}
\defaultfontfeatures{Mapping=tex-text}
\setromanfont[Mapping=tex-text]{Charis SIL}

\makeheadstyles{teca}{%
%
\renewcommand*{\booknamefont}{\normalfont\huge}
\renewcommand*{\booknumfont}{\normalfont\huge}
\renewcommand*{\booktitlefont}{\normalfont\huge}
\renewcommand*{\midbookskip}{\par\vskip 2\onelineskip}%
%
\renewcommand*{\partnamefont}{\normalfont\huge}
\renewcommand*{\partnumfont}{\normalfont\huge}
\renewcommand*{\parttitlefont}{\normalfont\huge}
\renewcommand*{\midpartskip}{\par\vskip 2\onelineskip}%
%
\setlength{\beforechapskip}{50pt}%
\renewcommand*{\chapnamefont}{\normalfont\Large}%
\renewcommand*{\chapnumfont}{\normalfont\Large}%
\renewcommand*{\chaptitlefont}{\normalfont\Large}%
%
\setbeforesecskip{-1.333\onelineskip
\@plus -0.5\onelineskip \@minus -.5\onelineskip}%
\setaftersecskip{0.667\onelineskip \@plus 0.1\onelineskip}%
\setsecheadstyle{\centering\large\normalfont\scshape}%
%
\setbeforesubsecskip{-0.667\onelineskip
\@plus -0.25\onelineskip \@minus -0.25\onelineskip}%
\setaftersubsecskip{0.333\onelineskip \@plus 0.1\onelineskip}%
\setsubsecheadstyle{\normalfont\normalsize\scshape}%
%
\setbeforesubsubsecskip{-0.667\onelineskip
\@plus -0.25\onelineskip \@minus -0.25\onelineskip}%
\setaftersubsubsecskip{0.333\onelineskip \@plus 0.1\onelineskip}%
\setsubsubsecheadstyle{\normalfont\normalsize\itshape}%
%
\setbeforeparaskip{1.0\onelineskip
\@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
\setafterparaskip{-1em}%
\setparaheadstyle{\normalfont\normalsize\scshape}%
%
\setsubparaindent{\parindent}%
\setbeforesubparaskip{1.0\onelineskip
\@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
\setaftersubparaskip{-1em}%
\setsubparaheadstyle{\normalfont\normalsize\scshape}
}

\makepagestyle{teca}
\makeheadposition{teca}{flushright}{flushleft}{}{}
\makepsmarks{teca}{%
  \nouppercaseheads
  \createmark{chapter}{both}{nonumber}{}{}
%  \createmark{section}{right}{nonumber}{}{}
  \let\sectionmark\@gobble
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}}
 \makeevenhead{teca}{\normalfont\footnotesize\thepage}{}%
                        {\normalfont\small\scshape\MakeLowercase{\leftmark}}				% \leftmark => chaptername
 \makeoddhead{teca}{\normalfont\small\scshape\MakeLowercase{\rightmark}}{}%   	% \rightmark => sectionname
                       {\normalfont\footnotesize\thepage}    
 \makeevenfoot{plain}{}{\normalfont\footnotesize\thepage}{}
 \makeoddfoot{plain}{}{\normalfont\footnotesize\thepage}{}

\footmarkstyle{\normalfont{\raisebox{3pt}{\tiny#1}}}
\def\@makefnmark#1{{\tiny \raisebox{3pt}{\@thefnmark}}}
\skip\footins=7mm\@plus1mm\@minus4mm
%\show\@makefnmark

\renewcommand{\cftparskip}{0ex}
\renewcommand{\cftchapterdotsep}{4.5}
\renewcommand{\cftchapterleader}{\normalfont\cftdotfill{\@nameuse{cftchapterdotsep}}}
\renewcommand{\cftpartfont}{\large}
\renewcommand{\cftpartformatpnum}{\large}
\renewcommand{\cftchapterfont}{\normalsize}
\renewcommand{\cftchapterformatpnum}{\normalsize}
\renewcommand{\cftbeforechapterskip}{.2em}
\renewcommand{\cftbeforepartskip}{1.2em}
\renewcommand{\cftsectionindent}{0ex}
\renewcommand{\cftsectionfont}{\normalsize}
\renewcommand{\cftsectionformatpnum}{\normalsize}


\AtBeginDocument{%
\fontsize{11pt}{14.4pt}\selectfont
\renewcommand{\contentsname}{Sumário}
\parskip=0pt
\setcounter{tocdepth}{0}
\setcounter{secnumdepth}{-2}
\selectlanguage{brazilian}
\pagestyle{empty}}%


\copypagestyle{part}{empty}
\copypagestyle{chapter}{empty}
\pagestyle{teca}
\headstyles{teca}

\setstocksize{210mm}{140mm}
\settrimmedsize{210mm}{140mm}{*}
\setbinding{4mm}
\semiisopage[10]
\headsep=.8em

%\setlength{\trimtop}{4cm}
%\setlength{\trimedge}{\stockwidth}
%\addtolength{\trimedge}{-\paperwidth}
%\setlength{\trimedge}{0.5\trimedge}
%\quarkmarks
%\trimFrame

\checkandfixthelayout


\tolerance=1000
\emergencystretch=1pc
\lefthyphenmin=2
\righthyphenmin=2
\widowpenalty=10000
\clubpenalty=10000
\brokenpenalty=9999
%\raggedbottom

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\blank}{\newpage\ \\\thispagestyle{empty}\pagebreak}
\newcommand\asterisc{{\centering***\par}}

\renewenvironment{quote}%
               {\list{}{\small\rightmargin\leftmargin}%
                \item[]}%
               {\endlist}

\epigraphtextposition{flushleft}
\epigraphsourceposition{flushright}
\epigraphfontsize{\footnotesize}
\setlength{\epigraphrule}{0pt}
\setlength{\epigraphwidth}{.7\textwidth}

\newcommand{\ficha}[8][]{
    \begingroup
        \raggedright\ttfamily\fontsize{6pt}{7pt}\selectfont\hyphenpenalty=10000
        Dados Internacionais de\\ Catalogação na Publicação (CIP)\\
        (Câmara Brasileira do Livro, SP, Brasil)\\\smallskip
        \hrule\smallskip
        #2\par\smallskip
        #3 \pageref{LastPage}~p.\par\smallskip
        #1\par\smallskip
        ISBN\hskip2mm #4\par\smallskip
        #5\par\smallskip
        #6\mbox{}\hfill CDD #7\par\smallskip
        \hrule\smallskip
        Índices para catálogo sistemático:\\
        #8\par
    \endgroup}