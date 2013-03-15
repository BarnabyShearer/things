/*
 * Woggle
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>
preview=0;

woggle();

module woggle(
	r = 25/2,
	h = 20,
	t = 1.05
) {
	difference() {
		cylinder(
			r = r,
			h = h
		);
		e() cylinder(
			r = r-t*3,
			h = h
		);
		e() cylinder(
			r = r-t,
			h = (h - t*6)/2
		);
		translate([
			0,
			0,
			(h - t*6)/2
		]) {
			cylinder(
				r1 = r-t,
				r2 = 0,
				h = r-t*2
			);
		}
		translate([
			0,
			0,
			(h + t*6)/2
		]) {
			e() cylinder(
				r = r-t,
				h = (h - t*6)/2
			);
			translate([0,0,+.1])
			rotate([
				180,
				0,
				0,
			]) {
				cylinder(
					r1 = r-t,
					r2 = 0,
					h = r-t*2
				);
			}
		}
	}

		
}