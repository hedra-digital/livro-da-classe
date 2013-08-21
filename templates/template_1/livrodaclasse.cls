\LoadClass[showtrims,11pt]{memoir}

\RequirePackage{textcase}
\RequirePackage{lastpage}
\RequirePackage{graphicx}
\RequirePackage{textcomp}
\RequirePackage{floatpag}
\RequirePackage{lipsum}
\RequirePackage{times}

%\RequirePackage[minionint,mathlf]{MinionPro}
\RequirePackage[protrusion=true,expansion]{microtype}
\RequirePackage{ucs}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}

\RequirePackage[brazilian]{babel}
\defineshorthand{"-}{\discretionary{-}{-}{-}}

\RequirePackage{pacotes/hedralogo}
\RequirePackage{pacotes/hedrapagina}
\RequirePackage{pacotes/hedrasumario}
\RequirePackage{pacotes/hedrageral}
\RequirePackage{pacotes/hedraextra}

\AtBeginDocument{%
\makeatletter
\fontsize{11pt}{\baselineskip}\selectfont
\baselineskip=14.4pt\@plus.2pt
\selectlanguage{brazilian}
\pagestyle{empty}
\setcounter{tocdepth}{0}
\setcounter{secnumdepth}{-2}
\makeatother
}%

