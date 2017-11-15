/*
 * x-carriage bowden mount
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../config.scad>
use <../vitamin/j_head.scad>

bowden_mount();

if(preview==2) {
	for(i=[0:1]) {
		translate([
			0,
			-17/2 + 17*i,
			0
		]) {
			bowden_mount_nut();
		}
	}
} else {
	for(i=[0:1]) {
		translate([
			20,
			-18/2 + 18*i,
			jhead_mount()[1] + 9
		]) {
			rotate([
				0,
				180,
				0
			]) {
				bowden_mount_nut();
			}
		}
	}
}

module bowden_mount_nut(
	pitch = 17,
	nut = 6,
	t = 1
) {
	height = jhead_mount()[1] + nut + t;
	translate([
		0,
		0,
		height - nut
	]) {
		difference() {
			cylinder(
				r = pitch/2 - .1,
				h = nut + t*2
			);
			e() screw(
				r = nut*1.8/2 + t,
				h = nut,
				pitch = 2
			);
			e() cylinder(
				r = nut/2,
				h = height*2
			);
		}
	}
}

module bowden_mount(
	pitch = 17,
	nut = 6,
	t = 1
) {
	height = jhead_mount()[1] + nut + t;
	//screw
	for(i=[0:1]) {
		translate([
			0,
			-pitch/2 + pitch*i,
			0
		]) {
			%jhead_mount_offset() {
				rotate([
					0,
					0,
					180*i
				]) {
					%jhead();
				}
			}
			%cylinder(
				r = nut/2,
				h = height*2
			);
			difference() {
				translate([
					0,
					0,
					height - nut
				]) {
					difference() {
						screw(
							r = nut*1.8/2 + t,
							h = nut,
							pitch = 2
						);
						e() m_nylock(nut);
					}
					%m_nylock(nut);
				}
			}
		}
	}
	//base
	difference() {
		union() {
			for(i=[0:1]) {
				translate([
					0,
					-pitch/2 + pitch*i,
					0
				]) {
					cylinder(
						r1 = jhead_mount()[0]/2 + 2*t,
						r2 = jhead_mount()[0]/2 + t,
						h = height - nut
					);
				}
			}
			//mount slot
			difference() {
				hull() {
					for(i=[0:1]) {
						translate([
							-pitch/2 + pitch*i,
							0,
							0
						]) {
							cylinder(
								r = mounting_bolt,
								h = height - nut
							);
						}
					}
				}
				for(i=[0:1]) {
					translate([
						-pitch/2 + pitch*i,
						0,
						0
					]) {
						e() cylinder(
							r = mounting_bolt/2,
							h = height - nut
						);
						rotate([
							0,
							0,
							180*(1 - i)
						]) {
							translate([
								0,
								-mounting_bolt/2,
								0
							]) {
								e() cube([
									mounting_bolt * 3,
									mounting_bolt,
									height - nut
								]);
							}
						}
					}
				}
			}
		}
		for(i=[0:1]) {
			translate([
				0,
				-pitch/2 + pitch*i,
				0
			]) {
				e() cylinder(
					r = nut/2,
					h = height
				);
				e() jhead_mount_offset() {
					rotate([
						0,
						0,
						180*i
					]) {
						jhead();
					}
				}	
			}
		}
	}
	//print support
	for(i=[0:1]) {
		translate([
			0,
			-pitch/2 + pitch*i,
			0
		]) {
			//print support
			difference() {
				cylinder(
					r = nut/2,
					h = jhead_mount()[1]
				);
				e() cylinder(
					r = nut/2 - .2,
					h = jhead_mount()[1]
				);
			}
		}
	}
}
