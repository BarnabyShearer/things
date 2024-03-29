echo("\r\rWIP: Not yet finished\r\r");

/*
 * x end motor
 *
 * Mount the x motor inline with z-rods and move belt between x-rods.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn = 60;

m8 = 8 / 2;
m3 = 2.8 /2;
m3_nut = 6.1 /2;

nema17_pitch=1.2*25.4; 
nema17=1.7*25.4;
nema17_shaft = 5/2;
nema17_shaft_length = 23;

prusa_belt_height = 11.5;
prusa_belt_offset = 17.5;

t5_thickness = 2.5;
t5_width = 5;

t5_16=14;



xend_top();
xend_base();


module xend_top(
	xrodgap = 50,
	zrodgap=29.5,
	rod = m8,
	bolt = m3,
	thickness = 1.4,
	belt_width=t5_width,
	belt_thickness=t5_thickness,
	belt_height = prusa_belt_height,
	belt_offset = prusa_belt_offset,
	pully = t5_16,
	pully_length=20,
	motor=nema17,
	motor_pitch=nema17_pitch
) {

	height = rod*2;
	zspace = (zrodgap-rod*1.2-thickness/2);

	//Placeholders
	%for(r=[0:1]) {
		//Z-Rods
		translate([
			zrodgap*r,
			0,
			-50
		]) {
			cylinder(
				r=rod,
				h=100
			);
		}
		//X-Rods
		translate([
			0,
			-xrodgap/2+xrodgap*r,
			0
		]) {
			rotate([
				0,
				90,
				0,
			]) {
				cylinder(
					r = rod,
					h =100
				);
			}
		}

	}

	//Motor
	%translate([
		-motor/2-rod*2,
		0,
		-height+thickness,
	]) {
		rotate([
			180,
			0,
			0,
		]) {
			motor(
				pully=pully,
				pully_length = pully_length,
				size = motor,
				pitch = motor_pitch
			);
		}
	}

	//Base
	difference() {
		union() {
			for(y=[0:1]) {
				//X-Rod Support
				for(x=[0:1]) {
					translate([
						-thickness/2+bolt*2+zspace*y,
						-xrodgap/2+xrodgap*x,
						0,
					]) {
						rodsupport(
							rod = rod,
							bolt = bolt,
							height = height
						);
					}
				}
				//Bracing
				translate([
					-thickness/2+zspace*y,
					-xrodgap/2+rod,
					-height,
				]) {
					cube([
						thickness,
						xrodgap-rod*2,
						rod*2,
					]);
				}
				//Cross Bracing
				translate([
					0,
					-xrodgap/2-rod-bolt*4+xrodgap-(xrodgap-rod*2-bolt*8+thickness)*y,
					-height,
				]) {
					cube([
						zspace,
						thickness,
						rod*2,
					]);
				}
			}

			//Plate
			translate([
				-thickness/2,
				-xrodgap/2-rod-bolt*4,
				-height,
			]) {
				cube([
					zspace + bolt*4,
					xrodgap+bolt*8+rod*2,
					thickness,
				]);
			}



			//Moror Support
			translate([
				-rod*2-motor,
				-motor/2-thickness,
				-height,
			]) {
				cube([
					motor+rod*2-thickness/2,
					motor+thickness*2,
					thickness,
				]);
			}
			translate([
				-rod*2-motor,
				-motor/2-thickness,
				-height,
			]) {
				cube([
					motor+rod*2-thickness/2,
					thickness,
					rod,
				]);
			}
			translate([
				-rod*2-motor,
				-motor/2+motor,
				-height,
			]) {
				cube([
					motor+rod*2-thickness/2,
					thickness,
					rod,
				]);
			}
		}

		//X-Rod Support holes
		for(y=[0:1]) {
			for(x=[0:1]) {
				translate([
					-thickness/2+bolt*2+zspace*y,
					-xrodgap/2+xrodgap*x,
					0,
				]) {
					rodsupport_holes(
						rod = rod,
						bolt = bolt,
						height = height
					);
				}
			}
		}

		//Z-Screw gap
		translate([
			zrodgap,
			0,
			-height-1
		]) {
			cylinder(
				r=rod*1.2,
				h=thickness+2
			);
		}
		translate([
			zrodgap,
			-rod*1.2,
			-height-1
		]) {
			cube([
				100,
				rod*1.2*2,
				thickness+2
			]);
		}

		//Z-Rod gap
		translate([
			0,
			0,
			-height-1
		]) {
			cylinder(
				r=rod*2-thickness,
				h=thickness+rod*3+2
			);
		}

		//Pully clearance
		translate([
			-rod*2-motor/2,
			0,
			-height-1,
		]) {
			cylinder(
				r=pully*1.2,
				h=thickness+2
			);
		}

		translate([
			-rod*2-motor-1,
			-rod*1.4,
			-height-1,
		]) {
			cube([
				rod*2+motor+1,
				rod*2*1.4,
				thickness+2
			]);
		}

		//Motor bolts
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					-rod*2-motor/2-motor_pitch/2+motor_pitch*y,
					-motor_pitch/2+motor_pitch*x,
					-height-1,
				]) {
					cylinder(
						r=bolt,
						h=thickness+2
					);
				}
			}
		}

	}

	//Bushing
	translate([
		0,
		0,
		-height
	]) {
		rotate([
			0,
			0,
			-90
		]) {
			bushing(
				rod=rod,
				length = height,
				width = rod*4,
				height=rod*2,
				thickness = 1
			);
		}
	}

}

module xend_base(
	xrodgap = 50,
	zrodgap=29.5,
	rod = m8,
	bolt = m3,
	thickness = 1.4,
	belt_width=t5_width,
	belt_thickness=t5_thickness,
	belt_height = prusa_belt_height,
	belt_offset = prusa_belt_offset,
	pully = t5_16,
	pully_length=20,
	motor=nema17,
	motor_pitch=nema17_pitch
) {

	height = rod*2;
	zspace = (zrodgap-rod*1.2-thickness/2);


	//Base
	difference() {
		union() {
			for(y=[0:1]) {
				//X-Rod Support
				for(x=[0:1]) {
					translate([
						-thickness/2+bolt*2+zspace*y,
						-xrodgap/2+xrodgap*x,
						0,
					]) {
						rodsupport(
							rod = rod,
							bolt = bolt,
							height = height
						);
					}
				}
				//Bracing
				translate([
					-thickness/2+zspace*y,
					-xrodgap/2+rod,
					-height,
				]) {
					cube([
						thickness,
						xrodgap-rod*2,
						rod*2,
					]);
				}
				//Cross Bracing
				translate([
					0,
					-xrodgap/2-rod-bolt*4+xrodgap-(xrodgap-rod*2-bolt*8+thickness)*y,
					-height,
				]) {
					cube([
						zspace,
						thickness,
						rod*2,
					]);
				}
			}

			//Plate
			translate([
				-thickness/2,
				-xrodgap/2-rod-bolt*4,
				-height,
			]) {
				cube([
					zspace + bolt*4,
					xrodgap+bolt*8+rod*2,
					thickness,
				]);
			}


		}

		//X-Rod Support holes
		for(y=[0:1]) {
			for(x=[0:1]) {
				translate([
					-thickness/2+bolt*2+zspace*y,
					-xrodgap/2+xrodgap*x,
					0,
				]) {
					rodsupport_holes(
						rod = rod,
						bolt = bolt,
						height = height
					);
				}
			}
		}

		//Z-Screw gap
		translate([
			zrodgap,
			0,
			-height-1
		]) {
			cylinder(
				r=rod*1.2,
				h=thickness+2
			);
		}
		translate([
			zrodgap,
			-rod*1.2,
			-height-1
		]) {
			cube([
				100,
				rod*1.2*2,
				thickness+2
			]);
		}

		//Z-Rod gap
		translate([
			0,
			0,
			-height-1
		]) {
			cylinder(
				r=rod*2-thickness,
				h=thickness+rod*3+2
			);
		}

	}

	//Bushing
	translate([
		0,
		0,
		-height
	]) {
		rotate([
			0,
			0,
			-90
		]) {
			bushing(
				rod=rod,
				length = height,
				width = rod*4,
				height=rod*2,
				thickness = 1
			);
		}
	}

}


module motor(
	size=nema17,
	bolt=m3,
	pitch=nema17_pitch,
	shaft=nema17_shaft,
	shaft_length=nema17_shaft_length,
	pully = 0,
	pully_length = 0
) {
	difference() {
		translate([
			-size/2,
			-size/2,
			-size
		]) {
			 cube([
				size,
				size,
				size
			]);
		}
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					-pitch/2 + pitch*x,
					-pitch/2 + pitch*y,
					-10
				]) {
					cylinder(
						r=bolt,
						h=11
					);
				}
			}
		}

	}
	cylinder(
		r=shaft,
		h=shaft_length
	);
	translate([
		0,
		0,
		1,
	]) {
		cylinder(
			r=pully,
			h=pully_length
		);
	}
}

module rodsupport(
	rod=m8,
	bolt = m3,
	height=10
) {
	
	difference() {
		translate([
			-bolt*2,
			-rod-bolt*4,
			-height
		]) {
			cube([
				bolt*4,
				rod*2+bolt*8,
				height,
			]);
		}


		translate([
			-bolt*2-1,
			0,
			0
		]) {
			rotate([
				0,
				90,
				0,
			]) {
				cylinder(
					r = rod,
					h =bolt*4+2
				);
			}
		}
	}
}

module rodsupport_holes(
	rod=m8,
	bolt = m3,
	height=10
) {
	for(x=[0:1]) {
		translate([
			0,
			-rod-bolt*2+(rod*2+bolt*4)*x,
			-height-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}

	}
}

module bushing(
	rod = m8,
	length = m8*3,
	width = m8*4,
	height = m8*2,
	thickness = 1
) {
	linear_extrude(
		height = length,
		convexity = 5
	) {
		difference() {
			circle(
				width /2
			);
			
			rotate(45) {
				square(
					center = true,
					rod*2
				);
			}
			intersection() {
				for(a = [0:2]) {
					rotate(45 + 90 * (a-1)) {
						translate([
							width / 4 + thickness/2,
							width / 4 + thickness/2,
							0
						]) {
							square(
								center = true,
								width / 2
							);
						}
					}
				}
				circle(
					center = true,
					width /2 - thickness
				);
			}
			
			rotate(45 + 180) {
				translate([
					width / 4 + thickness/2,
					width / 4 + thickness/2,
					0
				]) {
					square(
						center = true, 
						width / 2
					);
				}
			}
		}
	}
}
