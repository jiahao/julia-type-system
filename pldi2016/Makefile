MAIN=pldi2016

pdf:
	latexmk -pdf -shell-escape -halt-on-error $(MAIN)

clean:
	rm -vf *.aux *.fls *.fdb_latexmk *.log *.toc *.tdo $(MAIN).pdf *.bbl *.blg

