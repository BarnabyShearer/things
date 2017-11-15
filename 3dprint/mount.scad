/*
 * kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/2d.scad>
include <../tvrrug/tvprusa/SCADs/z-motor-mount.scad>
use <scadhelper/vitamins/nema.scad>

translate([0,0,30])
rotate([0,-90,0])
nema();
//projection()
translate([45,0,0])
mount();

module mount(
	rod = 8,
	rod_pitch = 58.5,
	material = [
		8,
		"Acrylic",
		[color_steel[0], color_steel[1], color_steel[2], .5]
	],
	size = [110, 80],
	mount = 7.5,
	bolt = 3.5,
	bolt_pitch = 50,
	id = 1
) {
	2d(
		size,
		material,
		id + 1
	) union() {
		for(x=[0:1]) {
			translate([-45, space(rod_pitch, x), 0]) {
				kerf_cylinder(rod/2, material[0]);
			}
			translate([10, space(rod_pitch, x), 0]) {
				kerf_cylinder(mount/2, material[0]);
				for(y=[0:1]) {
					translate([space(bolt_pitch, y), 0, 0]) 	{
						kerf_cylinder(bolt/2, material[0]);
					}
				}
			}
		}
		translate([-size[0]/2 - .1,-30/2,0])
			kerf_cube([15,30,material[0]]);
	}
}