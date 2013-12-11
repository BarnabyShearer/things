/*
 * heated bed
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>

heated_bed();

module heated_bed(
	size = 200,
	h = 1.6,
	id
) {
	part(id, "Heated Bed ", size, "x", size, "x", h, "mm") {
		color([.8,0,0]) {
			translate([
				-size/2,
				-size/2,
				-h
			]) {
				cube([
					size,
					size,
					h
				]);
			}
		}
	}
}


