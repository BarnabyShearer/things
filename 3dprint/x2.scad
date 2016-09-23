/*
 * kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/rod.scad>
use <scadhelper/vitamins/linear_bearing.scad>
use <scadhelper/vitamins/bearing.scad>
use <scadhelper/vitamins/hardware.scad>
use <scadhelper/vitamins/nema.scad>
use <scadhelper/vitamins/chain.scad>
use <scadhelper/vitamins/2d.scad>
use <scadhelper/bend.scad>
use <kraken.scad>

x();

//TODO: FAN

module x(
	rod = 8,
	x_rod_pitch = 50,
	z_rod_pitch = 418 - 8,
	z_thread_pitch = 358 - 8,
	nozzel_height = 37,
	motor = [17, 24, 5],
	belt = [5, 5],
	bolt = 3,
	pulley = [13],
	material = [
		6,
		"Acrylic",
		[.75,.75,.75,.75]
	],
	X = 0,
	Z = 0,
	id
) {
	translate([
		(z_rod_pitch+z_thread_pitch)/4 + rod/2 + 1 + material[0],
		-rod/2-1,
		nozzel_height
	]) {
		rotate([
			90,
			0,
			0
		]) {
			2d(
				[
					(z_rod_pitch-z_thread_pitch)/2,
					linear_bearing_length(rod) + rod
				],
				material,
				id=1
			);
		}
	}

#translate([
		(z_rod_pitch+z_thread_pitch)/4,
		-rod/2-1,
		nozzel_height
	]) {
		rotate([
			90,
			0,
			0
		]) {
			bearing60(rod);
		}
	}

#translate([
		(z_rod_pitch+z_thread_pitch)/4,
		25,
		nozzel_height
	]) {
		rotate([
			90,
			0,
			0
		]) {
			bearing60(rod);
		}
	}


	translate([
		(z_rod_pitch+z_thread_pitch)/4 + rod/2 + 1 + material[0],
		rod*3,
		nozzel_height
	]) {
		rotate([
			90,
			0,
			0
		]) {
			2d(
				[
					(z_rod_pitch-z_thread_pitch)/2,
					x_rod_pitch + rod*2
				],
				material,
				id=1
			);
		}
	}
	translate([
		(z_rod_pitch+z_thread_pitch)/4 + 20,
		5,
		nozzel_height
	]) {
		rotate([
			0,
			90,
			0
		]) {
			2d(
				[
					x_rod_pitch + rod*2,
					rod*4
				],
				material,
				id=1
			);
		}
	}
	translate([
		(z_rod_pitch+z_thread_pitch)/4 + 4,
		5,
		nozzel_height
	]) {
		rotate([
			0,
			90,
			0
		]) {
			2d(
				[
					x_rod_pitch + rod*2,
					rod*4
				],
				material,
				id=1
			);
		}
	}
	translate([
		(z_rod_pitch+z_thread_pitch)/4,
		0,
		18
	]) {
		2d(
			[
				(z_rod_pitch-z_thread_pitch)/2 + rod*3,
				rod*2
			],
			material,
			id=1
		);
	}
	translate([
		(z_rod_pitch+z_thread_pitch)/4,
		0,
		18+material[0]
	]) {
		2d(
			[
				(z_rod_pitch-z_thread_pitch)/2 + rod*3,
				rod*2
			],
			material,
			id=1
		);
	}

	for(x=[0:1]) {
		translate([
			space(z_rod_pitch, x),
			0,
			0
		]) {

			//Z-Rods
			%rod(
				r = rod/2,
				h = 250,
				id = -1
			);
		}
		translate([
			space(z_thread_pitch,x),
			0,
			0
		]) {

			//Z-drive rod
			%threaded_rod(
				r = rod/2,
				h = 250,
				id = -1
			);
		}
	}
	translate([
		0,
		0,
		Z
	]) {

	for(x=[0:1]) {
		translate([
			space(z_rod_pitch, x),
			0,
			0
		]) {
			//Z-Rod Bearings
			for(z=[0:1]) {
				translate([
					0,
					0,
					nozzel_height 
				]) {
					linear_bearing(
						size = rod,
						id = id + x*2 + z
					);
				}
			}
			
			if(x==0) {
				translate([
					(z_rod_pitch-z_thread_pitch)/4,
					-9,
					nozzel_height
				]) {
					rotate([
						-90,
						45,
						0
					]) {

						//Motor
						nema(
							motor = motor,
							id = id + 5
						) {

							//Belt
							rotate([180,0,-45])
							chain(
								chain = belt,
								gears = [
									[0, 0, pulley[0], -1],
									[(z_rod_pitch+z_thread_pitch)/2, 0, pulley[0], -1]
								],
								id = id + 6
							) {

								//Pully
								chain_gear(
									pulley[0],
									[belt[0], belt[1]*3],
									[0, 0,	motor[2]/2],
									id = id + 7
								);

								//Idler
								chain_gear(
									pulley[0],
									[belt[0], belt[1]*3],
									[0,	0,	motor[2]/2],
									id = id + 8
								);
							}
						}
					}
				}
			}
		}
		translate([
			space(z_thread_pitch,x),
			0,
			0
		]) {
	
			//Z-drive nut
			translate([
				0,
				0,
				nozzel_height - rod*.8/2 -16
			]) {
				color(color_brass) m_nut(
					size = rod,
					id = id + 9 + x
				);
			}
		}
	}

	//Y-rods
	for(z=[0:1]) {
		translate([
			-z_rod_pitch/2,
			13,
			nozzel_height + space(x_rod_pitch, z)
		]) {
			rotate([
				0,
				90,
				0
			]) {
				rod(
					r = rod/2,
					h = z_rod_pitch,
					id = id + 11 + z
				);
			}
		}
	}

	x_carriage(
		rod = rod,
		nozzel_height = nozzel_height,
		x_rod_pitch = x_rod_pitch,
		X = X,
		Z = Z,
		id = id + 18
	);

	translate([
		(z_rod_pitch+z_thread_pitch)/4,
		0,
		nozzel_height
	]) {
		x_end(
			rod = rod,
			x_rod_pitch = x_rod_pitch,
			z_rods_pitch = (z_rod_pitch - z_thread_pitch)/2,
			bolt = bolt,
			id = id + 20
		);
	}

	translate([
		-(z_rod_pitch+z_thread_pitch)/4,
		0,
		nozzel_height
	]) {
		rotate([0,180,0])
		x_end(
			rod = rod,
			x_rod_pitch = x_rod_pitch,
			z_rods_pitch = (z_rod_pitch - z_thread_pitch)/2,
			bolt = bolt,
			motor = motor,
			id = id + 23
		);
	}
	}
}