/*
 * Fastruder
 *
 * ©2015 b@Zi.iS
 */

include <scadhelper/main.scad>;


difference() {
	//Heater block
	intersection() {
		translate([-31.8/2, 0, 0])
			cube([31.8, 10, 30]);
		cylinder(	
			d1=3.5,
			d2=400,
			h=30
		);	
		cylinder(	
			d2=3.5,
			d1=150,
			h=35
		);	
	}

	//Nozzle
	e() cylinder(
		d=2,
		h=2
	);

	//Feeds
	translate([0,0,2]) {
		for(x=[-25,25]) {
			rotate([0,x,0]) {	
				cylinder(
					d=2,
					h=30
				);
				translate([0,0,30-5]) cylinder(
					d=6,
					h=6
				);
			}
		}
	}

	//Heaters
	#for(x=[0:1])
		for(y=[0:2])
			translate([-31.8/2, -5 + 10*x, 5 + y * 8])
				rotate([0, 90, 0])
					cylinder(d=6.35, h=31.8);
}

//Heatsyncs
#translate([0,0,2]) {
	for(x=[-25,25]) {
		rotate([0, x, 0]) {
			translate([0,0,30+2.1]) {
				cylinder(d=22.3, h=26);
				cylinder(d=16, h=42.7);
			}
		}
	}
}
