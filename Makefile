# Makefile
#
# Copyright 2013 <b@Zi.iS>
# License GPLv2

PLATE=6mm STEEL

SRC=$(wildcard *.scad)
DEST=$(SRC:.scad=.stl)

all: main.stl plate.dxf

.pos: main.stl
	sed -n "s/.*PART\([0-9]\+\):${PLATE} \([0-9.]\+\)x\([0-9.]\+\)mm.*/part\1 \2 \3/gp" .log | ./scadhelper/pack.py > "$@"

plate.dxf: $(addsuffix a.dxf, $(addprefix part,$(shell grep "${PLATE}" .log | cut -c12- | cut -d: -f1)))
	head -n 11 $< > $@
	for f in $^; do tail -q -n +12 $$f | head -n -11 >> $@ ; done;
	tail -n 11 $< >> $@

part%a.dxf: .pos
	openscad -D ZCUT=0 -D preview=0 -D XOFF=`grep part$*" " .pos | cut -d" " -f2` -D YOFF=`grep part$*" " .pos | cut -d" " -f3` -D PART=$* -o $@ main.scad

%.stl: %.scad
	#HACK: Sub-shell openscad to fix broken pipe message
	$(shell openscad -D preview=0 -m make -o "$@" -d "$@.deps" "$<" 2> .log)

%.webm: *.png
	for f in *.png; do \
		convert -resize x720 -gravity center -crop 1280x720+0+0 +repage $$f ppm:-;\
	done | ffmpeg -r 30 -f image2pipe -c:v ppm -i pipe: -c:v libvpx -b:v 10M -crf 20 "$@"

include $(wildcard *.deps)
