# the use of latexmk was taken from the question at stackexchange
# http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project

# this alias and its inclusion in .bash_profile were taken from the
# site http://wiki.inkscape.org/wiki/index.php/MacOS_X
# which also gives command line for invoking inkscape
# see also http://mirrors.rit.edu/CTAN/info/svg-inkscape/InkscapePDFLaTeX.pdf
inkscape=/Applications/Inkscape.app/Contents/Resources/bin/inkscape

INKOPTS=-D -z --file=$< --export-pdf=$@
INKOPTS_LATEX=$(INKOPTS) --export-latex

.PHONY: all html

html: docs/index.html docs/chap2.html docs/chap3.html

all: chap2.pdf chap3.pdf chap4.pdf chap5.pdf chap6.pdf chap7.pdf chap8.pdf\
	chap9.pdf chap10.pdf chap11.pdf ref.pdf

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

%.pdf : %.tex
	latexmk -pdf -pdflatex="pdflatex -interactive=nonstopmode" \
		-use-make $<

docs/%.html : %.adoc
	asciidoctor $< -o $@
clean:
	latexmk -CA
	rm docs/*.html
