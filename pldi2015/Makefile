MAIN=pldi2015

pdf:
	latexmk -pdf -shell-escape -halt-on-error $(MAIN)

clean:
	rm -vf *.aux *.fls *.fdb_latexmk *.log *.toc $(MAIN).pdf *.bbl *.blg

