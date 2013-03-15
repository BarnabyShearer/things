/*
 * Eyes
 *
 * This connects a Galaxy Nexus and the lenses from a stereoscopic 35mm slide viewer.
 * https://play.google.com/store/apps/details?id=com.uscict.fov2go_minus_lab
 * 
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>;

difference() {
	hull() {
		translate([
			-1.2,
			0,
			0
		]) {
			scale([
				1.1,
				1.07,
				1
			]) {
				linear_extrude(
					height = 40
				) {
					import(file="galaxy_nexus.dxf");
				}
			}
		}
		translate([
			7,
			0,
			0
		]) {
			scale([
				1.1,
				1.07,
				1
			]) {
				linear_extrude(
					height = 40
				) {
					import(file="galaxy_nexus.dxf");
				}
			}
		}
	}
	translate([
		0,
		0,
		1.1
	]) {
		scale([
			1.07,
			1.02,
			1
		]) {
			linear_extrude(
				height = 68
			) {
				import(file="galaxy_nexus.dxf");
			}
		}
	}
	translate([
		-2.7,
		0,
		6
	]) {
		cube([
			5,
			57,
			57,
		]);
		translate([
			0,
			57/2,
			57/2,
		]) {
			rotate([
				0,
				90,
				0
			]) {
					cylinder(
					r=45/2,
					h=30
				);
			}
		}
	}
	translate([
		-1.3,
		-59,
		6
	]) {
		rotate([
			0,
			0,
			2
		]) {
			cube([
				5.4,
				57,
				57,
			]);
		}
		translate([
			0,
			57/2,
			57/2,
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r=45/2,
					h=30
				);
			}
		}
	}
	hull() {
		translate([
			-20,
			69-18,
			35+1.1,
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r=16/2,
					h=15
				);
			}
		}
		translate([
			-20,
			69-18-10,
			35+1.1,
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r=16/2,
					h=15
				);
			}
		}
	}
	hull() {
		translate([
			-6.5,
			74-35,
			-1,
		]) {
			cylinder(
				r=5/2,
				h=15
			);
		}
		translate([
			-6.5,
			74-35-9,
			-1,
		]) {
			cylinder(
				r=5/2,
				h=15
			);
		}
	}
}		
