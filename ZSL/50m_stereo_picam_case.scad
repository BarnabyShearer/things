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

include <50m_stereo_picam_configuration.scad>
include <MCAD/nuts_and_bolts.scad>

case();

module case() {

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
				r = d[0],
				h = ends[0][1] 
			);
		}

		translate([
			0,
			0,
			d[1]
		]) {
			cylinder(
				r = d[0],
				h = ends[0][2] 
			);
		}
		translate([
			0,
			0,
			d[1] + ends[0][2]
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
					d[0]+ (ends[1] - d[0])/2,
					0,
					-ends[0][0] -ends[0][1] -METRIC_NUT_THICKNESS[struts[1]]
				]) {
					cylinder(
						r = struts[1]/2,
						h = ends[0][0] + ends[0][1] + d[1] + ends[0][2] + ends[0][3] + METRIC_NUT_THICKNESS[struts[1]] * 2
					);
					nutHole(
						struts[1]
					);
				}
				translate([
					d[0]+ (ends[1] - d[0])/2,
					0,
					d[1] + ends[0][2] + ends[0][3]
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
				-ends[0][1] + ends[0][1]/(orings + 1) * (x + 1)
			]) {
				cylinder(
					r = d[0] + 1,
					h = 1
				);
			}
			translate([
				0,
				0,
				d[1] + ends[0][1]/(orings + 1) * (x + 1)
			]) {
				cylinder(
					r = d[0] + 1,
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
			d[1] - potting[0]
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
		d[1] + ends[0][2] + ends[0][3]
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
					r = d[0] + d[2],
					h = d[1] + ends[0][1] + ends[0][2]
				);
				cylinder(
					r = d[0],
					h = d[1] + ends[0][1] + ends[0][2] + 2
				);
			}
		}
	}
}
