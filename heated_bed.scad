/*
 * heated bed
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>

heated_bed();

module heated_bed(
	size = 215,
	h = 1.6,
	id
) {
	part(id, "Heated Bed ", size, "x", size, "x", h, "mm") {
		difference() {
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
			for(x=[0:1]) for(y=[0:1]) {
				translate([
					space(208, x),
					space(208, y),
					-5
				]) {
					kerf_cylinder(r = 3/2, h=8.1);
				}
			}
		}
	}
}


