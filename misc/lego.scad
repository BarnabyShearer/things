/*
 * Lego
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>;
$fn=60;

lego = .8;
lego_e = .1;
lego_horizontal = lego * 10;
lego_plate = lego * 4;
lego_block = lego_plate * 3;
lego_knob = [lego*6/2, 1.8];
lego_t = 1.5;
lego_support = (lego_horizontal*pow(2,.5)-2*2.4)/2;

echo(lego_support);
brick();

module brick(
	x=4,
	y=2
) {
	difference() {
		translate([
			lego_e,
			lego_e,
			0,
		]) {
			cube([
				x*lego_horizontal-lego_e*2,
				y*lego_horizontal-lego_e*2,
				lego_block
			]);
		}
		translate([
			lego_e+lego_t,
			lego_e+lego_t,
			-1,
		]) {
			cube([
				x*lego_horizontal-lego_e*2-lego_t*2,
				y*lego_horizontal-lego_e*2-lego_t*2,
				lego_block
			]);
		}
	}
	for(xi=[0:x-1]) {
		for(yi=[0:y-1]) {
			translate([
				lego_horizontal/2 + lego_horizontal*xi,
				lego_horizontal/2 + lego_horizontal*yi,
				lego_block
			]) {
				cylinder(
					r = lego_knob[0],
					h = lego_knob[1]
				);
			}
		}
	}
	for(xi=[0:x-2]) {
		for(yi=[0:y-2]) {
			translate([
				lego_horizontal + lego_horizontal*xi,
				lego_horizontal + lego_horizontal*yi,
				0
			]) {
				difference() {
					cylinder(
						r = lego_support,
						h = lego_block
					);
					translate([
						0,
						0,
						-1
					]) {
						cylinder(
							r = lego_knob[0],
							h = lego_block
						);
					}
				}
			}
		}
	}
}
