/*
 * Piston
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;

rotate([0,90,0])
piston();

module piston(
	crank_r = 15,
	valve_r = 2,
	piston_r = 6,
	piston_h = 3,
	thickness = 2,
	clearence = 2,
	double = 1
) {
	length = piston_length(crank_r, valve_r, thickness, double, clearence, piston_h);

	difference() {
		rotate([
			0,
			0,
			22.5
		]) {
			translate([
				0,
				0,
				-3*1.5
			]) {
				cylinder(
					r = piston_r,
					h = length + 3*1.5,
					$fn = 8
				);
			}
		}
		translate([
			-piston_r,
			-piston_r,
			-3*1.5
		]) {
			e(-.1,1) cube([
				piston_r*2 - thickness,
				piston_r*2,
				length + 3*1.5 - piston_h + .1
			]);
		}
		rotate([
			0,
			90,
			0,
		]) {
			translate([
				0,
				0,
				-piston_r
			]) {
				e() cylinder(
					r = ease(3)/2,
					h = piston_r*2
				);
			}
		}
	}
}

function piston_length(
	crank_r,
	valve_r,
	thickness,
	double,
	clearence,
	piston_h
) = crank_r*2 + (valve_r + thickness)*double + 3 + clearence + piston_h;
