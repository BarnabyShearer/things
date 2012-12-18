/*
 * FTDI Basic
 *
 * Copyright 2012 b@Zi.iS
 *
 * License CC BY 3.0
 */

$fn=60;

ftdi_basic();

module ftdi_basic() {

	// PCB
	color([.75,0,0]) {
		cube([
			20,
			30,
			1.6
		]);
	}

	// Header
	color([0,0,0]) {
		translate([
			1,
			24,
			-8
		]) {
			cube([
				18,
				5.1,
				8
			]);
		}
	}

	// USB
	color([.75,.75,.75]) {
		translate([
			5,
			0,
			1.6
		]) {
			cube([
				10,
				10,
				4
			]);
		}
	}

}
