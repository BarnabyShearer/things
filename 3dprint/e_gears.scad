/*
 * extruder gears
 *
 * Simple double helix gears for extruders
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/herringbone.scad>
use <scadhelper/vitamins/hardware.scad>

e_gears();

module e_gears(
	teeth = [11, 45],
	pitch = 40,
	h = 10,
	motor_shaft = 5,
	drive_shaft = 8,
	id
) {
	part(id, "Motor gear") {
		difference() {
			herringbone(
				number_of_teeth = teeth[0],
				circular_pitch = 360 * pitch / (teeth[0] + teeth[1	]),
				helix_angle = 360 / teeth[0],
				h = h
			);
			e() cylinder(
				r = motor_shaft/2,
				h = h
			);		
		}
	}
	part(id + 1, "Drive gear") {
		translate([0,pitch,0]) {
			difference() {
				herringbone(
					number_of_teeth = teeth[1],
					circular_pitch = 360 * pitch / (teeth[0] + teeth[1]),
					helix_angle = 360 / teeth[1],
					h = h
				);
				e() cylinder(
					r = drive_shaft/2 +.1,
					h = h
				);
				translate([
					0,
					0,
					10 - drive_shaft*.8
				]) {
					e() m_nut(
						drive_shaft,
						id = -1
					);
				}
			}
		}
	}
	translate([0,pitch,h]) {
		rotate([180,0,0]) {
			if($children>0) for (i = [0 : $children-1]) child(i);
		}
	}
}
