/*
 * Feed
 *
 * Copyright 2013 <b@Zi.iS>, <richard.ibbotson@btinternet.com>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/2d.scad>
use <scadhelper/vitamins/rod.scad>
use <drive.scad>

feed();

module feed(
	rod = 8,
	size = [
		50,
		50,
		50
	],
	material = [
		6,
		"STEEL",
		[color_steel[0], color_steel[1], color_steel[2], .5]
	],
	bolt = 3,
	t = $t,
	id = 0
) {
	translate([
		0,
		0,
		-material[0] - t*size[2],
	] * preview) {
		2d(
			[
				size[0],
				size[1]
			],
			material = material,
			id = id + 1
		) {
			kerf_cylinder(
				r = rod/2,
				h = material[0]
			);
		}
		translate([
			0,
			0,
			material[0]
		] * preview) {
			rotate([
				180,
				0,
				0
			] * preview) {
				threaded_rod(
					r = rod/2,
					h = size[2] + 16.5,
					id = id + 2
				);
			}
		}
	}
	translate([
		0,
		0,
		-(size[2] + 16.5+5.7+material[0]*3)
	] * preview) {
		2d(
			[
				size[0] + material[0]*2,
				size[1]
			],
			material = material,
			id = id + 3
		) {
			union() {
				kerf_cylinder(
					r = rod/2 + 1,
					h = material[0]	
				);
				translate([
					0,
					0,
					material[0]/2
				]) {
					kerf_cylinder(
						r = 24/2,
						h = material[0]/2
					);
				}
				translate([
					0,
					0,
					material[0]/2 + 2
				]) {
					kerf_cylinder(
						r = 25/2,
						h = material[0]/2
					);
				}
				translate([
					size[0]/2 + material[0] - 16,
					-10,
					0
				]) {
					kerf_cube([
						16.01,
						20,
						 material[0]
					]);
				}
			}
		}
		translate([
			0,
			0,
			material[0]/2
		] * preview) {
			drive(
				rod = rod,
				id = id + 3
			) {
				if($children>0) for (i = [0 : $children-1]) child(i);
			}
		}
		translate([
			0,
			0,
			16.5+5.7+material[0]
		] * preview) {
			2d(
				[
					size[0] + material[0]*2,
					size[1]
				],
				material = material,
				drill = [bolt, bolt, bolt, bolt],
				id = id + 8
			) {
				union() {
					kerf_cylinder(
						r = rod/2 + 1,
						h = material[0]	
					);
					kerf_cylinder(
						r = 15/2,
						h = 4
					);
				}
			}
		}
		translate([
			-size[0]/2 - material[0],
			0,
			16.5+5.7+material[0]*2.5+ size[2]/2
		] * preview) {
			rotate([
				0,
				90,
				0
			] * preview) {
				2d(
					[
						size[2] + material[0],
						size[0]
					],
					material = material,
					id = id + 9
				) cube(0);
			}
		}
		translate([
			size[0]/2,
			0,
			16.5+5.7+material[0]*2.5+ size[2]/2
		] * preview) {
			rotate([
				0,
				90,
				0
			] * preview) {
				2d(
					[
						size[2] + material[0],
						size[0]
					],
					material = material,
					id = id + 10
				) cube(0);
			}
		}
		translate([
			0,
			-size[0]/2,
			(16.5+5.7+material[0]*3+ size[2])/2
		] * preview) {
			rotate([
					90,
				0,
				0
			] * preview) {
				2d(
					[
						size[1] + material[0]*2,
						size[2] + 16.5+5.7+material[0]*3
					],
					drill = [bolt, bolt, bolt, bolt],
					material = material,
					id = id + 11
				) {
					union() {
						for(x=[-1,1]) {
							translate([
								x * (size[1]/2 + material[0]/2),
								0,
								0
							]) {
								kerf_cylinder(
									r = bolt/2,
									h = material[0]
								);
							}
						}
					}
				}
			}
		}
		translate([
			0,
			size[0]/2 + material[0],
			(16.5+5.7+material[0]*3+ size[2])/2
		] * preview) {
			rotate([
				90,
				0,
				0
			] * preview) {
				2d(
					[
						size[1] + material[0]*2,
						size[2] + 16.5+5.7+material[0]*3
					],
					drill = [bolt, bolt, bolt, bolt],
					material = material,
					id = id + 12
				) {
					union() {
						for(x=[-1,1]) {
							translate([
								x * (size[1]/2 + material[0]/2),
								0,
								0
							]) {
								kerf_cylinder(
									r = bolt/2,
									h = material[0]
								);
							}
						}
					}
				}
			}
		}
	}
}
