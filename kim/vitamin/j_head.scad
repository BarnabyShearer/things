/*
 * j-head
 *
 * Copyright Reifsnyderb, <b@Zi.iS>
 *
 * License GPLv2
 */

include <../config.scad>

jhead();

function jhead_mount() = [15.875, 4.76];

module jhead_mount_offset() {
	translate([
		0,
		0,
		-(50 + (8.125 - 2.01)/2 * sin(118) + 1 + 8.225 + 2) + 4.76
	]) {
		child(0);
	}
}

module jhead(
	nozzle_version = 4, // Not implemented!
	holder_version = 4, // Not implemented!
) {
	echo("J-Head Nozzle:", nozzle_version, " Holder:", holder_version);
	nozzle_length = (8.125 - 2.01)/2 * sin(118);

	color([.7,.7,0]) {
		difference() {
			union() {
				cylinder(
					r = 2.01/2,
					h = 26.035
				);
				cylinder(
					r1 = 0,
					r2 = 8.125/2,
					h = nozzle_length
				);
				translate([
					0,
					0,
					nozzle_length
				]) {
					cylinder(
						r = 8.125/2,
						h = 26.035 - nozzle_length
					);
				}
				translate([
					-12.7/2,
					-15.88+5.08+0.254,
					nozzle_length + 1
				]) {
					cube([
						12.7,
						15.88,
						8.225
					]);
				}
			}
			translate([
				-12.7/2 -1,
				-15.88+5.08+0.254 + 3.81,
				nozzle_length + 1 + 4.14,
			]) {
				rotate([
					0,
					90,
					0
				]) {
				cylinder(
						r = 5.944/2,
						h = 17
					);
				}
			}
			translate([
				0,
				0,
				-0.001
			]) {
				cylinder(
					r = 0.35/2,
					h = 30
				);
			}
			translate([
				0,
				0,
				26.035 - 23.11 - nozzle_length
			]) {
				cylinder(
					r1 = 0,
					r2 = 8.125/2,
					h = nozzle_length
				);
			}
		translate([
				0,
				0,
				26.035 - 23.11 -0.001
			]) {
				cylinder(
				r = 6.5/2,
					h = 26.035 - nozzle_length
				);
			}
			translate([
				5,
				3,
				nozzle_length + 1 + 3
		]) {
				rotate([
					-90,
					0,
					0,
				]) {
				cylinder(
						r = 2/2,
						h = 3
					);
				}
			}
		}
	}
	color([0,0,0]) {
		difference() {
			union() {
				translate([
					0,
					0,
					nozzle_length + 1 + 8.225 + 2,
				]) {
					difference() {
						cylinder(
							r = 15.875/2,
							h = 50
						);
						translate([
							0,
							0,
							50 - 4.76 - 4.64
						]) {
							cylinder(
								r = 100,
								h = 4.64
							);
						}
					}
					cylinder(
						r = 12/2,
						h = 50
					);
				}
			}
			translate([
				0,
				0,
				nozzle_length + 1 + 8.225 + 1,
			]) {
				cylinder(
					r = 6.5/2,
					h = 52
				);
			}
		}
	}
	
	//PTFE Liner
	color([.7,0,0]) {
		difference() {
			translate([
				0,
				0,
				nozzle_length + 1,
			]) {
				cylinder(
					r = 6.35/2,
					h = 8.225 + 2 + 50 -5.08 
				);
			}
			translate([
				0,
				0,
				nozzle_length ,
			]) {
				cylinder(
					r = 3.175/2,
					h =8.225 + 2 + 50 -5.08 + 2
				);
			}
		}
	}
	
	//Retaining screew
	color([0,0,0]) {
		difference() {
			translate([
				0,
				0,
				nozzle_length + 1 + 8.225 + 2 + 50 -5.08,
			]) {
				cylinder(
					r = 6.5/2,
					h = 5.08
				);
			}
			translate([
				0,
				0,
				nozzle_length + 1 + 8.225 + 2 + 50 -5.08 -.001,
			]) {
				cylinder(
					r = 3.175/2,
					h = 7
				);
			}
		}
	}
	translate([
		0,
		0,
		nozzle_length + 1 + 8.225 + 2 + 50- 4.76 - 4.64 //Origin at mount
	]) {
		child();
	}
}