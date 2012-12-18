/*
 * Hack HS
 *
 * Copyright 2012 b@Zi.iS
 *
 * License CC BY 3.0
 */
$fn=60;

hack_hd();

module hack_hd() {

	// PCB
	color([0,.75,0]) {
		difference() {
			cube([
				67,
				40,
				1.6
			]);
			
			translate([
				0,
				30,
				-1
			]) {
				rotate([
					0,
					0,
					45
				]) {
					cube([
						67,
						40,
						3
					]);
				}
			}
			
			translate([
				10,
				0,
				-1
			]) {
				rotate([
					0,
					0,
					180-45
				]) {
					cube([
						67,
						40,
						3
					]);
				}
			}

		}
	}

	//Camera
	color([0,0,0]) {
		translate([
			.5,
			10,
			1.6
		]) {
			cube([
				20,
				20,
				5
			]);
		}
	}

	color([0,0,0]) {
		translate([
			.5+10,
			10+10,
			1.6+5
		]) {
			cylinder(
				r=7,
				h=11
			);
		}
	}

	color([0,0,0]) {
		translate([
			.5+10,
			10+10,
			1.6+5+11
		]) {
			cylinder(
				r=17.5/2,
				h=5.25
			);
		}
	}

	//Lense
	color([1,1,1,.5]) {
		intersection() {
			translate([
				.5+10,
				10+10,
				1.6+5+11+5.25
			]) {
				cylinder(
					r=17.5/2,
					h=5.25
				);
			}
			translate([
				.5+10,
				10+10,
				-6
			]) {
				sphere(
					r=30
				);
			}
		}
	}

	//Terminals
	color([0,1,0]) {
		translate([
			60,
			8,
			1.6
		]) {
			cube([
				7.5,
				32,
				9
			]);
		}
	}
}
