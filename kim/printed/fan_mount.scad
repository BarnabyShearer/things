/*
 * fan mount
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../config.scad>
use <../vitamin/fan.scad>

if(preview==1) {
	%fan();
	fan_mount();
} else {
	rotate([
		90,
		0,
		0,
	]) {
		fan_mount();
	}
}

module fan_mount(
	size = fan40,
	thickness = 6
) {
	color([0,.5,0]) {
		translate([
			-size[2]/2,
			size[0]/2,
			size[1]
		]) {
			rotate([
				0,
				-90,
				90
			]) {
				rotate([
					0,
					0,
					-135,
				]) {
					translate([
						-13,
						-9.4-1.5,
						0
					]) {
						difference() {
							cube([
								10.5,
								9,
								(size[0]-size[2])
							]);
							translate([
								-1,
								(9-thickness)/2,
								-1
							]) {
								cube([
									10,
									thickness,
									(size[0]-size[2])+2
								]);
							}
						}
					}
				}
			
				translate([
					0,
					0,
					(size[0]-size[2])/2
				]) {
					difference() {
						translate([
							0,
							-(size[0]-size[2])/2,
							-(size[0]-size[2])/2,
						]) {
							cube([
								2,
								(size[0]-size[2])+1,
								(size[0]-size[2])
							]);
						}
						rotate([
							0,
							90,
							0
						]) {
							//pilot
							translate([0,0,-1]) {
								cylinder(
									r = 3.2/2,
									h = 5
								);
							}						
						}
					}
				}
			}
		}
	}
}