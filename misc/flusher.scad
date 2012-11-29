/*
 * flusher
 *
 * Replacement handle leaver for a toliet flush mechanism.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn=60;

difference(){
	union() {
		cylinder(
			r=25/2,
			h=15
		);
		translate([
			-25/2,
			0,
			0
		]) {
		cube([
				25,
				55,
				5
			]);
		}
		translate([
			0,
			55,
			0
		]) {
			cylinder(
				r=15/2,
				h=5
			);
		}
	}
	translate([
		0,
		0,
		15/2
	]) {
		rotate([
			0,
			0,
			-25,
		]) {
			cube([
				8.2,
				8.2,
				15+2
			],
			center=true);
		}
	}
	translate([
		0,
		55,	
		-1
	]) {
		cylinder(
			r=5/2,
			h=10+2
		);
	}
	translate([
		25/2,
		0,
		-1,
	]) {
		rotate([
			0,
			0,
			5
		]) {
			cube([
				25,
				57,
				10+2
			]);
		}
	}
	translate([
		-25-25/2,
		0,
		-1,
	]) {
		rotate([
			0,
			0,
			-5
		]) {
			cube([
				25,
				58,
				10+2
			]);
		}
	}

}
