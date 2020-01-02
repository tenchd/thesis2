INKSCAPE  = inkscape
DOT       = dot

TEX_FLAGS = -halt-on-error -interaction nonstopmode --shell-escape

GVIZ      = $(shell find . -name "*.dot")
SVG       = $(GVIZ:.dot=.svg)
EPS       = $(GVIZ:.dot=.eps)

RAW_DATA  = $(shell find data -name "*.csv" -type f)
GENERATED_DATA = data/spec_results_speed.tsv

SPEC_TOOL = data/build_spec_table

RSCRIPTS = $(wildcard r/*.r)
PLOTS    = $(patsubst r/%.r,plots/%.pdf,$(RSCRIPTS))
FIGURES  = figures/*

DEFAULT  = mesh.pdf # $(shell basename $(realpath .)).pdf

# quiet output, but allow us to look at what commands are being
# executed by passing 'V=1' to make, without requiring temporarily
# editing the Makefile.
ifneq ($V, 1)
MAKEFLAGS += -s
endif

# GNU make, you are the worst.
.SUFFIXES:
%: %,v
%: RCS/%,v
%: RCS/%
%: s.%
%: SCCS/s.%

# list only those we use
.SUFFIXES: .tex .pdf

all: $(DEFAULT)


data/spec_results_speed.tsv: Makefile $(SPEC_TOOL) $(RAW_DATA)
	@echo "  GEN $@ XXX: disabled!  Thanks, ShareLaTeX!"
#	python3 $(SPEC_TOOL) $@
	touch $@

data/occupancy.tsv:
	@echo "  GEN $@"
	mkdir -p data
#	./ff_occupancy.py | awk -f transpose.awk >$@
	./ff_occupancy.py >$@

%.svg: %.dot
	@echo "  DOT   $@"
	$(DOT) -Tsvg -o $@ $<

%.eps: %.svg
	@echo "  INK   $@"
	$(INKSCAPE) --export-eps=$@ $< 2>/dev/null

%.pdf: %.tex Makefile $(EPS) $(PLOTS) $(FIGURES) FORCE
	@echo "  LATEX $@"
	SOURCE_DATE_EPOCH=0 python3 build/latexrun -O . --latex-args="$(TEX_FLAGS)" $<

plots/%.pdf: r/%.r data/* $(GENERATED_DATA)
	cd plots && SOURCE_DATE_EPOCH=0 R --vanilla < ../$<
	touch $@

show: $(DEFAULT)
	evince $(DEFAULT)

build-deps:
	R --vanilla <install-packages.r

clean:
	rm -rf latex.out
	rm -f *~ *.aux *.log *.pdf *.bbl *.blg *.cut mesh.aux mesh.bbl mesh.blg mesh.fls mesh.log mesh.out $(SVG) $(EPS)
	rm -rf _minted-*

.PHONY: all clean show build-deps FORCE
.PRECIOUS: $(PLOTS)
