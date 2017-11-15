# Makefile
#
# Copyright 2013 <b@Zi.iS>
# License GPLv2
.PRECIOUS: *.stl

SLIC3R=~/.Slic3r/slic3r.ini $(shell grep ".ini" ~/.Slic3r/slic3r.ini | sed "s/^\(.\+\) = /~\/.Slic3r\/\1\//")

SRC=$(wildcard *.scad)
DEST=$(SRC:.scad=.stl)

all: $(DEST)

%.stl: %.scad
	#HACK: Sub-shell openscad to fix broken pipe message
	$(shell openscad -D preview=0 -m make -o "$@" -d "$@.deps" "$<")

%.gcode: %.stl $(SLIC3R)
	slic3r $(addprefix --load ,$(SLIC3R)) -o "$@" "$<"

%.y4m: *.png
	for f in *.png *.png *.png; do \
		convert -resize x720 -gravity center -crop 1280x720+0+0 +repage $$f ppm:-;\
	done | ppmtoy4m -F 25:1 > $@

%.webm: %.y4m
	vpxenc $+ -o $@ -p 2

include $(wildcard *.deps)
