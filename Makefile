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
	echo "Running pdflatex first time"
	pdflatex -halt-on-error -interaction=batchmode $(TEXFILE).tex

	echo "Running biber"
	biber $(TEXFILE) | grep -v 'WARN' -A2 --color=always

	echo "Running pdflatex second time"
#   Grep only the error lines, invert exit code of grep
	pdflatex --interaction=nonstopmode $(TEXFILE).tex | awk 'BEGIN{IGNORECASE = 1}/warning|!/,/^$$/;' | grep -vi 'Warning' -A2 --color=always || true
#	pdflatex $(TEXFILE).tex

	echo "Compilation finished"

tidy:
	echo "Tidying up"
	rm -f *.aux *.log *.bbl *.bcf *.blg *.run.xml *.toc *.out *.bak*

clean:
	echo "Cleaning the stage"
	rm -f *.aux *.log *.bbl *.bcf *.blg *.run.xml *.toc *.out *.pdf *.bak*

format:
	latexindent -l -m -w $(TEXFILE).tex
#   Safer variant below
#	latexindent -l -m $(TEXFILE).tex -o formatted_main.tex
#	echo "Check formatted_main.tex" for formatted source.

htmldiff:
	git diff --word-diff --color | fold -w 160 -s | aha > diff.html
#   Create a diff in html format to share with non-git friends
#   open with system default
	open diff.html

spellcheck:
	aspell -c -t -d british --mode=tex $(TEXFILE).tex

.PHONY: all clean dirty
