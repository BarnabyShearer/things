/*
 * extruder
 *
 * Lightweight extruder with integrated bowden mount.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn=60;

nylock = [11.3/2, 6 ];
m8 = 8 /2;
m3 = 3.6 /2;
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
	nut = nylock,
	clamp = 12.5,
	bowden = 6.5/2,
	gear_pitch = 40,
	motor = nema17,
	rod = m8,
	t = 1.5
) {
	cable_pitch = bowden*2+bolt*4;
	bearing_y = bolt*3+t*2+clamp+t+bearing[1];
	size = [
		bearing[1]*2 + t*2,
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
				0,
				-rod*2,
				0
			]) {
				cube([
					motor_x+motor[0]/2+1,
					rod*2,
					t*2
				]);
			}

			//rod bolts
			for(x=[0:1]) {
				translate([
					motor_x+motor[0]/2-(motor[0]+bolt*4)*x,
					-rod*2-bolt*2,
					0
				]) {
					cube([
						bolt*4,
						rod*2+bolt*4,
						rod+t
					]);
				}
				for(y=[0:1]) {
					translate([
						motor_x+motor[0]/2-(motor[0]+bolt*4)*x + bolt*2,
						-rod*2-bolt*2 + (rod*2+bolt*4)*y,
						0
					]) {
						cylinder(
							r = bolt*2,
							h=rod + t
						);
					}
				}
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
				size[0]/2-1,
				0,
				0
			]) {
				cube([
					motor_x-size[0]/2-motor[1]/2+1,
					motor[0]/2 - motor[1]/2 + motor[1] + bolt + t,
					t*2
				]);
			}

			translate([
				motor_x-motor[1]/2 +motor[1]-  motor[2] - t*2,
				0,
				0
			]) {
				cube([
					bolt*2 + t*4+5,
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
				filament_x - cable_pitch/2-1,
				0,
				0
			]) {
				cube([
					cable_pitch+2,
					clamp+bolt+t,
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
				filament_x-filament-bearing[1]-4,
				bolt+t+clamp/2,
				0
			]) {
				cylinder(
					r = bolt+t,
					h = size[2]/2
				);
			}
			translate([
				filament_x-filament-bearing[1]-4,
				bolt+t+clamp/2 - (bolt + t),
				0
			]) {
				cube([
					filament_x-filament-t*2 - (filament_x-filament-bearing[1]) +5,
					bolt*2 + t*2,
					size[2]/2
				]);
			}
		}


		//rod
		translate([
			-50,
			-rod,
			rod + t*2
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
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					bolt*2 + motor_x+motor[0]/2-(motor[0]+bolt*4)*x,
					bolt*2 - (bolt*4+rod*2)*y,
					-1
				]) {
					cylinder(
						r = bolt,
						h = rod+t + 2
					);				
				}
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
		
		//filament retaining nut
		translate([
			filament_x,
			clamp/2,
			size[2]/2
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = nut[0],
					h = nut[1],
					$fn = 6
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
				r=bearing[1]-t,
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
			filament_x-filament-bearing[1]-4,
			bolt+t+clamp/2,
			-1
		]) {
			cylinder(
				r = bolt,
				h = size[2]/2 + 2
			);
		}

		//spring guide
		for(x=[0:1]) {
			translate([
				filament_x,
				size[1]+bolt*2,
				size[2]/2 -( size[2]/2 - bearing[2]/2 - t/8 ) + ( size[2]/2 - bearing[2]/2 - t/8) *2*x
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
		-16,
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
		0,
		-26,
		size[2]
	]) {
		rotate([
			180,
			0,
			90
		]) {
			extruder_arm_support(
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
		-30,
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
	for(x=[0:1]) {
		translate([
			-20+10*x,
			30,
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
			cube([
				bolt*4,
				rod*2+bolt*4,
				rod + t					
			]);
			for(y=[0:1]) {
				translate([
					bolt*2,
					 (rod*2+bolt*4)*y,
					0
				]) {
					cylinder(
							r = bolt*2,
						h=rod + t
					);
				}
			}
		}

		//rod
		translate([
			-1,
			-bolt*2 + rod + bolt*4,
			rod + t
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r = rod,
					h = bolt*4 + 2
				);
			}
		}

		//rod bolts
		for(x=[0:1]) {
			translate([
				bolt*2,
				(bolt*4 + rod*2)*x,
				-1
			]) {
				cylinder(
					r = bolt,
					h = rod + t + 2
				);				
			}
		}
	}
}

module bowden_clamp(nut = nylock) {
	height = nut[1]+t;

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
					height
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
							h = height
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
						h = height+2
					);
				}
			}
		}
		//bowden
		translate([
			0,
			-1,
			height
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
		//filament retaining nut
		translate([
			0,
			clamp/2,
			height
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = nut[0],
					h = nut[1],
					$fn = 6
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
				bearing_y+1,
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
				bearing_y+1,
				size[2]/2
			]) {
				cylinder(
					r = bearing[0],
					h = size[2]/2 - (bearing[2] + t)
				);
			}

			//bearing sholder
			translate([
				filament_x-filament-bearing[1],
				bearing_y+1,
				size[2] - bearing[2] - t
			]) {
				cylinder(
					r = bearing[0] + t/5,
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
				size[2]/2
			]) {
				cylinder(
					r = bolt+t,
					h = size[2]/2
				);
			}

			//pivot
			translate([
				filament_x - filament-bearing[1] ,
				bolt*3 + 4,
				size[2]/2
			]) {
				cylinder(
					r = bolt+t,
					h = size[2]/2
				);
			}
		}

		//bearing holder bolt
		translate([
			filament_x-filament-bearing[1],
			bearing_y+1,
			bearing[2] + t-1
		]) {
			cylinder(
				r=bolt,
				h=100
			);
		}

		//armend holder bolt
		translate([
			filament_x-filament-bearing[1],
			bolt*3 + 4 + size[1],,
			bearing[2] + t-1
		]) {
			cylinder(
				r=bolt,
				h=100
			);
		}

		//pivot
		translate([
			filament_x-filament-bearing[1],
			bolt*3 + 4,
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
			size[2] - bearing[2]/2 - bolt/2 - t/84
		]){
			cube([
				bolt*2 + t*2 + 2,
				bolt*3,
				bolt + t/4
			]);
		}

	}
}

module extruder_arm_support() {

	difference() {
		union() {

			//bearing
			%translate([
				filament_x-filament-bearing[1],
				bearing_y+1,
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
				bearing_y+1,
				size[2]/2
			]) {
				cylinder(
					r = bearing[0],
					h = size[2]/2 - (bearing[2] + t)
				);
			}

			//bearing sholder
			translate([
				filament_x-filament-bearing[1],
				bearing_y+1,
				size[2] - bearing[2] - t
			]) {
				cylinder(
					r = bearing[0] + t/5,
					h = bearing[2] + t
				);
			}

			//arm
			translate([
				filament_x - filament - bearing[1] - bolt - t,
				bearing_y+1,
				size[2] - bearing[2]
			]) {
				cube([
					bolt*2 + t*2,
					size[1]-(bearing_y+1)+bolt*3 + 4,
					bearing[2]
				]);
			}

			//arm end
			translate([
				filament_x-filament-bearing[1],
				bolt*3 + 4 + size[1],
				size[2]/2
			]) {
				cylinder(
					r = bolt+t,
					h = size[2]/2
				);
			}
		}

		//bearing holder bolt
		translate([
			filament_x-filament-bearing[1],
			bearing_y+1,
			bearing[2] + t-1
		]) {
			cylinder(
				r=bolt,
				h=100
			);
		}

		//armend holder bolt
		translate([
			filament_x-filament-bearing[1],
			bolt*3 + 4 + size[1],,
			bearing[2] + t-1
		]) {
			cylinder(
				r=bolt,
				h=100
			);
		}


		//slot
		translate([
			filament_x - filament - bearing[1] - bolt - t -1,
			size[1],
			size[2] - bearing[2]/2 - bolt/2 - t/84
		]){
			cube([
				bolt*2 + t*2 + 2,
				bolt*3,
				bolt + t/4
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

