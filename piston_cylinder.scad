/*
 * Piston Cylinder
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;

piston_cylinder();
piston_cylinder_endcap();

module piston_cylinder(
	crank_r = 16,
	valve_r = 2,
	piston_r = ease(6),
	piston_h = 6,
	thickness = 2,
	double = 1
) {
	outer_r = piston_r + thickness;
	edge = outer_r*2 / sqrt(4 + 2*sqrt(2));
	width = edge*(1 + sqrt(2));
	inner_edge = piston_r*2 / sqrt(4 + 2*sqrt(2));
	pivot = crank_r + (valve_r + thickness)*double + piston_h;
	length = crank_r*2 + (valve_r + thickness)*(double + 1) + piston_h;

	difference() {

		union() {

			//Mount/valve
			translate([
				-width/2,
				-pivot,
				0
			]) {
				cube([
					width,
					length,
					width/2,
				]);
			}

			//Casing
			translate([
				0,
				-pivot,
				width/2
			]) {
					rotate([
					-90,
					22.5,
					0
				]) {
					cylinder(
						r = outer_r,
						h = length,
						$fn = 8
					);
				}
			}
		}	

		//Piston hole
		translate([
			0,
			-pivot,
			width/2
		]) {
			rotate([
				-90,
				22.5,
				0
			]) {
				e(-.1,1) cylinder(
					r = piston_r,
					h = length - thickness + .1,
					$fn = 8
				);
			}
		}
	
		//Valve
		e() translate([
			0,
			crank_r,
			0,
		]) {
			cylinder(
				r = valve_r,
				h = width/2
			);
		}
		if(double == 1) {
			e() translate([
				0,
				-crank_r - piston_h,
				0,
			]) {
				cylinder(
					r = valve_r,
					h = width/2
				);
			}
		}

		//Pivot
		e()	cylinder(
			r = ease(3)/2,
			h = width/2
		);
	
		//Pivot countersink
		translate([
			0,
			0,
			thickness/2 ,
		]) {
			cylinder(
				r = inner_edge/2,
				h = thickness/2
			);
		}
	}
}

module piston_cylinder_endcap(
	crank_r = 16,
	valve_r = 2,
	piston_r = ease(6),
	piston_h = 6,
	thickness = 2,
	double = 1
) {
	pivot = crank_r + (valve_r + thickness)*double + piston_h;
	outer_r = piston_r + thickness;
	edge = outer_r*2 / sqrt(4 + 2*sqrt(2));
	width = edge*(1 + sqrt(2));
	
	if(double==1) {
		translate([
			0,
			-pivot,
			width/2
		]) {
			intersection() {
				rotate([
					-90,
					22.5,
					0
				]) {	
					cylinder(
						r = piston_r,
						h = thickness,
						$fn = 8
					);
				}

				translate([
					-piston_r,
					0,
					-piston_r
				]) {
				  cube([
						piston_r*2,
						thickness,
						piston_r*2 - thickness,
					]);
				}
			}
		}
	}
}