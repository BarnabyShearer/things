/*
 * Piston Cylinder
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <mount.scad>;
use <piston.scad>;

piston_cylinder();
//piston_cylinder_endcap();

module piston_cylinder(
	crank_r = 15,
	valve_r = 2,
	piston_r = 6,
	piston_h = 3,
	thickness = 2,
	clearence = 2,
	double = 1
) {
	outer_r = piston_r + thickness;
	edge = outer_r*2 / sqrt(4 + 2*sqrt(2));
	width = edge*(1 + sqrt(2));
	inner_edge = piston_r*2 / sqrt(4 + 2*sqrt(2));
	pivot = crank_r + (valve_r + thickness)*double + piston_h;
	length = crank_r*2 + (valve_r + thickness)*(double + 1) + piston_h;

	offset1 = crank_r + 3 + clearence + width*2;
	offset2 = piston_length(crank_r, valve_r, thickness, double, clearence, piston_h);
	max_deflection = asin(crank_r / offset2);
	min_deflection = asin(ease(valve_r*2)/2 / crank_r) * 2;
	airtube = sqrt((PI * valve_r*valve_r));
	size = [
		offset1 + offset2 + crank_r + valve_r*2,
		width,
		width
	];

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
				width/2+.001
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
			//Valve supports
			rotate([
				0,
				0,
				90
			]) {
				curve(
					r1 = ease(3)/2 + 5/2,
					r2 = crank_r,
					h = thickness,
					min_deflection = 0,
					max_deflection = max_deflection*2,
					steps = 5
				);
			}
			if(double==1) {
				rotate([
					0,
					0,
					90
				]) {
					curve(
						r1 = ease(3)/2 + 5/2,
						r2 = -crank_r - piston_h,
						h = thickness,
						min_deflection = -max_deflection*2,
						max_deflection = 0,
						steps = 5
					);
				}
			}
		}	

		//Piston hole
		translate([
			0,
			-pivot-.001,
			width/2
		]) {
			rotate([
				-90,
				22.5,
				0
			]) {
				e(-.1,1) cylinder(
					r = ease(piston_r),
					h = length - thickness,
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
	crank_r = 15,
	valve_r = 2,
	piston_r = 6,
	piston_h = 3,
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
