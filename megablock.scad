/*
 * E3
 *
 * Copyright 2013 E3D-Online Limited, <b@Zi.iS>
 * License CC BY 3.0
 */

$fn=60;

include <scadhelper/main.scad>

difference() {

	intersection() {
		color([.7,.7,.5]) cylinder(d=25.4*2/sqrt(3), h=35, $fn=6);
		cylinder(d1=270, d2=0, h=36.3);
		translate([0,0,-1]) cylinder(d1=0, d2=300, h=40);
	}
	for(x=[0:2])
		rotate([0,0,360/3*x]) {
			translate([0,.6,-.2]) rotate([0,16,60]) {
				cylinder(d=1.2, h=50);
				translate([0,0,31]) {
					cylinder(d=6, h=100);
				}
			}
			
			translate([8,0,0])
				e() cylinder(d=6.35, h=35);
		}
}

for(x=[0:2])
	rotate([0,0,360/3*x]) {
//		intersection() {
//				rotate([0,0,-30]) {
//					linear_extrude(h=200) polygon([
//						[0, 0],
//						[tan(60)*100, 100],
//						[-tan(60)*100, 100],
//					]);
//				}
			translate([0,.6,-.1]) rotate([0,16,60]) {
	
				translate([0,0,30]) {
					E3_break(id+2);
					translate([0,0,7.1])
						E3_sink(id+3);
				}
			}
//		}
	}
	

module E3_break(id) {
	part(id, "E3 Heat Break") color(color_steel) {
		difference() {
			union() {
				cylinder(
					r = 6/2,
					h = 7.1 - 2.1
				);
				cylinder(
					r = 4.8/2,
					h = 7.1 + 14.8
				);
				translate([
					0,
					0,
					7.1
					]) {
					cylinder(
						r = 6/2,
						h = 14.8
					);				
				}
			}
			e() cylinder(
				r = 2/2,
				h = 7.1 + 14.8
			);
		}
	}
}

module E3_sink(id) {
	part(id, "E3 Heat Sink V6") color(color_steel) {
		difference() {
			union() {
				for(i=[0:10]) {
					translate([0, 0, 2.5*i]) {
						cylinder(
							r = 22.3/2 - (i == 0 ? 1.7 : 0) - (i == 1 ? 1 : 0) - (i == 2 ? .5 : 0),
							h = 1
						);
					}
				}
				cylinder(
					d1 = 16,
					d2 = 8,
					h = 26 + 2.5 + 1.5
				);
				translate([0, 0, 26 + 1.5]) cylinder(
					d = 16,
					h = 1
				);
				translate([0, 0, 26 + 2.5 + 1.5]) cylinder(
					d = 16,
					h = 3
				);
				translate([0, 0, 26 + 2.5 + 1.5]) cylinder(
					d = 12,
					h = 3 + 6 + 3.7
				); 
				translate([0, 0, 26 + 2.5 + 1.5 + 3 + 6]) cylinder(
					d = 16,
					h = 3.7
				);
			}
			translate([0, 0, 37]) {
				e() cylinder(
					d = 8,
					h = 6
				);
			}
			e() cylinder(
				d = 2,
				h = 50.1
			);
		}
	}
}
