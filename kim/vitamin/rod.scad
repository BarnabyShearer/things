/*
 * rod
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../config.scad>;

rod();

module rod(
	r = 8/2,
	h = 250
) {
	echo("Smooth rod ", r*2, "mm x ", h, "mm");
	color(color_steal) {
		cylinder(
			r = r,
			h = h
		);
	}
}

module threaded_rod(
	r = 8/2,
	h = 250,
	pitch = 1.26,
) {
	echo("Threaded rod ", r*2, "mm x ", h, "mm");
	color([.7,.7,.7]) {
		cylinder(
			r = r*.8,
			h = h
		);
		%cylinder(
			r = r,
			h = h
		);
	}

	/* Proper version but too slow
	color(color_steal) {
		linear_extrude(
			height = h,
			twist = -h/pitch*360
		) {
			translate([.866*pitch,0,0]) {
				circle(
					r=r 
				);
			}
		}
	}*/
}

