MAIN=pldi2015

pdf:
	latexmk -pdf $(MAIN)
	pdflatex -draft -halt-on-error $(MAIN)

clean:
	rm -vf *.aux *.fls *.fdb_latexmk *.log *.toc $(MAIN).pdf *.bbl *.blg

