\LoadClass[showtrims,11pt]{memoir}

\RequirePackage{textcase}
\RequirePackage{lastpage}
\RequirePackage{graphicx}
\RequirePackage{textcomp}
\RequirePackage{floatpag}
\RequirePackage{lipsum}

\RequirePackage{Times}
\RequirePackage[protrusion=true,expansion]{microtype}
\RequirePackage{ucs}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}

\RequirePackage[brazilian]{babel}
\defineshorthand{"-}{\discretionary{-}{-}{-}}

\RequirePackage{../../../templates/template_1/pacotes/hedralogo}
\RequirePackage{../../../templates/template_1/pacotes/hedrapagina}
\RequirePackage{../../../templates/template_1/pacotes/hedrasumario}
\RequirePackage{../../../templates/template_1/pacotes/hedrageral}
\RequirePackage{../../../templates/template_1/pacotes/hedraextra}

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

