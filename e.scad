/*
 * e
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/rod.scad>
use <scadhelper/vitamins/2d.scad>
use <scadhelper/vitamins/hardware.scad>
use <scadhelper/vitamins/bearing.scad>
use <scadhelper/vitamins/rod.scad>
use <scadhelper/vitamins/nema.scad>

use <e_gears.scad>

e();

module e(
	rod = 8,
	motor = [17, 24, 5],
	material = [
		8,
		"Acriylic",
		[1,1,1,.5]
	],
	drive_shaft = 8,
	teeth = [9, 35],
	pitch = 35,
	h = 10,
	motor_shaft = 5,
	bolt = 3
) {

	//Bowden
	translate([
		0,
		0,
		-50
	]) {
		part(19, "Bowden") color([1,1,1,.5]) {
			difference() {
				cylinder(
					r = 6/2,
					h = 100
				);
				cylinder(
					r = 3.2/2,
					h = 100
				);
			}
		}
	}

	translate([
		-bearing60_width(drive_shaft)/2,
		drive_shaft + bearing60_offset(rod),
		0
	]) {
		rotate([0,90,0]) {
			bearing60(
				drive_shaft,
				id = 11
			);
		}
	}
	
	translate([material[0]/2,-pitch - drive_shaft/2,0])
	rotate([0,90,0])
	nema(
		motor = motor,
		id = 1
	) {
		translate([0,0,-24 + material[0] + 1.8]) {
			e_gears(
				teeth = teeth,
				pitch = pitch,
				h = h,
				motor_shaft = motor[2],
				drive_shaft = drive_shaft,
				id = 2
			) {
				part(3, "Hobbed bolt") {
					rod(
						r = drive_shaft/2,
						h = 10 + 1.8 + material[0]*3 -bearing60_width(drive_shaft),
						id = -1
					) {
						threaded_rod(
							r = drive_shaft/2,
							h = 40,
							id = -1
						);
						bearing60(
							drive_shaft,
							6
						) {
							m_washer(drive_shaft, 5) {
								m_nut(
									size = drive_shaft,
									id = 6
								) {
									m_nut(
										size = drive_shaft,
										id = 7
									);
								}
							}
						}
					}
					m_nut(
						size = drive_shaft,
						id = -1
					);
				}
				translate([0,0,10]) {
					m_washer(drive_shaft, 5) {
						bearing60(
							drive_shaft,
							6
						);
					}			
				}
			}
		}
	}

	translate([material[0]/2,-pitch/2,0])
	rotate([0,90,0])
	2d(
		[
			60,
			100
		],
		material,
		id = 2
	) {
		union() {
			translate([0,-pitch/2 - drive_shaft/2,0]) {
				nema_faceplate_drill(motor);
			}
		}
	}

	translate([-material[0]/2,-pitch/2,0])
	rotate([0,90,0])
	2d(
		[
			60,
			100
		],
		material,
		id = 2
	) {
		union() {
		}
	}

	translate([-material[0]*3/2,-pitch/2,0])
	rotate([0,90,0])
	2d(
		[
			60,
			100
		],
		material,
		id = 2
	) {
		union() {
		}
	}
}