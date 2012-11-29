/*
 * HP drive rail
 *
 * Rails for mounting drives in a HP ProLiant ML150
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn=60;
offset = 6; // 6=left rail, -6= right rail

difference() {


	minkowski() {
		cube([
			20-10,
			150-10,
			3.5
		]);
		cylinder(
			r=5
		);
	}
	
	translate([
		10-offset-5,
		23.5-5,
		-1
	]) {
		cylinder(
			r = 3.5/2,
			h=10
		);
	}
	translate([
		10-offset-5,
		23.5-5,
		2
	]) {
		cylinder(
			r = 7/2,
			h=10
		);
	}

	translate([
		10-offset-5,
		65-5,
		-1
	]) {
		cylinder(
			r = 3.5/2,
			h=10
		);
	}
	translate([
		10-offset-5,
		65-5,
		2
	]) {
		cylinder(
			r = 7/2,
			h=10
		);
	}

	translate([
		10-offset-5,
		125-5,
		-1
	]) {
		cylinder(
			r = 3.5/2,
			h=10
		);
	}
	translate([
		10-offset-5,
		125-5,
		1.3
	]) {
		cylinder(
			r = 7/2,
			h=10
		);
	}

}
