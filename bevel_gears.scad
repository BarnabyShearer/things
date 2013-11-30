/*
 * Mockup of our bevel gears
 *
 * Copyright 2013 <b@Zi.iS>, <richard.ibbotson@btinternet.com>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;

bevel_gears();

module bevel_gears(
	rotation = 360*$t,
	id
) {
	part(id, "Bevel gear set") {
		translate([0,0,13])
		rotate([180,0,rotation]) 
		color(color_steel) difference() {
			union() {
				cylinder(
					r = 21/2,
					h = 13
				);
				translate([
					0,
					0,
					8
				]) {
					difference() {
						union() {
							cylinder(
								r = 47.15/2,
								h = 6
							);
							translate([
								0,
								0,
								6
							]) {
								cylinder(
									r1 = 47.15/2,
									r2 = 35/2,
									h = 1.2
								);
							}
						}
						translate([
							0,
							0,
							5
						]) {
							cylinder(
								r = 35/2,
								h = 4
							);
						}
					}	
				}
			}
			e() cylinder(
				r = 12/2,
				h = 13
			);
		}
		rotate([
			0,
			90,
			180
		]) {
			translate([
				-12.7/2 + 13,
				0,
				-15 - 35/2 
			]) {
				rotate([
					0,
					0,
				 	rotation * 2.75
				]) {
					color(color_steel) difference() {
						cylinder(
							r1 = 17/2,
							r2 = 12.7/2,
							h = 15
						);
						e() cylinder(
							r = 6/2,
							h = 15
						);
					}
				}
			}
		}
	}
	rotate([
		0,
		90,
		180
	] * preview) {
		translate([
			-12.7/2 + 13,
			0,
			-15 - 35/2 
		] * preview) {
			rotate([
				0,
				180,
				0
			] * preview) {
				if($children>0) for (i = [0 : $children-1]) child(i);
			}
		}
	}
}
