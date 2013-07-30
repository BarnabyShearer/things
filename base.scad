/*
 * Base
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;

base();

module base(
	width = 5,
	crank_r = 16,
	piston_r = 6,
	thickness = 2
) {
	difference() {
		union() {
			translate([
				-width - (piston_r * 2 + thickness*2 + width)*.5,
				-crank_r*2,
				0,
			]) {
				cube([
					(piston_r * 2 + thickness*2 + width)*2,
					crank_r*2*2,
					thickness
				]);
			}
			translate([
				-width - thickness,
				-width/2 - thickness,
				0,
			]) {
				cube([
					width + thickness*2,
					width + thickness*2,
					width*2
				]);
			}
		}
		translate([
			-width,
			-width/2,
			0
		]) {
			e() cube([
				width,
				width,
				width*2
			]);
		}
	}
}