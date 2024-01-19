TEXFILE = main
BIBFILE = sources

all: clean $(TEXFILE).pdf tidy
dirty: $(TEXFILE).pdf

$(TEXFILE).pdf: $(TEXFILE).tex $(BIBFILE).bib
	pdflatex $(TEXFILE).tex
	echo "Running biber"
	biber $(TEXFILE)
	echo "Running pdflatex second time"
	pdflatex $(TEXFILE).tex
	echo "Compilation finished"	

tidy:
	echo "Tidying up"
	rm -f *.aux *.log *.bbl *.bcf *.blg *.run.xml *.toc *.out

clean:
	echo "Cleaning the stage"
	rm -f *.aux *.log *.bbl *.bcf *.blg *.run.xml *.toc *.out *.pdf

.PHONY: all clean
