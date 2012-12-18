/*
 * EVE Alpha
 *
 * Copyright 2012 b@Zi.iS
 *
 * License CC BY 3.0
 */
$fn=60;

eve();

module eve() {

	// PCB
	color([0,.75,0]) {
		difference() {
			cube([
				85,
				56,
				1.6
			]);

			// Ethernet
			translate([
				64.4,
				-1,
				-1
			]) {
				cube([
					100,
					19.12,
					3
				]);
			}

			// USB
			translate([
				74.7,
				-1,
				-1
			]) {
				cube([
					100,
					1+23.35+14.6+1,
					3
				]);
			}

			// Video
			translate([
				39.6,
				45,
				-1
			]) {
				cube([
					12,
					12,
					3
				]);
			}
		}
	}

	// Header
	color([0,0,0]) {
		translate([
			1,
			49.4,
			-10
		]) {
			cube([
				33,
				5.1,
				10
			]);
		}
	}
	
}
