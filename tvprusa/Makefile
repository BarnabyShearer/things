# Makefile
#
# Copyright 2012 <b@Zi.iS>
# License GPLv2

SLIC3R=~/.Slic3r/slic3r.ini $(shell grep ".ini" ~/.Slic3r/slic3r.ini | sed "s/^\(.\+\) = /~\/.Slic3r\/\1\//")

SRC=$(wildcard *.scad)
DEST=$(SRC:.scad=.gcode)

all: $(DEST)

%.stl: %.scad
	#HACK: Sub-shell openscad to fix broken pipe message
	$(shell openscad -m make -o "$@" -d "$@.deps" "$<")

%.gcode: %.stl $(SLIC3R)
	slic3r $(addprefix --load ,$(SLIC3R)) -o "$@" "$<"

include $(wildcard *.deps)
