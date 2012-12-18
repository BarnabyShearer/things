/*
 * 50m Stereo PiCam Supports
 *
 * Copyright 2012 Reading Makerspace Ltd
 * Authors:
 *  Gary Fletcher
 *  Ryan White
 *  Barnaby Shearer
 *  Richard Ibbotson
 *  Paul Hegarty
 *
 * License CC BY 3.0
 */
$fn=60;

picam_supports();

module picam_supports(
	e = 0.1,
	support_thickness = 3,
	d = [
		100/2,                  // Inner radius
		250 - 20 - 20,      // Inner length
		[25, 55/2],           // Potting clearence
	],
	camera = [
		26.5/2,    // Radius
		[25, 20],   // Distances from end
	],
	pi = [
		[28, -17, 143], // Position
		[0, 97, 90],         // Orientation
	],
	cross = [
		6,
		37.5
	]
) {

	//Support 
	center_ring(
		e = e,
		support_thickness = support_thickness,
		d = d,
		camera = camera,
		pi = pi,
		cross = cross
	);

	for(i=[0:1]) {
		translate([
			(d[0]*2+10)*(i+1),
			0,
			0
		]) {
			camera_ring(
				e = e,
				support_thickness = support_thickness,
				d = d,
				camera = camera,
				pi = pi,
				cross = cross,
				i = i
			);	
		}

		translate([
			0,
			d[0]*2*i+d[0]+10,
			0
		]) {
			strut(
				e = e,
				support_thickness = support_thickness,
				d = d,
				camera = camera,
				pi = pi,
				cross = cross,
				i = i
			);	

		}
	}
}

module center_ring(
	e,
	support_thickness,
	d,
	camera,
	pi,
	cross,
) {
	difference() {
		cylinder(
			r = d[0],
			h = support_thickness
		);
		translate([
			-pi[0][0]-.5,
			-23,
			- 1
		]) {
			cube([
				59,
				33,
				support_thickness + 2
			]);
		}
		for(i=[0:1]) {
			translate([
				support_thickness+cross[0] - i*cross[1]-support_thickness,
				-camera[0] - support_thickness*3 - 11*(1-i),
				-1
			]) {
				cube([
					support_thickness + e,
					camera[0]*2 + support_thickness*6 + 11*(1-i),
					support_thickness + 2
				]);
			}
		}

		//Cable hole
		translate([
			-10,
			26,
			-1,
		]) {
			cylinder(
				r = 10,
				h = support_thickness + 2
			);
		}
	}
}

module camera_ring(
	e,
	support_thickness,
	d,
	camera,
	pi,
	cross,
	i = 0,
) {
	difference() {
		cylinder(
			r = d[0],
			h = support_thickness
		);
		// Eyehole
		translate([
			-51,
			-camera[0],
			-camera[0] + support_thickness/2
		]) {
			cube([
				60,
				camera[0]*2,
				camera[0]*2
			]);
		}
		translate([
				-0,
			-camera[0]/2,
			-camera[0]/2 + support_thickness/2
		]) {
			cube([
				30,
				camera[0],
				camera[0]
			]);
		}
		if (i==0) {
			// USB
			translate([
				-13,
				-33,
				-1
			]) {
				cube([
					20,
					33,
					support_thickness + 2
				]);
			}
		}
		for(i=[0:1]) {
			translate([
				support_thickness+cross[0] - i*cross[1]-support_thickness,
				-camera[0] - support_thickness*2,
				-1
			]) {
				cube([
					support_thickness,
					camera[0]*2 + support_thickness*4,
					support_thickness + 2
				]);
			}
		}
		//Cable hole
		translate([
			-10,
			26,
			-1,
		]) {
			cylinder(
				r = 10,
				h = support_thickness + 2
			);
		}
	}
}

module strut(
	e,
	support_thickness,
	d,
	camera,
	pi,
	cross,
	i = 0,
) {
	translate([
		camera[1][0],
		sqrt( d[0]*d[0] - (cross[0]+support_thickness - i*(cross[1]+support_thickness)) * (cross[0]+support_thickness - i*(cross[1]+support_thickness))),
		0
	]) {
		difference() {
			union() {
				translate([
					support_thickness/2,
					-camera[0] - support_thickness*3 - 11*(1-i),
					0,
				]) {
					cube([
						(d[1] - d[2][0] - camera[1][0]-camera[1][1])-support_thickness,
						camera[0]*2 + support_thickness*6 + 11*(1-i),
						support_thickness
					]);
				}
				translate([
					support_thickness/2,
					-camera[0] - support_thickness*4 - 11*(1-i),
					0,
				]) {
					cube([
						(d[1]  - camera[1][0]-camera[1][1])/2-support_thickness,
						camera[0]*2 + support_thickness*8 + 11*(1-i),
						support_thickness
					]);
				}
				// Eye Holders
				for(i=[0:1]) {
					translate([
						(d[1] - d[2][0] - camera[1][0]-camera[1][1])*i ,
						0,
						0
					]) {
						cylinder(
							r= camera[0] + support_thickness*2,
							h = support_thickness
						);
					}
				}
			}
			// Eye Holes
			for(i=[0:1]) {
				translate([
					(d[1] - d[2][0] - camera[1][0]-camera[1][1])*i ,
					0,
					-1
				]) {
					cylinder(
						r= camera[0] + e,
						h = support_thickness + 2
					);
				}
			}
	
			if(i==0) {
				//Pi Hole
				translate([
					pi[0][2]-camera[1][0],
					pi[0][1],
					-1
				]) {
					rotate([
						0,
						0,
						pi[1][1],
					]) {
						translate([
							-3.1,
							0,
							0,
						]) {
							cube([
								35,
								88,
								support_thickness+2,
							]);
						}
						translate([
							-3.1,
							-18,
							0,
						]) {
							cube([
								3.2,
								50,
								support_thickness  + 2
							]);
						}
					}
				}
			}
			if(i==1) {
				translate([
					pi[0][2]-camera[1][0],
					pi[0][1],
					-1
				]) {
					rotate([
						0,
						0,
						pi[1][1],
					]) {
						//Audio
						translate([
							8.1,
							65,
							0,
						]) {
							cylinder(
								r= 3.5+e,
								h = support_thickness  + 2
							);
						}
						//Video
						translate([
							9.75,
							45.6,
							0
						]) {
							cylinder(
								r= 4.15+e,
								h = support_thickness  + 2
							);
						}
					}
				}
			}
		}
	}
}