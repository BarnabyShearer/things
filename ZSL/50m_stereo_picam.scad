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

include <50m_stereo_picam_configuration.scad>
use <50m_stereo_picam_case.scad>
use <50m_stereo_picam_supports.scad>
use <pi.scad>
use <eve.scad>
use <humble_pi.scad>
use <microsoft_lifecam_cinema.scad>
use <hack_hd.scad>

picam();

module picam() {

	//CPU
	translate(pi[0]) {
		rotate(pi[1]) {
			pi_plus();
		}
	}
	
	//Eyes
	for(i=[0:1]) {
		translate([
			-46 - e,
			0,
			camera[1][0] + (d[1] - potting[0] - camera[1][0] - camera[1][1])*i
		]) {
			rotate([
				90,
				0,
				90,
			]) {
				camera();
			}
		}
	}

	// The Third Eye
	translate([
		-23.5,
		20,
		110
	]) {
		rotate([
			180,
			90,
			0
		]) {
			hack_hd();
		}
	}	

	//Support
	color([.25,.25,.25]) {
		translate([
			0,
			0,
			(d[1] - support_thickness)/2 + 7
		]) {
			center_ring();
		}
		for(i=[0:1]) {
			translate([
				0,
				0,
				camera[1][0] + (d[1] - potting[0] - camera[1][0] - camera[1][1])*i - support_thickness/2
			]) {
				camera_ring();	
			}
		}
		for(i=[0:2]) {			
			translate([
				cross[i] + support_thickness,
				0,
				camera[1][0]
			]) {
				rotate([
					0,
					-90,
					0
				]) {
					strut();
				}
			}
		}
	}
	
	case();
}

module pi_plus() {
	pi(
		power=0,
		usb=[29, 29]
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