/*
 * Mount
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <piston.scad>;

mount();

module mount(
	width = 5,
	crank_r = 15,
	valve_r = 2,
	air_r = 4.5/2,
	piston_h = 3,
	double = 1,
	clearence = 2,
	thickness = 2
) {
	offset1 = crank_r + 3 + clearence + width*2;
	offset2 = piston_length(crank_r, valve_r, thickness, double, clearence, piston_h);
	max_deflection = asin(crank_r / offset2);
	min_deflection = asin(ease(valve_r*2)/2 / crank_r) * 2;
	echo("Deflection:", min_deflection, "-", max_deflection);
	airtube = sqrt((PI * valve_r*valve_r));

	size = [
		offset1 + offset2 + crank_r + valve_r*2,
		width,
		width
	];
	difference() {
		union() {

			//Support
			translate([
				-offset1,
				-size[1]/2,
				0
			]) {
				cube(
					size
				);
			}

			//Crank support
			cylinder(
				r = ease(3)/2 + 5/2,
				h = size[2]
			);

			//Cylinder support
			translate([
				offset2,
				0,
				0
			]) {
				cylinder(
					r = ease(3)/2 + 5/2,
					h = size[2]
				);
			}

			//Valve supports
			translate([
				offset2,
				0,
				0
			]) {
				curve(
					r1 = ease(3)/2 + 5/2,
					r2 = crank_r,
					h = size[2]*(1-double) + (thickness*2 + airtube)*double,
					min_deflection = min_deflection,
					max_deflection = max_deflection
				);
			}
			translate([
				offset2,
				0,
				0
			]) {
				curve(
					r1 = ease(3)/2 + 5/2,
					r2 = crank_r,
					h = size[2],
					min_deflection = -max_deflection,
					max_deflection = -min_deflection
				);
			}
			if(double==1) {
				translate([
					offset2,
					0,
					0
				]) {
					curve(
						r1 = ease(3)/2 + 5/2,
						r2 = -crank_r - piston_h,
						h = size[2],
						min_deflection = min_deflection,
						max_deflection = max_deflection
					);
				}
				translate([
					offset2,
					0,
					0
				]) {
					curve(
						r1 = ease(3)/2 + 5/2,
						r2 = -crank_r - piston_h,
						h = size[2]*(1-double) + (thickness*2 + airtube)*double,
						min_deflection = -max_deflection,
						max_deflection = -min_deflection
					);
				}

				//Air tube
				translate([
					offset2 - crank_r - piston_h,
					width/2,
					0
				]) {
					cube([
						crank_r*2 + piston_h,
						thickness + airtube,
						thickness*2 + airtube
					]);
				}

				//Air intet
				translate([
					offset2 + crank_r * cos(min_deflection),
					 crank_r * sin(min_deflection),
					0
				]) {
					cylinder(
						r = air_r,
						h = thickness * 8
					);
				}
				translate([
					offset2 + crank_r * cos(min_deflection),
					 crank_r * sin(min_deflection),
					thickness * 6.5
				]) {
					sphere(
						r = air_r * 1.2
					);
				}		
			}
		}

		//Crank pivot
		e() cylinder(
			r = ease(3)/2,
			h = size[2]
		);

		//Cylinder pivot
		translate([
			offset2,
			0,
			0
		]) {
			e() cylinder(
				r = ease(3)/2,
				h = size[2]
			);
		}

		//Valves
		translate([
			offset2,
			0,
			0
		]) {
			e() curve(
				r1 = ease(3)/2,
				r2 = crank_r,
				h = size[2],
				min_deflection = min_deflection,
				max_deflection = max_deflection
			);
		}
		translate([
			offset2,
			0,
			0
		]) {
			e() curve(
				r1 = ease(3)/2,
				r2 = crank_r,
				h = size[2],
				min_deflection = -max_deflection,
				max_deflection = -min_deflection
			);
		}
		if(double==1) {
			translate([
				offset2,
				0,
				0
			]) {
				e() curve(
					r1 = ease(3)/2,
					r2 = -crank_r - piston_h,
					h = size[2],
					min_deflection = min_deflection,
					max_deflection = max_deflection
				);
			}
			translate([
				offset2,
				0,
				0
			]) {
				e(-.1,1) curve(
					r1 = ease(3)/2,
					r2 = -crank_r - piston_h,
					h = size[2] - thickness + .1,
					min_deflection = -max_deflection,
					max_deflection = -min_deflection
				);
			}

			//Air tube
			translate([
				offset2 - crank_r - piston_h,
				width/2,
				thickness
			]) {
				cube([
					crank_r*2 + piston_h,
					airtube,
					airtube
				]);
			}

			//Air intet
			translate([
				offset2 + crank_r * cos(min_deflection),
				 crank_r * sin(min_deflection),
				0
			]) {
				e() cylinder(
					r = valve_r,
					h = thickness * 8
				);
			}
		}
	}
}

module curve(
	r1 = ease(3)/2,
	r2 = 15,
	h = 5,
	min_deflection,
	max_deflection,
	steps = 3
) {
	hull() {
		for(i=[
			min_deflection:
			(max_deflection-min_deflection)/steps:
			max_deflection
		]) {
			translate([
				r2 * cos(i),
				r2 * sin(i),
				0
			]) {
				cylinder(
					r = r1,
					h = h
				);
			}
		}
	}
}	
