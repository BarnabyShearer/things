/*
 * Raspberry Pi Model B Revision 2.0
 *
 * Copyright 2012 b@Zi.iS
 *
 * License CC BY 3.0
 */

pi();

module pi(
	port_allowance=0,
	sdcard = 32, // Lengths if present
	power = 25,
	ethernet = 22,
	usb = [40, 40],
) {

	// PCB
	color([0,.75,0]) {
		difference() {
			cube([
				85,
				56,
				1.6
			]);
			// Mounting holes
			translate([
				25.5,
				18,
				-1
			]) {
				cylinder(
					r = 2.9/2,
					h = 4
				);
			}
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
		}
	}

	// Power
	color([.85,.85,.85]) {
		translate([
			-.7 - port_allowance,
			3.4 - port_allowance,
			1.3 - port_allowance
		]) {
			cube([
				5.4 + port_allowance*2,
				7.9 + port_allowance*2,
				3 + port_allowance*2
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
	//Pins
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

	// HDMI
	color([.85,.85,.85]) {
		translate([
			37.4 - port_allowance,
			-1.8 - port_allowance,
			1.6 - port_allowance
		]) {
			cube([
				15.2 + port_allowance*2,
				11.5 + port_allowance*2,
				6.2 + port_allowance*2
			]);
		}
	}

	// Ethernet
	color([.85,.85,.85]) {
		translate([
			65.4 - port_allowance,
			2 - port_allowance,
			2 - port_allowance
		]) {
			cube([
				20.6 + port_allowance*2,
				15.12 + port_allowance*2,
				13 + port_allowance*2
			]);
		}
	}

	// USB
	color([.85,.85,.85]) {
		translate([
			75.7 - port_allowance,
			23.35- port_allowance,
			1.6 - port_allowance
		]) {
			cube([
				17 + port_allowance*2,
				14.6 + port_allowance*2,
				15.65 + port_allowance*2
			]);
		}
	}

	// Audio
	color([0,0,0]) {
		translate([
			59,
			44.5,
			1.6
		]) {
			cube([
				12,
				11.5,
				10
			]);
		}
	}
	color([0,0,0]) {
		translate([
			65,
			56,
			8.1
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r=3.5 + port_allowance,
					h = 3.5 + port_allowance
				);
			}
		}
	}

	// Video
	color([1,1,0]) {
		translate([
			40.6,
			46,
			1.6
		]) {
			cube([
				10,
				10,
				13.15
			]);
		}
	}
	color([.95,.95,.95]) {
		translate([
			45.6,
			56,
			9.75
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r=4.15 + port_allowance,
					h = 9.5 + port_allowance
				);
			}
		}
	}

	// SD-Card Slot
	color([0,0,0]) {
		translate([
			0,
			15.2,
			-3.1
		]) {
			cube([
				19,
				28,
				3.1
			]);
		}
	}

	// SD-Card
	color([0,0,1]) {
		translate([
			14.3 - sdcard,
			17.2,
			-2.8
		]) {
			cube([
				sdcard,
				24,
				2.4
			]);
		}
	}

	// Power
	color([0,0,0]) {
		translate([
			5 - power,
			1.85,
			-.2
		]) {
			cube([
				power - 6,
				11,
				6
			]);
		}
	}

	// Ethernet
	color([1,1,0]) {
		translate([
			75,
			3.5,
			4
		]) {
			cube([
				ethernet,
				12,
				8
			]);
		}
	}

	for (i=[0:1]) {
		if(usb[i]>0) {
			color([.95,.95,.95]) {
				translate([
					84.1,
					24.55,
					3.2 + 8.3*i
				]) {
					cube([
						13,
						12.2,
						4.6
					]);
				}
			}
		}
		color([0,0,0]) {
			translate([
				96.1,
				22.65,
				1.5 + 8.3*i
			]) {
				cube([
					usb[i] - 12,
					16,
					8
				]);
			}
		}
	}
}
