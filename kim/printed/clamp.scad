/*
 * clamp
 *
 * stronger clamp which tightens against both rods to improve frame rigidity.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 *
 * Inspired by Michel Pollet <buserror@gmail.com>
 */

include <../config.scad>;
use <../vitamin/rod.scad>;

if(preview==1) {
	translate([
		0,
		0,
		-125
	]) {
		threaded_rod();
	}
	rotate([
		90,
		0,
		0
	]) {
		translate([
			8,
			0,
			-125
		]) {
			rod();
		}
	}
	clamp();
} else {
	translate([
		-5,
		10,
		8
	]) {
		rotate([
			0,
			-90,
			0
		]) {
			_clamp0();
		}
	}
	_clamp1();
}

module clamp(
	rod = 8,
	thickness = 4
) {
	rotate([
		0,
		180,
		0,
	]) {
		translate([
			0,
			0,
			rod
		]) {
			m_washer(rod) {
				m_nut(rod);
			}
		}
	}
	translate([
		0,
		0,
		rod
	]) {
		m_washer(rod) {
			m_nut(rod);
		}
	}
	color(color_print) {
		translate([
			rod,
			-rod,
			0
		]) {
			rotate([
				-90,
				-90,
				0
			]) {
				_clamp0(
					rod = rod,
					thickness = thickness
				);
			}
		}
		translate([
			-rod,
			rod,
			rod
		]) {
			rotate([
				0,
				180,
				180
			]) {
				_clamp1(
					rod = rod,
					thickness = thickness
				);
			}
		}
	}
}

module _clamp0(
	rod = 8,
	thickness = 4
) {
	height=rod*1.5+thickness;
	width=rod+thickness*2;
	difference() {
		union() {

			translate([
				-thickness-rod/2,
				-height,
				0
			]) {
				cube([
					thickness*2+rod,
					rod+thickness,
					width,
				]);
				cube([
					rod/2+thickness*1.25,
					rod*2+thickness*2.5,
					width,
				]);

			}		
		}

		//Rod1
		translate([
			0,
			0,
			-1
		]) {
			cylinder(
				r=rod/2,
				h=width+2
			);
		}
		rotate([
			0,
			0,
			-45
		]) {
			translate([
				0,
				-rod/2,
				-1
			]) {
				cube([
					width+2,					
					rod,
					height+2,
				]);
			}
		}

		//Rod2	
		translate([
			-rod-thickness-1,
			-rod,
			thickness+rod/2
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r=rod/2,
					h=rod*2+thickness*2+2
				);
			}
		}
		translate([
			-rod/2-thickness-1,
			-rod*1.5,
			thickness+rod/2
		]) {
			rotate([
				-10,
				0,
				0
			]) {
				cube([
					width+2,					
					rod,
					height,
				]);
			}
		}
	}
}

module _clamp1(
	rod = 8,
	thickness = 4
) {
	height=rod*2+thickness-.01;
	width=rod+thickness*2-0.1;

	difference() {

		intersection() {
			cube([
				height,
				width,
				width
			]);

			translate([
				rod*1.5+thickness-1,
				0,
				thickness+rod/2-1
			]) {
				rotate([
					0,
					135,
					0
				]) {
					translate([
						0,
						0,
						-rod/2
					]) {
						cube([
							width+2,					
							width,
							rod,
						]);
					}
				}
			}
		}

		//Rod1
		translate([
			rod/2+thickness,
			rod/2+thickness,
			-1
		]) {
			cylinder(
				r=rod/2,
				h=width+2
			);
		}

		translate([
			thickness-rod/2,
			thickness,
			-1
		]) {
			cube([
				rod,
				rod,
				width
			]);
		}

		//Printing
		translate([
			thickness+rod/2,
			thickness,
			thickness+rod/2-2
		]) {
			cube([
				rod,
				rod,
				width
			]);
		}

		//Rod2	
		translate([
			rod*1.5+thickness,
			width+1,
			thickness+rod/2
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r=rod/2,
					h=rod+thickness*2+2
				);
			}
		}
	}
}