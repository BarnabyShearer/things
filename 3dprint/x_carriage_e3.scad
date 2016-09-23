/*
 * kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/linear_bearing.scad>
use <scadhelper/vitamins/hardware.scad>
use <scadhelper/vitamins/2d.scad>
use <scadhelper/bend.scad>
use <e3.scad>
use <e3_fan.scad>

x_carriage();

module x_carriage(
	rod = 8,
	nozzel_height = 50,
	nozzel_depth = 23,
	y_rod_depth = 13,
	x_rod_pitch = 50,
	material = [
		6,
		"Acrylic",
		[.75,.75,.75,.75]
	],
	bolt = 3,
	X = 0,
	Z = 0,
	id = 0
) {

	//Hotend
	translate([
		-110 + X,
		-nozzel_depth + y_rod_depth,
		0,
	]) {
		for(y=[0:1]) {
			translate([
				0,
				nozzel_depth + material[0]/2 + space(rod + material[0] + 1, y),
				nozzel_height
			]) {
				rotate([90,0,0]) {
					2d(
						[
							linear_bearing_length(rod) + material[0]*2,
							x_rod_pitch + (rod + linear_bearing_offset(rod))/2 + material[0]*2,
						],
						drill = [bolt, bolt, bolt, bolt],
						material,
						id = id
					) union() {
						kerf_cube([
							linear_bearing_length(rod) - material[0]*1.5,
							x_rod_pitch,
							material[0] * 2
						], center = true);
							
						for(z=[0:1]) {
							translate([
								space(linear_bearing_length(rod) + material[0]*2 - bolt*2, z),
								10,
								0
							]) e() kerf_cylinder(r = bolt/2, h = material[0]);
							translate([0, space(x_rod_pitch, z), 0]) kerf_cube([
								linear_bearing_length(rod),
								pow(pow(rod + linear_bearing_offset(rod), 2) - pow(rod + 1, 2) , 0.5),
								material[0]*2
							], center = true);
						}
					}
				}
			}
		}

		translate([
			0,
			0,
			80
		]) {
			rotate([0,180,0]) m_nylock(6, id = id + 2);
		}

		color(color_plastic) part(id + 3, "back") {
			difference() {
				translate([
					-linear_bearing_length(rod)/2 - material[0],
					0,
					57
				]) {
					cube([
						linear_bearing_length(rod) + material[0]*2,
						nozzel_depth - rod/2 - 1/2 - material[0],
						27.75
					]);
				}
				for(x=[0:1]) {
					for(z=[0:1]) {
						translate([
							space(linear_bearing_length(rod) + material[0]*2 - bolt*2, x),
							50,
							57 + 27.75/2 + space(27.75 - bolt*2, z)
						]) rotate([90,0,0]) e() kerf_cylinder(r = bolt/2, h = 100);
					}
				}
				cylinder(r = 6/2, h=100);
				cylinder(r = 16/2, h = 60);
				cylinder(r = 12/2, h = 69.25);
				translate([0,0,65.25]) cylinder(r = 16/2, h = 4);
				translate([
					0,
					0,
					80
				]) {
					rotate([0,180,0]) m_nylock(6+.1, id = -1);
				}
			}
		}

		rotate(180) E3(id + 4);
		E3_fan(id + 5);
	
		//Y bearings
		for(z=[0:1]) {
			translate([
				0,
				nozzel_depth,
				nozzel_height + space(x_rod_pitch, z)
			]) {
				rotate([
					0,
					90,
					0
				]) {
					linear_bearing(
						size = rod,
						id = id + 6 + z
					);
				}
			}
		}		
	}
}