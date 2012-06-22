/*
 * TVRRUG x-axis end
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;
m8 = 7.80 / 2;
m3 = 2.8 /2;
m3_nut = 6.1 /2;

prusa_belt_height = 11.5;
prusa_belt_offset = 17.5;

t5_thickness = 2.5;
t5_width = 5;

t5_16=14;

608bearing = 22/2;
608bearing_width = 7;


m8washer = 15.8/2;
m8washer_width=1.5;

xend_base();
%rotate([
	180,
	0,
	0
]) {
	xend_top();
}

/*
translate([
	0,
	-80,
	 0
]) {
	xend_top();
	%rotate([
		180,
		0,
		0
	]) {
		xend_base();
	}
}*/

module xend_base(
	xrodgap = 50,
	zrodgap=30,
	rod = m8,
	bolt = m3,
	thickness = 1.1,
	belt_width=t5_width,
	belt_thickness=t5_thickness,
	belt_height = prusa_belt_height,
	belt_offset = prusa_belt_offset,
	pully = t5_16,
	pully_length=20,
	bearing = 608bearing,
	bearing_width = 608bearing_width,
	washer = m8washer,
	washer_width = m8washer_width,
) {

	height =  rod*4;
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
		//Belt
		translate([
			0,
			-(belt_width/2+xrodgap/2+belt_offset)-belt_width,
			belt_thickness+belt_height-(pully*2-belt_thickness)*r,
		]) {
			cube([
				100,
				belt_width,
				belt_thickness,
			]);
		}
	}

	//Idler
	%translate([
		zrodgap/2,
		-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width,
		belt_thickness+belt_height-pully+belt_thickness
	]) {
		rotate([
			90,
			0,
			0,
		]) {
			idler(
				bearing = bearing,
				bearing_width = bearing_width,
				washer = washer,
				washer_width = washer_width
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
					-xrodgap/2-rod-bolt*4,
					-height,
				]) {
					cube([
						thickness,
						rod*2+bolt*8+xrodgap,
						rod*3,
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
						rod*3,
					]);
				}

			}

			//Idler support
			translate([
				-thickness/2,
				-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width,
				-height
			]) {
				cube([
					zspace + bolt*4,
					-(-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width)-xrodgap/2-rod-bolt*4,
					height+belt_thickness+belt_height-pully+belt_thickness,
				]);
			}
			//Idler support
			translate([
				-thickness/2,
				-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width-(bearing_width*2+washer_width*2+bolt*4),
				-height
			]) {
				cube([
					zspace + bolt*4,
					bolt*4,
					height+belt_thickness+belt_height-pully+belt_thickness,
				]);
			}

			//Plate
			translate([
				-thickness/2,
				-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width-(bearing_width*2+washer_width*2+bolt*4),
				-height,
			]) {
				cube([
					zspace + bolt*4,
					(belt_width/2+xrodgap/2+belt_offset)+xrodgap/2+rod+bolt*4+bearing_width+washer_width +belt_width/2 + bolt*4,
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

		//Idler Support holes
		for(y=[0:1]) {
			
				translate([
					zrodgap/2-rod-bolt*2+(rod*2+bolt*4)*y,
					-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width-(bearing_width*2+washer_width*2+bolt*4)+bolt*2,
					-50,
				]) {
					cylinder(
						h=100,
						r=bolt
					);
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

		//Idler mount
		translate([
			zrodgap/2,
			0,
			belt_thickness+belt_height-pully+belt_thickness
		]) {
			rotate([
				90,
				0,
				0,
			]) {
				cylinder(
					r = rod,
					h=100
				);
			}
		}
	
	}

	//Bushing
	translate([
		0,
		0,
		-height
	]) {
		bushing(
			rod=rod,
			length = rod*3,
			width = rod*4,
			height=rod*2,
			thickness = thickness
		);
	}

}

module xend_top(
	xrodgap = 50,
	zrodgap=30,
	rod = m8,
	bolt = m3,
	thickness = 1.1,
	belt_width=t5_width,
	belt_thickness=t5_thickness,
	belt_height = prusa_belt_height,
	belt_offset = prusa_belt_offset,
	pully = t5_16,
	pully_length=20,
	bearing = 608bearing,
	bearing_width = 608bearing_width,
	washer = m8washer,
	washer_width = m8washer_width,
) {

	height =  rod*5;
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
		//Belt
		translate([
			0,
			(belt_width/2+xrodgap/2+belt_offset),
			-(belt_thickness+belt_height-(pully*2-belt_thickness)*r)-belt_thickness,
		]) {
			cube([
				100,
				belt_width,
				belt_thickness,
			]);
		}
	}

	//Idler
	%translate([
		zrodgap/2,
		(belt_width/2+xrodgap/2+belt_offset)+belt_width/2-bearing_width-washer_width,
		-(belt_thickness+belt_height-pully+belt_thickness)
	]) {
		rotate([
			-90,
			0,
			0,
		]) {
			idler(
				bearing = bearing,
				bearing_width = bearing_width,
				washer = washer,
				washer_width = washer_width
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
					-xrodgap/2-rod-bolt*4,
					-height,
				]) {
					cube([
						thickness,
						rod*2+bolt*8+xrodgap,
						rod*3,
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
						rod*3,
					]);
				}

			}

			//Idler support
			translate([
				-thickness/2,
				xrodgap/2+rod+bolt*4+(washer_width*2+bearing_width*2-(-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width)-xrodgap/2-rod-bolt*4),
				-height
			]) {
				cube([
					zspace + bolt*4,
					bolt*4,
					height-(belt_thickness+belt_height-pully+belt_thickness),
				]);
			}
			//Idler support
			translate([
				-thickness/2,
				xrodgap/2+rod+bolt*4,
				-height
			]) {
				cube([
					zspace + bolt*4,
					-(-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width)-xrodgap/2-rod-bolt*4,
					height-(belt_thickness+belt_height-pully+belt_thickness),
				]);
			}
			//Plate
			translate([
				-thickness/2,
				-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width-(-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width)-xrodgap/2-rod-bolt*4,
				-height,
			]) {
				cube([
					zspace + bolt*4,
					(belt_width/2+xrodgap/2+belt_offset)+xrodgap/2+rod+bolt*4+bearing_width+washer_width +belt_width/2 + bolt*4,
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

		//Idler Support holes
		for(y=[0:1]) {
			translate([
				zrodgap/2-rod-bolt*2+(rod*2+bolt*4)*y,
				xrodgap/2+rod+bolt*4+(washer_width*2+bearing_width*2-(-(belt_width/2+xrodgap/2+belt_offset)-belt_width/2+bearing_width+washer_width)-xrodgap/2-rod-bolt*4)*1+bolt*2,
				-50,
			]) {
				cylinder(
					h=100,
					r=bolt
				);
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

		//Idler mount
		translate([
			zrodgap/2,
			100,
			-(belt_thickness+belt_height-pully+belt_thickness)
		]) {
			rotate([
				90,
				0,
				0,
			]) {
				cylinder(
					r = rod,
					h=100
				);
			}
		}

	}

	//Bushing
	translate([
		0,
		0,
		-height
	]) {
		bushing(
			rod=rod,
			length = rod*3,
			width = rod*4,
			height=rod*2,
			thickness = thickness
		);
	}

}

module idler(
	bearing = 608bearing,
	bearing_width = 608bearing_width,
	washer = m8washer
) {
	translate([
		0,
		0,
		washer_width
	]) {
		cylinder(
			r = bearing,
			h = bearing_width*2
		);
	}
	cylinder(
		r = washer,
		h = bearing_width*2+washer_width*2
	);
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
			union() {

				circle(
					width /2
				);
			}
			rotate(45) {
				square(
					center = true,
					rod*2
				);
			}
			intersection() {
				for(a = [0:3]) {
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
			
			
		}
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