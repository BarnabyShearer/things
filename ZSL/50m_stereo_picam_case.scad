/*
 * 50m Stereo PiCam Case
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

include <MCAD/nuts_and_bolts.scad>

case();

module case(
	d = [
		250,     // Length
		100/2,  // Inner radius
		103/2,  // Outer radius
	],
	ends = [
		[20, 20, 20, 20], // Heights
		140/2,                   // Radius
	],
	potting = [20, 50/2],  // Potting length and radius
	orings = 2, // Per end
	struts = [
		3, // Count
		6, // M-size
	],
	cable = 20/2, // Raduis
) {

	// Endcaps
	color([1,1,1,1]) {
		translate([
			0,
			0,
			-ends[0][0] -ends[0][1]
		]) {
			cylinder(
				r = ends[1],
				h = ends[0][0]
			);
		}
		translate([
			0,
			0,
			-ends[0][1]
		]) {
			cylinder(
				r = d[1],
				h = ends[0][1] 
			);
		}

		translate([
			0,
			0,
			d[0] - ends[0][2] - ends[0][1]
		]) {
			cylinder(
				r = d[1],
				h = ends[0][2] 
			);
		}
		translate([
			0,
			0,
			d[0] - ends[0][1]
		]) {
			cylinder(
				r = ends[1],
				h = ends[0][3]
			);
		}
	}

	//Struts
	color([.5,.5,.5]) {
		for (x=[0:struts[0]-1]) {
			rotate([
				0,
				0,
				360/struts[0]*x
			]) {
				translate([
					d[2]+ (ends[1] - d[2])/2,
					0,
					-ends[0][0] -ends[0][1] -METRIC_NUT_THICKNESS[struts[1]]
				]) {
					cylinder(
						r = struts[1]/2,
						h = ends[0][0] + d[0] + ends[0][3] + METRIC_NUT_THICKNESS[struts[1]] * 2
					);
					nutHole(
						struts[1]
					);
				}
				translate([
					d[2]+ (ends[1] - d[2])/2,
					0,
					-ends[0][1] + d[0] + ends[0][3] 
				]) {
					nutHole(
						struts[1]
					);
				}
			}
		}
	}

	//o-rings
	color([0,0,0]) {
		for (x=[0:orings-1]) {
			translate([
				0,
				0,
				-ends[0][0] + ends[0][0]/(orings + 1) * (x + 1)
			]) {
				cylinder(
					r = d[1] + 1,
					h = 1
				);
			}
			translate([
				0,
				0,
				-ends[0][0] + d[0] - ends[0][0]/(orings + 1) * (x + 1)
			]) {
				cylinder(
					r = d[1] + 1,
					h = 1
				);
			}
		}
	}

	// Potting
	color([0,0,0]) {
		translate([
			0,
			0,
			-ends[0][1] + d[0] - ends[0][2]  - potting[0]
		]) {
			cylinder(
				r = potting[1],
				h = potting[0]
			);
		}
	}

	// Cable
	translate([
		0,
		0,
		-ends[0][1] + d[0] + ends[0][3] 
	]) {
		color([.75,.75,.75]) {
			cylinder(
				r = cable,
				h = 100
			);
		}
		color([.25,.25,.25]) {
			cylinder(
				r = cable + 5,
				h = 30
			);
		}
	}

	// Tube
	color([1,1,1,.25]) {
		translate([
			0,
			0,
			-ends[0][1]
		]) {
			difference() {
				cylinder(
					r = d[2],
					h = d[0]
				);
				cylinder(
					r = d[1],
					h = d[0] + 2
				);
			}
		}
	}
}
