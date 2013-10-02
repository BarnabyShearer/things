/*
 * Flywheel/Crank
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;

flywheel();

module flywheel(
	crank_r = 15,
	piston_r = 6,
	thickness = 2
) {
	height = piston_r*2 - thickness;
	difference() {
		cylinder(
			r = crank_r + 3,
			h = height
		);
		e() cylinder(
			r = ease(3)/2,
			h = height
		);
		translate([
			crank_r,
			0,
			0,
		]){
			e() cylinder(
				r = ease(3)/2,
				h = height
			);
		}
	}
}

module flywheel_washer(
	thickness = 2
) {
	difference() {
		cylinder(
			r = ease(3)/2 + thickness/2,
			h = thickness/2
		);
		e() cylinder(
			r = ease(3)/2,
			h = thickness
		);
	}
}
