all:
	pdflatex LIVRO.tex
	pdflatex LIVRO.tex
	evince LIVRO.pdf
	rm *.aux *.dvi *.log LIVRO.pdf *.aux *.ps *.toc *.out

clean:
	rm *.aux *.dvi *.log LIVRO.pdf *.aux *.ps *.toc *.out

dic:
	@echo "personal_ws-1.1 pt_BR `cat *.tex | aspell -l pt_BR -t list | sort | uniq | wc -l` utf-8" > dic.pws
	@cat *.tex | aspell -l pt_BR -t list | sort | uniq >> dic.pws
	sh dic.sh

