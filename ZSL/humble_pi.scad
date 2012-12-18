/*
 * Humble Pi
 *
 * Copyright 2012 b@Zi.iS
 *
 * License CC BY 3.0
 */

humble_pi();

module humble_pi() {

	// PCB
	color([0,.75,0]) {
		difference() {
			cube([
				85,
				56,
				1.6
			]);
			// Mounting hole
			translate([
				85 - 5,
				56 - 12.5,
				-1
			]) {
				cylinder(
					r = 2.9/2,
					h = 4
				);
			}

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


	// Header
	color([0,0,0]) {
		translate([
			1,
			49.4,
			1.6
		]) {
			cube([
				33,
				5.1,
				2.5
			]);
		}
	}
	// Pins
	color([1,1,0]) {
		for (x=[0:12]) {
			for (y=[0:1]) {
				translate([
					1.95 + x*2.542,
					50.4 + y*2.542,
					1.6
				]) {
					cube([
						.6,
						.6,
						8.5
					]);
				}
			}
		}
	}

	// Power
	color([0,0,0]) {
		translate([
			72,
			46,
			1.6
		]) {
			cube([
				13,
				8,
				8
			]);
		}
	}
}
