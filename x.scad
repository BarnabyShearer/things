/*
 * kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/rod.scad>
use <scadhelper/vitamins/linear_bearing.scad>
use <scadhelper/vitamins/hardware.scad>
use <scadhelper/vitamins/nema.scad>
use <scadhelper/vitamins/chain.scad>

x();

//TODO: FAN

module x(
	rod = 8,
	x_rod_pitch = 50,
	z_rod_pitch = 418 - 8,
	z_thread_pitch = 358 - 8,
	y_rod_depth = 13,
	nozzel_height = 50,
	motor = [17, 24, 5],
	belt = [5, 5],
	bolt = 3,
	pulley = [13],
	X = 0,
	Z = 0,
	id
) {
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
					nozzel_height + space(linear_bearing_length(rod) + rod, z) 
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
			y_rod_depth,
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

module x_end(
	rod,
	x_rod_pitch,
	z_rods_pitch,
	bolt,
	motor = 0,
	id
) {
	//X-Carriage
	part(id, "X-end idle back") color(color_plastic) {
		difference() {
			union() {
				translate([
					-z_rods_pitch/2 - rod - bolt,
					13 + 1,
					-x_rod_pitch/2 - rod - bolt/2
				]) {
					cube([
						z_rods_pitch + rod*2.5 + bolt,
						rod ,
						x_rod_pitch + rod*2 + bolt
					]);
				}
				//Ends
				for(z=[0:1]) {
					translate([
						+z_rods_pitch/2 + rod*1.5,
						13,
						space(x_rod_pitch, z)
					]) {
						rotate([
							0,
								-90,
							0
						]) {
								rod(
								r = rod/2,
								h = rod/2,
								id = 11+z
							);
						}
					}
				}
			}
			//bolts
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						space(z_rods_pitch + rod + bolt*1.5, x),
						0,
						space(x_rod_pitch + rod + bolt*1.5, y),
					]) {
						rotate([-90,0,0]) {
							cylinder(
								r = bolt/2,
								h = 100
							);
						}
					}
				}
			}
			
			//bearing
			rotate([-90,0,0]) {
				cylinder(
					r = rod/2,
					h = 100
				);
			}
			//Belt gap
			translate([
				-z_rods_pitch/2 - rod -.1 -bolt,
				13 + 1 - rod - .1,
				-x_rod_pitch/2 + rod
			]) {
				cube([
					z_rods_pitch + .2 + rod + bolt,
					rod/2 + rod,
					x_rod_pitch - rod*2
				]);
			}
			//Rod holders
			for(z=[0:1]) {
				translate([
					+z_rods_pitch/2 + rod,
					13,
					space(x_rod_pitch, z)
				]) {
					rotate([
						0,
						-90,
						0
					]) {
						rod(
							r = rod/2,
							h = 100,
							id = 11+z
						);
						//Rod tensioner
						translate([0,0,-rod/2]) {
							e() cylinder(
								r = bolt/2,
								h = rod/2
							);
						}
						translate([0,0,-rod/4]) {
							e() m_nut(r=bolt, id=-1);
						}
					}
				}
			}
		}
	}
	part(id + 1, "X-end idle middle") color(color_plastic) {
		difference() {
			union() {
				translate([
					-z_rods_pitch/2 - rod - bolt,
					1,
					-x_rod_pitch/2 - rod - bolt /2
				]) {
					cube([
						z_rods_pitch + rod*2.5 + bolt,
						11,
						x_rod_pitch + rod*2 + bolt
					]);
				}
			}
			rotate([-90,45,0]) {
				if(motor) {
					e() nema_faceplate_drill(motor, scale=2);
				}
			}
			//bolts
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						space(z_rods_pitch + rod + bolt*1.5, x),
						0,
						space(x_rod_pitch + rod + bolt*1.5, y),
					]) {
						rotate([-90,0,0]) {
							cylinder(
								r = bolt/2,
								h = 100
							);
						}
					}
				}
			}
			//bearing
			rotate([-90,0,0]) {
				cylinder(
					r = rod/2,
					h = 100
				);
			}
			//Belt gap
			translate([
				-z_rods_pitch/2 -rod - bolt -.1,
				13 + 1 - rod - .1,
				-x_rod_pitch/2 + rod
			]) {
				cube([
					z_rods_pitch + .2 + rod + bolt,
					rod/2 + rod,
					x_rod_pitch - rod*2
				]);
			}
			//Rod holders
			for(z=[0:1]) {
				translate([
					+z_rods_pitch/2 + rod * 1.5,
					13,
					space(x_rod_pitch, z)
				]) {
					rotate([
						0,
						-90,
						0
					]) {
						e() rod(
							r = rod/2,
							h = 100,
							id = 11+z
						);
						e() rod(
							r = rod/2 + 1,
							h = rod/2 + 1,
							id = 11+z
						);
					}
				}
			}
			//liner bearing holder
			for(z=[0:1]) {
				translate([
					z_rods_pitch/2,
					0,
					- linear_bearing_length(rod)/2 + space(linear_bearing_length(rod) + rod, z)
				]) {
					cylinder(
						r = (rod + linear_bearing_offset(rod))/2 + .1,
						h = linear_bearing_length(rod) + .1
					);
				}
			}
			//nut holder
			translate([
				-z_rods_pitch/2,
				0,
				- rod*.8/2 - (motor ? -16 : 16)
			]) {
				m_nut(rod + 0.1, id=-1);
			}
			//Rod gaps
			translate([
				z_rods_pitch/2,
				0,
				-x_rod_pitch/2 - rod
			]) {
				e() cylinder(
					r = rod/2 + 1.5,
					h = 100
				);
			}
			translate([
				-z_rods_pitch/2,
				0,
				-x_rod_pitch/2 - rod
			]) {
				e() cylinder(
					r = rod/2 + 1.5,
					h = 100
				);
			}
		}
	}
	part(id + 2, "X-end idle front") color(color_plastic) {
		difference() {
			union() {
				translate([
					-z_rods_pitch/2 - rod - bolt,
					-rod,
					-x_rod_pitch/2 - rod -bolt/2
				]) {
					cube([
						z_rods_pitch + rod*2.5 + bolt,
						rod-1,
						x_rod_pitch + rod*2 + bolt
					]);
				}
			}
			rotate([90,45,0]) {
				if(motor) {
					e() nema_faceplate_drill(motor);
				}
			}
			//bolts
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						space(z_rods_pitch + rod + bolt*1.5, x),
						0,
						space(x_rod_pitch + rod + bolt*1.5, y),
					]) {
						rotate([90,0,0]) {
							cylinder(
								r = bolt/2,
								h = 100
							);
						}
					}
				}
			}
			//bearing
			rotate([90,0,0]) {
				cylinder(
					r = rod/2,
					h = 100
				);
			}
			//liner bearing holder
			for(z=[0:1]) {
				translate([
					z_rods_pitch/2,
					0,
					- linear_bearing_length(rod)/2 + space(linear_bearing_length(rod) + rod, z)
				]) {
					cylinder(
						r = (rod + linear_bearing_offset(rod))/2 + .1,
						h = linear_bearing_length(rod) + .1
					);
				}
			}
			//nut holder
			translate([
				-z_rods_pitch/2,
				0,
				- rod*.8/2 - (motor ? -16 : 16)
			]) {
				m_nut(rod + 0.1, id=-1);
			}
			//Rod gaps
			translate([
				z_rods_pitch/2,
				0,
				-x_rod_pitch/2 - rod
			]) {
				e() cylinder(
					r = rod/2 + 1.5,
					h = 100
				);
			}
			translate([
				-z_rods_pitch/2,
				0,
				-x_rod_pitch/2 - rod
			]) {
				e() cylinder(
					r = rod/2 + 1.5,
					h = 100
				);
			}
		}
	}
}