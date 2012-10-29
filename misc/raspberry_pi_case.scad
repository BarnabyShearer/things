/*
 * Raspberry Pi Case
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

base();

module base(
	wall = 1,
	height = 22,
	model = "B"
) {
	length = 87;
	width = 57;

	difference() {

		// Case
		cube([
			length + wall*2,
			width + wall*2,
			height + wall,
		]);

		// Hollow
		translate([
			wall,
			wall,
			wall
		]) {
			cube([
				length,
				width,
		 		height+1,
			]);
		}

		// Audio
		translate([
			wall+17.4,
			-wall,
			wall+3.4+4.4
		]) {
			cube([
				7.1,
				3*wall,
				50,
			]);
		}

		// Composite	
		translate([
			wall+17.4+7.1+11,
			-wall,
			wall+3.4+5.5
		]) {
			cube([
				8.4,
				3*wall,
				50,
			]);
		}
	
		// USB
		translate([
			-wall,
			wall+18.4,
			wall+3.4+1.4
		]) {
			cube([
				3*wall,
				13.3,
				50,
			]);
		}

		// Ethernet
		translate([
			-wall,
			wall+18.4+13.3+6.2,
			wall+3.4
		]) {
			cube([
				3*wall,
				16,
				50,
			]);
		}
	
		// HDMI
		translate([
			wall+32,
			width,
			wall+3.4+4.4
		]) {
			cube([
				18,
				3*wall,
				50,
			]);
		}
	
		// Power
		translate([
			length,
			wall+44.1,
			wall+3.4+1.4
		]) {
			cube([
				3*wall,
				8.2,
				50,
			]);
		}

		// SD
		translate([
			length,
			wall+14,
			wall
		]) {
			cube([
				3*wall,
				24.2,
				50,
			]);
		}
	}

	//Supports
	cube([
		wall+10,
		wall+3,
		wall+3.4,
	]);
	translate([
			0,
			width+wall-20,
			0
		]) {
			cube([
				wall+7,
				wall+20,
				wall+3.4,
		]);
	}
}
