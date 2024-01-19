# Makefile for LaTeX Project
#
# Usage:
#   - 'make': Cleans the directory, compiles the LaTeX project, and tidies up.
#   - 'make dirty': Compiles the LaTeX project without cleaning.
#   - 'make clean': Cleans the intermediate files and the generated PDF.
#
# Copyright (c) 2024 Radost Waszkiewicz
# License: MIT

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

format:
	latexindent -l -m -w $(TEXFILE).tex
#   Safer variant below	
#	latexindent -l -m $(TEXFILE).tex -o formatted_main.tex	
#	echo "Check formatted_main.tex" for formatted source.

.PHONY: all clean dirty
