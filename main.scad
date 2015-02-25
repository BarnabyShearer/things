/*
 * Fastruder
 *
 * ©2015 b@Zi.iS
 */

include <scadhelper/main.scad>;


difference() {
	//Heater block
	intersection() {
		cylinder(	
			d1=3.5,
			d2=150,
			h=28
		);
		translate([0,0,-5])
			rotate([0,-45,0])
				cube([21+5,5,21+5]);
	}

	//Nozzle
	e() cylinder(
		d=2,
		h=2
	);

	//Feeds
	translate([0,0,2]) {
		rotate([0,-45,0]) {	
			cylinder(
				d=2,
				h=21
			);
			e() translate([0,0,21-5]) cylinder(
				d=6,
				h=5
			);
		}
		rotate([0,45,0]) {
			cylinder(
				d=2,
				h=21
			);
			e() translate([0,0,21-5]) cylinder(
				d=6,
				h=5
			);
		}
	}

	//Heater
	translate([0,0,8])
		e() cylinder(d=6, h=20);
}

//Heatsyncs
#translate([0,0,2]) {
	for(x=[-45,45]) {
		rotate([0, x, 0]) {
			translate([0,0,21+2.1]) {
				cylinder(d=22.3, h=26);
				cylinder(d=16, h=42.7);
			}
		}
	}
}
