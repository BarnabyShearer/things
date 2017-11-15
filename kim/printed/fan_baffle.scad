/*
 * fan baffle
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../config.scad>;
use <../vitamin/fan.scad>;

if(preview==1) {
	%fan();
	fan_baffle();
} else {
	rotate([
		0,
		180,
		0
	]) {
		fan_baffle();
	}
}

module fan_baffle(
	size = fan40
) {
	color([0,.5,0]) {
		translate([
			10,
			size[0]/2,
			size[1]*2
		]) {
			rotate([
				0,
				-90,
				90
			]) {
				linear_extrude(height = size[0]) {
					polygon(points=[
						[0,10],
						[10,0],
						[10,20],
					]);
				}
				translate([
					-10,
					-size[2]/2+10,
					0
				]) {
					cube([
						20,
						size[2]/2,
						1
					]);
				}
				translate([
					-10,
					-size[2]/2+10,
					size[0] -1
				]) {
					cube([
						20,
						size[2]/2,
						1
					]);
				}
				translate([
					-10,
					-size[0]/2+10,
					(size[0]-size[2])/2
				]) {
					cube([
						20,
						1,
						size[2]
					]);
				}
				for(i=[0:1]) {
					translate([
						-10,
						10-size[2]/2,
						(size[0]-size[2])/2 + size[2]* i
					]) {
						rotate([
							0,
							90,
							0
						]) {
							difference() {
								cylinder(
									r = (size[0]-size[2])/2,
									h = 20
								);
								//pilot
								translate([0,0,-1]) {
									cylinder(
										r = 2.9/2,
										h = 22
									);
								}						
							}
						}
					}
				}
			}
		}
	}
}
