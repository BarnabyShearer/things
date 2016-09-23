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

//todo: motor-D and grub


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
	teeth = [11, 45],
	pitch = 40,
	h = 10,
	motor_shaft = 5,
	bolt = 3
) {

	//Bowden
	translate([0,0,-50])
	cylinder(
		r = 1.75/2,
		h = 100
	);
	translate([
		0,
		0,
		-14
	]) {
		color([1,1,.7]) {
			difference() {
				union() {
					cylinder(
						r = 8.2/2,
						h = 8
					);
					translate([0,0,-6]) {
						cylinder(
							r = 11.3/2,
							h = 6,
							$fn = 6
						);
					}
					translate([0,0,-6-6]) {
						cylinder(
							r = 9/2,
							h = 6
						);
					}
				}
				cylinder(
					r = 2.7/2,
					h = 10
				);
			}
		}
	}

	*translate([
		-1.5,
		rod/2+1,
		-4
	]) {
		rotate([0,90,0]) {
			bearing(
				[3, 7, 3],
				id = 11
			);
		}
	}
	*translate([
		-1.5,
		rod/2+1,
		4
	]) {
		rotate([0,90,0]) {
			bearing(
				[3, 7, 3],
				id = 11
			);
		}
	}
	
	
	translate([material[0]/2 + 2.5,-pitch - drive_shaft/2,0])
	rotate([0,90,0])
	nema(
		motor = motor,
		id = 1
	) {
		translate([0,0,-24 + material[0] + 3]) {
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
						h = 27.5-1.5,
						id = -1
					)
						threaded_rod(
							r = drive_shaft/2,
							h = 3,
							id = -1
						)
							rod(
								r = drive_shaft/2,
								h = 7,
								id = -1
							) {
						threaded_rod(
							r = drive_shaft/2,
							h = 20,
							id = -1
						);
						translate([0,0,-2])
						bearing(
							[8, 16, 5],
							6
						) {
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
					m_nut(
						size = drive_shaft,
						id = -1
					);
				}
				translate([0,0,h]) {
					translate([0,0,3 + 3]) {
								bearing(
									[8, 16, 5],
									8
								);
					}			
				}
			}
		}
	}

	translate([material[0]/2 + 2.5,-25.5,0])
	rotate([0,90,0])
	2d(
		[
			42.2,
			42.2 + 19
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


	translate([0,-4,8/2+2])
	
	2d(
		[
			23,
			16
		],
		material,
		id = 2
	) {
	}
	translate([0,-4,-6-8])
	2d(
		[
			23,
			16
		],
		material,
		id = 2
	) {
	}


}