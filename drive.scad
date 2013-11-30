/*
 * Drive
 *
 * Copyright 2013 <b@Zi.iS>, <richard.ibbotson@btinternet.com>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
include <scadhelper/vitamins/bearing.scad>
use <scadhelper/vitamins/thrust_bearing.scad>
use <bevel_gears.scad>

drive();

module drive(
	rod = 8,
	id = 0
) {
	thrust_bearing(
		size = (rod+2),
		id = id + 1
	) {
		insert(
			rod = rod,
			id = id + 2
		) {
			bevel_gears(id = id + 3) {
				if($children>0) for (i = [0 : $children-1]) child(i);
			}
			translate([
				0,
				0,
				13.5
			] * preview) {
				bearing(
					size = bearing67002_size[rod+2],
					id = id + 4
				);
			}
		}
	}
}

module insert(
	rod,
	id
) {
	part(id, str("Brass drive-insert"))
	color(color_brass) {
		difference() {
			union() {
				translate([
					0,
					0,
					-5.7
				]) {
					cylinder(
						r = (rod+2)/2,
						h = 26.3
					);
				}
				cylinder(
					r = 25/2,
					h = 3
				);
				cylinder(
					r = 12/2,
					h = 16.5
				);
			}
			translate([
				0,
				0,
				-5.7
			]) {
				e() {
					cylinder(
						r = rod/2,
						h = 26.3
					);
				}
			}
		}
	}

   translate([
        0,
        0,
        3
   ] * preview) {
        if($children>0) for (i = [0 : $children-1]) child(i);
   }
}