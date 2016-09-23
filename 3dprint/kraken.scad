/*
 * Kraken
 *
 * Copyright 2013 E3D-Online Limited, <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/rod.scad>
use <e3.scad>

kraken() {
	water_tube();
	water_tube();
	bowden();
	bowden();
	bowden();
	bowden();
}

module bowden(
	h = 100,
	id
) {
	color(color_plastic) cylinder(r = 1.75/2, h=h);
	part(id, "Bowden tube") color([1,1,1,.5]) {
		difference() {
			cylinder(r = 4/2, h=h);
			e() cylinder(r = 2/2, h=h);
		}
	}
}

module water_tube(
	h = 100,
	id
) {
	color([.5,.5,1,.5]) cylinder(r = 6/2, h=h);
	part(id, "Water tube") color([1,1,1,.5]) {
		difference() {
			cylinder(r = 8/2, h=h);
			e() cylinder(r = 6/2, h=h);
		}
	}
}

module kraken(id) {
	for(x=[0:1]) {
		for(y=[0:1]) {
			translate([
				space(20, x),
				space(20, y),
				0
			]) {
				E3_nozzle(id + y*3 + x*3*2);
				E3_block(id+1 + y*3 + x*3*2);
				E3_break(id+2 + y*3 + x*3*2);
			}
		}
	}

	translate([
		0,
		0,
		19
	]) {
		color(color_steel) part(id +13, "Kraken block") difference() {
			translate([
				-40/2,
				-35/2,
				0
			]) {
				cube([
					40,
					35,
					20
				]);
			}
			translate([
				-40/2,
				0,
				4
			]) {
				rotate([0,90,0]) e() cylinder(
					r = 6/2,
					h = 40
				);
			}
			for(x=[0:1]) {
				translate([
					space(20, x),
					0,
					4
				]) {
					e() cylinder(
						r = 6/2,
						h = 20
					);
				}
				for(y=[0:1]) {
					translate([
						space(20, x),
						-40/2,
						space(6, y) + 5
					]) {
						rotate([-90,0,0]) e() cylinder(
							r = 3/2,
							h = 40
						);
					}
					translate([
						space(20, x),
						space(20, y),
						0
					]) {
						e() cylinder(
							r = 6/2,
							h = 20
						);
					}
					translate([
						space(40-3.5*2, x),
						space(35-3.5*2, y),
						0
					]) {
						e() cylinder(
							r = 3/2,
							h = 20
						);
					}
				}
			}
		}
		for(x=[0:1]) {
			translate([
				space(40-6, x)-6/2,
				0,
				4
			]) {
				part(id+14+x, "Water seal M6") color(color_brass) rotate([0,90,0]) e() cylinder(
					r = 6/2,
					h = 6
				);
			}
			translate([
				space(20, x),
				0,
				20
			]) {
				hose_barb(id+25+x);
			}
		}
		for(x=[0:1]) {
			for(y=[0:1]) {
				for(z=[0:1]) {
					translate([
						space(20, x),
						space(35 - 3, y) - 5/2,
						space(6, z) + 5
					]) {
						part(id+16+x*2*2+y*2+z, "Water seal M3") color([0,0,0]) rotate([-90,0,0]) cylinder(
							r = 3/2,
							h = 5
						);
					}
				}
			}
		}
	}

	for(x=[0:1]) {
		translate([
			space(20, x),
			0,
			19 + 20 + 1.5
		]) {
			child(x);
		}
	}
	for(x=[0:1]) {
		for(y=[0:1]) {
		   translate([
				space(20, x),
				space(20, y),
				19 + 20
			]) {
				child(2+x*2 + y);
			}
		}
	}		
}

module hose_barb(id) {
	part(id, "Hose barb") color(color_steel) {
		difference() {
			union() {
				translate([0,0,-7]) {
					threaded_rod(
						r = 6/2,
						h = 7,
						id = -1
					);
				}
				cylinder(
					r = 7/2,
					h = 1.5
				);
				cylinder(
					r = 6/2,
					h = 3
				);
				for(z=[1:3]) {
					translate([
						0,
						0,
						z*3
					]) {
						cylinder(
							r1 = 7/2,
							r2 = 6/2,
							h = 3
						);
					}
				}
			}
			translate([0,0,-7]) {
				e() cylinder(
					r = 4/2,
					h = 19
				);
			}
		}
	}
}