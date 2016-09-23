/*
 * kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/linear_bearing.scad>
use <scadhelper/vitamins/2d.scad>
use <scadhelper/bend.scad>
use <kraken.scad>
use <../tvrrug/tvprusa/SCADs/x-end-idler.scad>
use <heated_bed.scad>

projection()
y_carriage();

module y_carriage(
	rod = 8,
	nozzel_height = 37,
	x_rod_pitch = 50,
	X = 0,
	Z = 0,
	material = [
		5,
		"Acrylic",
		[1, 1, 1]
	],
    belt_width=5,
    belt_thickness=2.5,
    belt_height = 24,
    belt_offset = 35,
    pully = 14,
    pully_length=20,
	id = 1
) {

	translate([0,0,15.2/2-2]) {
		2d(
			[230, 230],
			material
		) union() {
			for(z=[0:1]) {
				for(x=[0:1]) {
					translate([
						 space(115, x),
						 space(200, z),
						-.1
					]) {
						translate([-14,-5,0]) {
							kerf_cube([28,10,material[0]]);
						}
						translate([-2.5,-10,0]) {
							kerf_cube([5,2,material[0]]);
						}
						translate([-2.5,8,0]) {
							kerf_cube([5,2,material[0]]);
						}
					}
				}
			}
			for(x=[0:1]) for(y=[0:1]) {
				translate([
					space(208.5, x),
					space(208.5, y),
					0
				]) {
					kerf_cylinder(r = 2.5/2, h=8.1);
				}
			}
			for(y=[0:1]) {
				translate([
					space(90, y),
					0,
					0
				]) {
					kerf_cylinder(r = 2.5/2, h=8.1);
				}
			}
		}
	}

	//Y bearings
	%for(z=[0:1]) {
		for(x=[0:1]) {
			translate([
				 space(115, x),
				 space(200, z),
				0
			]) {
				rotate([
					0,
					90,
					0
				]) {
					linear_bearing(
						size = rod,
						id = id + 16 + z
					);
				}
			}
		}
	}

	%translate([0,0,20])
		heated_bed();
}