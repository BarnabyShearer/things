/*
 * linear bearing
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../config.scad>;

linear_bearing();

module linear_bearing(
	size = lm8uu,
) {
	echo("Linear bearing ", size[1] * 2, "mm");
	color(color_steal) {
		translate([
			0,
			0,
			-size[2]/2
		]) {
			difference() {
				union() {
					cylinder(
						r = size[0] - 1,
						h = size[2]
					);
					cylinder(
						r = size[0],
						h = 3.4
					);
					translate([
						0,
						0,
						3.4 + 1.25
					]) {
						cylinder(
							r = size[0],
							h = size[2] - (3.4 + 1.25) * 2
						);
					}
					translate([
						0,
						0,
						size[2] - 3.4
					]) {
						cylinder(
							r = size[0],
							h = 3.4
						);
					}
				}
				e() cylinder(
					r = size[1],
					h = size[2]
				);
			}
		}
	}
}