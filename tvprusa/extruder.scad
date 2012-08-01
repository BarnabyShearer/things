echo("\r\rWIP: This is untested\r\r");

/*
 * extruder
 *
 * Lightweight extruder with integrated bowden mount.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn=60;

m8 = 8 /2;
m3 = 3.2 /2;
bearing608 = [
	4,				//ID
	11, 			//OD
	7				//width
];
nema17 = [
		1.7*25.4,	//size
		1.2*25.4,	//pitch
		m3,			//bolt
		5/2,		//shaft
		23			//shaft length
];

extruder();

module extruder(
	bearing = bearing608,
	bolt = m3,
	filament = 3/2,
	clamp = 12.5,
	bowden = 6.5/2,
	gear_pitch = 40,
	motor = nema17,
	rod = m8,
	t = 1.5
) {
	cable_pitch = bowden*2+bolt*4;
	bearing_y = bolt*2+t*2+clamp+t+bearing[1];
	size = [
		bearing[1]*2 + t,
		bearing_y + bearing[1] + t,
		bearing[2]*3 + t*2
	];
	filament_x = size[0]/2 - filament - bearing[0] + t/2;
	motor_x = size[0]/2 + sqrt(pow(gear_pitch,2) - pow(bearing_y-motor[0]/2,2));

	difference() {

		//gears
		translate([
			size[0]/2,
			bearing_y,
			-15
		]) {
			%cylinder(
				r = 33,
				h = 10
			);
		}
		translate([
			motor_x,
			motor[0]/2,
			-15
		]) {
			%cylinder(
				r = 9,
				h = 10
			);
		}
	
		//motor
		translate([
			motor_x,
			motor[0]/2,
			t*2
		]) {
			rotate([
				180,
				0,
				0,
			]) {
				%motor(motor);
			}
		}

		//block
		union() {

			//rod rail
			translate([
				-bolt*3-t*4,
				-rod,
				0
			]) {
				cube([
					motor_x+motor[1],
					rod,
					rod*2+t
				]);
			}
			translate([
				-bolt*3-t*4,
				-rod,
				0
			]) {
				cube([
					bolt*2+t*4,
					rod,
					rod*2+t*2+bolt*3
				]);
			}
			translate([
				motor_x/2-bolt*2,
				-rod,
				0
			]) {
				cube([
					bolt*2+t*4,
					rod,
					rod*2+t*2+bolt*3
				]);
			}

			//spring holder
			translate([
				size[0]/2,
				bearing_y-t,
				0
			]) {
				cube([
					size[0]/2+t,
					size[0]/2+bolt*4+t,
					size[2]
				]);
			}

			//motor holder
			translate([
				size[0]/2,
				0,
				0
			]) {
				cube([
					motor_x-size[0]/2-motor[1]/2,
					motor[0]/2 - motor[1]/2 + motor[1] + bolt + t,
					t*2
				]);
			}
			translate([
				motor_x+motor[1]-bolt*5-t*8,
				0,
				0
			]) {
				cube([
					bolt*2 + t*4,
					(motor[0]-motor[1])/2,
					t*2
				]);
			}
			//motor bolts
			for(y=[0:1]) {
				translate([
					motor_x-motor[1]/2,
					motor[0]/2 - motor[1]/2 + motor[1]*y,
					0
				]) {
					cylinder(
						r = motor[2] + t*2,
						h = t*2
					);
				}
			}
			translate([
				motor_x-motor[1]/2 +motor[1],
				motor[0]/2 - motor[1]/2,
				0
			]) {
				cylinder(
					r = motor[2] + t*2,
					h = t*2
				);
			}

			//bearing holder
			translate([
				size[0]/2,
				bearing_y,
				0
			]) {
				cylinder(
					r = size[0]/2,
					h = size[2]
				);
			}
			translate([
				size[0]/2+t,
				bearing_y-t,
				0
			]) {
				cylinder(
					r = size[0]/2,
					h = size[2]
				);
			}

			//bearing guide strenghtener
			translate([
				filament_x,
				8+bolt*4,
				0
			]) {
				cube([
					cable_pitch/2+bolt+t,
					bolt*2+t*2,
					size[2]/2
				]);
			}
			

			//filament guide
			translate([
				filament_x-filament-t*2,
				0,
				0
			]) {
				cube([
					filament*2+t*4,
					bearing_y,
					size[2]/2
				]);
			}

			//cable bolt attachemnt
			translate([
				filament_x - cable_pitch/2,
				bolt+t,
				0
			]) {
				cube([
					cable_pitch,
					clamp,
					size[2]/2
				]);
			}

			//cable bolts
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						filament_x  - cable_pitch/2 + cable_pitch*x,
						bolt+t+clamp*y,
						0
					]) {
						cylinder(
							r = bolt+t,
							h = size[2]/2
						);
					}
				}
			}

			//pivot
			translate([
				filament_x-filament-bearing[1],
				bolt+t+clamp/2,
				0
			]) {
				cylinder(
					r = bolt+t,
					h = size[2]/2
				);
			}
			translate([
				filament_x-filament-bearing[1],
				bolt+t+clamp/2 - (bolt + t),
				0
			]) {
				cube([
					filament_x-filament-t*2 - (filament_x-filament-bearing[1]) +1,
					bolt*2 + t*2,
					size[2]/2
				]);
			}
		}


		//rod
		translate([
			-50,
			-rod-t,
			size[2]/2-bowden-rod
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r = rod,
					h = 150
				);
				%cylinder(
					r = rod,
					h = 150
				);
			}
		}

		//rod bolts
		translate([
			-bolt*2-t*2,
			-rod-1,
			rod*2+t+bolt
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = bolt,
					h = rod  + 2
				);				
			}
		}
		translate([
			motor_x/2-bolt+t*2,
			-rod-1,
			rod*2+t+bolt
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = bolt,
					h = rod  + 2
				);				
			}
		}

		//filament
		translate([
			filament_x,
			-1,
			size[2]/2
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				%cylinder(
					r = filament,
					h = size[1] + 2
				);
				cylinder(
					r = filament + t/4,
					h = size[1] + 2
				);
				cylinder(
					r = bowden,
					h = clamp+bolt*2+t*2+1
				);
			}
		}

		// hobbed bolt
		translate([
			size[0]/2,
			bearing_y,
			-1
		]) {
			%cylinder(
				r=bearing[0],
				h=size[2]+2
			);

			cylinder(
				r=bearing[1]-t/10,
				h=size[2]+2
			);
		}

		//bearings
		translate([
			size[0]/2,
			bearing_y,
			-1
		]) {
			translate([
				0,
				0,
				1
			]) {
				%cylinder(
					r = bearing[1],
					h = bearing[2]
				);
			}
			cylinder(
				r=bearing[1],
				h=bearing[2]+1
			);
		}
		translate([
			size[0]/2,
			bearing_y,
			size[2]-bearing[2]
		]) {
			%cylinder(
				r = bearing[1],
				h = bearing[2]
			);
			cylinder(
				r=bearing[1],
				h=bearing[2]+1
			);
		}

		//idler
		translate([
			filament_x - filament-bearing[1],
			bearing_y,
			-1 //size[2]/2 - bearing[2]/2 - t - .1
		]) {
			cylinder(
				r=bearing[1] + t,
				h=size[2] + 2 //bearing[2] + t*2 + .2
			);
		}

		//cable bolts
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					filament_x  - cable_pitch/2 + cable_pitch*x,
					bolt+t + clamp*y,
					-1
				]) {
					cylinder(
						r = bolt,
						h =size[2]/2+2
					);
				}
			}
		}

		//pivot
		translate([
			filament_x-filament-bearing[1],
			bolt+t+clamp/2,
			-1
		]) {
			cylinder(
				r = bolt,
				h = size[2]/2 + 2
			);
		}

		//spring guide
		translate([
			filament_x,
			size[1]+bolt*2,
			size[2] - bearing[2]/2 - t/8
		]){
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r = bolt,
					h = size[0]
				);
			}
		}

		//motor bolts
		for(y=[0:1]) {
			translate([
				motor_x-motor[1]/2,
				motor[0]/2 - motor[1]/2 + motor[1]*y,
				-1
			]) {
				cylinder(
					r = motor[2],
					h = t*2 + 2
				);
			}
		}
		translate([
			motor_x-motor[1]/2 + motor[1],
			motor[0]/2 - motor[1]/2,
			-1
		]) {
			cylinder(
				r = motor[2],
				h = t*2 + 2
			);
		}

	}

	translate([
		0,
		-10,
		size[2]
	]) {
		rotate([
			180,
			0,
			90
		]) {
			extruder_arm(
				bearing = bearing,
				bolt = bolt,
				filament = filament,
				clamp = clamp,
				filament_x = filament_x,
				bearing_y = bearing_y,
				size = size,
				t = t
			);
		}
	}

	translate([
		-5,
		-25,
		0
	]) {
		bowden_clamp(
			bolt = bolt,
			clamp = clamp,
			bowden = bowden,
			cable_pitch = cable_pitch,
			t = t
		);
	}

	translate([
		-15,
		-37,
		0
	]) {
		rotate([
			-90,
			0,
			0
		]) {
			rod_clamp(
				bolt = bolt,
				rod = rod,
				bowden = bowden,
				size = size,
				motor_x = motor_x,
				t = t
			);
		}
	}
}

module rod_clamp() {
	difference() {
		union() {

			//rod rail
			translate([
				-bolt*3-t*4,
				-rod,
				0
			]) {
				cube([
					motor_x/2-bolt*2+bolt*3+t*4,
					rod,
					rod*2+t
				]);
			}
			translate([
				-bolt*3-t*4,
				-rod,
				0
			]) {
				cube([
					bolt*2+t*4,
					rod,
					rod*2+t*2+bolt*3
				]);
			}
			translate([
				motor_x/2-bolt*2,
				-rod,
				0
			]) {
				cube([
					bolt*2+t*4,
					rod,
					rod*2+t*2+bolt*3
				]);
			}
		}

		//rod
		translate([
			-50,
			-rod-t,
			size[2]/2-bowden-rod
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r = rod,
					h = 150
				);
			}
		}

		//rod bolts
		translate([
			-bolt*2-t*2,
			-rod-1,
			rod*2+t+bolt
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = bolt,
					h = rod  + 2
				);				
			}
		}
		translate([
			motor_x/2-bolt+t*2,
			-rod-1,
			rod*2+t+bolt
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = bolt,
					h = rod  + 2
				);				
			}
		}

	}
}

module bowden_clamp() {
	difference() {
		union() {
			//block
			translate([
				-cable_pitch/2,
				0,
				0
			]) {
				cube([
					cable_pitch,
					clamp+bolt*2+t*2,
					bowden+t*2
				]);
			}

			//cable bolts
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						- cable_pitch/2 + cable_pitch*x,
						bolt+t+clamp*y,
						0
					]) {
						cylinder(
							r = bolt+t,
							h = bowden+t*2
						);
					}
				}
			}
		}
		//cable bolts
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					- cable_pitch/2 + cable_pitch*x,
					bolt+t+clamp*y,
					-1
				]) {
					cylinder(
						r = bolt,
						h = bowden+t*2+2
					);
				}
			}
		}
		//bowden
		translate([
			0,
			-1,
			t*2+bowden
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = bowden,
					h = clamp+bolt*2+t*2+2
				);
			}
		}

	}	
}

module extruder_arm() {

	difference() {
		union() {

			//bearing
			%translate([
				filament_x-filament-bearing[1],
				bearing_y,
				bearing[2] + t
			]) {
				cylinder(
					r = bearing[1],
					h = bearing[2]
				);
			}

			//bearing holder
			translate([
				filament_x-filament-bearing[1],
				bearing_y,
				bearing[2] + t
			]) {
				cylinder(
					r = bearing[0],
					h = size[2] - (bearing[2] + t)
				);
			}

			//bearing sholder
			translate([
				filament_x-filament-bearing[1],
				bearing_y,
				size[2] - bearing[2] - t
			]) {
				cylinder(
					r = bearing[0] + t/10,
					h = bearing[2] + t
				);
			}

			//arm
			translate([
				filament_x - filament - bearing[1] - bolt - t,
				bolt*3 + 4,
				size[2] - bearing[2]
			]) {
				cube([
					bolt*2 + t*2,
					size[1],
					bearing[2]
				]);
			}

			//arm end
			translate([
				filament_x-filament-bearing[1],
				bolt*3 + 4 + size[1],
				size[2] - bearing[2]
			]) {
				cylinder(
					r = bolt+t,
					h = bearing[2]
				);
			}

			//pivot
			translate([
				filament_x-filament-bearing[1],
				bolt+t+clamp/2,
				size[2]/2
			]) {
				cylinder(
					r = bolt+t,
					h = size[2]/2
				);
			}
		}

		//pivot
		translate([
			filament_x-filament-bearing[1],
			bolt+t+clamp/2,
			size[2]/2-1
		]) {
			cylinder(
				r = bolt,
				h = size[2]/2 + 2
			);
		}

		//slot
		translate([
			filament_x - filament - bearing[1] - bolt - t -1,
			size[1],
			size[2] - bearing[2]/2 - bolt - t/8
		]){
			cube([
				bolt*2 + t*2 + 2,
				bolt*4,
				bolt*2 + t/4
			]);
		}

	}
}

module motor(
	size = nema17,
) {
	difference() {
		translate([
			-size[0]/2,
			-size[0]/2,
			-size[0]
		]) {
			 cube([
				size[0],
				size[0],
				size[0]
			]);
		}
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					-size[1]/2 + size[1]*x,
					-size[1]/2 + size[1]*y,
					-10
				]) {
					cylinder(
						r=size[2],
						h=11
					);
				}
			}
		}

	}
	cylinder(
		r=size[3],
		h=size[4]
	);
}

