/*
 * 50m Stereo PiCam
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

use <50m_stereo_picam_case.scad>
use <50m_stereo_picam_supports.scad>
use <pi.scad>
use <eve.scad>
use <humble_pi.scad>
use <microsoft_lifecam_cinema.scad>

picam();

module picam(
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

	//CPU
	translate(pi[0]) {
		rotate(pi[1]) {
			pi_plus();
		}
	}
	
	//Eyes
	for(i=[0:1]) {
		translate([
			-48,
			0,
			camera[1][0] + (d[1] - d[2][0] - camera[1][0]-camera[1][1])*i
		]) {
			rotate([
				0,
				90,
				0,
			]) {
				camera();
			}
		}
	}

	//Support
	color([1,0,1]) {
		translate([
			0,
			0,
			(d[1] - support_thickness)/2
		]) {
			center_ring(
				e = e,
				support_thickness = support_thickness,
				d = d,
				camera = camera,
				pi = pi,
				cross = cross
			);
		}
		for(i=[0:1]) {
			translate([
				0,
				0,
				camera[1][0] + (d[1] - d[2][0] - camera[1][0]-camera[1][1])*i - support_thickness/2
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
				cross[0] - i*cross[1]+support_thickness,
				-sqrt( d[0]*d[0] - (cross[0]+support_thickness - i*(cross[1]+support_thickness)) * (cross[0]+support_thickness - i*(cross[1]+support_thickness))),
				0
			]) {
				rotate([
					0,
					-90,
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
	}
	
	case();
}

module pi_plus() {
	pi(
		power=0,
		usb=[47, 47]
	);
	translate([
		0,
		0,
		14.1
	]) {
		humble_pi();
		translate([
			0,
			0,
			14.1 + 1 // Not fully seated
		]) {
			eve();
		}
	}
}
