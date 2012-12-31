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

include <50m_stereo_picam_configuration.scad>;

picam_supports();

module picam_supports() {

	//Support 
	translate([
		-d[0]*1.45,
		0,
		0
	]) {
		center_ring();
	}

	for(i=[0:1]) {
		translate([
			(d[0]*2)*(i + 1) - 68,
			0,
			0
		]) {
			camera_ring(
				i = i
			);	
		}
	}
	for(i=[0:2]) {
		translate([
			0,
			d[0]*.95*i + d[0] + 25,
			0
		]) {
			strut(
				i = i
			);	

		}
	}
}

module center_ring(
	laser = 0,
) {
	difference() {
		cylinder(
			r = d[0] + laser,
			h = support_thickness
		);
		translate([
			-17,
			-59/2,
			- 1
		]) {
			cube([
				36,
				59,
				support_thickness + 2
			]);
		}
		for(i=[0:2]) {
			translate([
				cross[i] + laser,
				-camera[0] - support_thickness*2.5 +laser,
				-1
			]) {
				cube([
					support_thickness + e - laser*2,
					camera[0]*2 + support_thickness*5 - laser*2,
					support_thickness + 2
				]);
			}
		}
	}
}

module camera_ring(
	i = 0,
	laser = 0,
) {
	difference() {
		cylinder(
			r = d[0] + laser,
			h = support_thickness
		);

		// Eyehole
		translate([
			-51,
			-camera[0] + laser,
			-camera[0] + support_thickness/2 + laser
		]) {
			cube([
				60,
				camera[0]*2 - laser*2,
				camera[0]*2 - laser*2
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
		for(i=[0:2]) {
			translate([
				cross[i] + laser,
				-camera[0] - support_thickness*2 + laser,
				-1
			]) {
				cube([
					support_thickness - laser*2,
					camera[0]*2 + support_thickness*4 - laser*2,
					support_thickness + 2
				]);
			}
		}

		//Mic Hole
		translate([
			-37,
			-27.1/2 -4,
			-1,
		]) {
			cube([
				20,
				5,
				support_thickness + 2
			]);
		}

		//Mount Hole
		translate([
			-23,
			0,
			-1,
		]) {
			cube([
				25,
				25,
				support_thickness + 2
			]);
		}

		//Cable Hole
		if(i==1) {
			translate([
				-5,
				-27,
				-1,
			]) {
				cylinder(
					r = 20/2,
					h = support_thickness + 2
				);
			}
		}
	}
}

module strut(
	i = 0,
	laser = 0,
) {
	difference() {
		union() {
			if(i!=1) {
				translate([
					support_thickness/2 - laser,
					-camera[0] - support_thickness*2.5 - laser,
					0,
				]) {
					cube([
						(d[1] - potting[0] - camera[1][0] - camera[1][1]) - support_thickness + laser*2,
						camera[0]*2 + support_thickness*5 + laser*2,
						support_thickness
					]);
				}
				translate([
					support_thickness/2 - laser,
					-camera[0] - support_thickness*3 - laser,
					0,
				]) {
					cube([
						(d[1]  - camera[1][0] - camera[1][1])/2 - support_thickness+7 + laser*2,
						camera[0]*2 + support_thickness*6 + laser*2,
						support_thickness
					]);
				}
			}
			
			// Eye Holders
			for(i=[0:1]) {
				translate([
					(d[1] - potting[0] - camera[1][0] - camera[1][1])*i ,
					0,
					0
				]) {
					cylinder(
						r= camera[0] + support_thickness*2 +laser,
						h = support_thickness
					);
				}
			}
		}

		//USB Easing
		if(i==1) {
			translate([
				support_thickness/2 + camera[0]+support_thickness*2,
				-camera[0] - support_thickness*2.5 - laser,
				-1,
			]) {
				cube([
					(d[1] - potting[0] - camera[1][0] - camera[1][1]) - support_thickness + laser*2 - camera[0]*2 - support_thickness,
					camera[0]*2 + support_thickness*5 + laser*2,
					support_thickness + 2
				]);
			}			
		}

		// Eye Holes
		for(i=[0:1]) {
			translate([
				(d[1] - potting[0] - camera[1][0] - camera[1][1])*i ,
				0,
				-1
			]) {
				cylinder(
					r= camera[0] - laser,
					h = support_thickness + 2
				);
			}
		}

		//Third Eye
		if(i==2) {
			translate([
				79,
				0,
				-1
			]) {
				cylinder(
					r=20/2,
					h=support_thickness + 2
				);
			}
		}
	}
}