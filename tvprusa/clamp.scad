/*
 * TVRRUG clamp
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;
m8 = 8 / 2;
m8_washer = 15/2;

clamp();

translate([
	-11,
	10,
	0
]) {
	
	clamp2();
}

module clamp(
	rod = m8,
	thickness = 4
) {
	height=rod*3+thickness;
	width=rod*2+thickness*2;

	difference() {
		union() {

			translate([
				-thickness-rod,
				-height,
				0
			]) {
				cube([
					thickness*2+rod*2,
					height,
					width,
				]);
			}
			cylinder(
				r=rod+thickness,
				h=width
			);			
		}

		//Rod1
		translate([
			0,
			0,
			-1
		]) {
			cylinder(
				r=rod,
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
				-rod,
				-1
			]) {
				cube([
					width+2,					
					rod*2,
					height+2,
				]);
			}
		}

		//Rod2	
		translate([
			-rod-thickness-1,
			-rod*2,
			thickness+rod
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r=rod,
					h=rod*2+thickness*2+2
				);
			}
		}
		translate([
			-rod-thickness-1,
			-rod*3,
			thickness+rod
		]) {
			rotate([
				-10,
				0,
				0
			]) {
				cube([
					width+2,					
					rod*2,
					height,
				]);
			}
		}

	}
}

module clamp2(
	rod = m8,
	thickness = 4
) {
	height=rod*4+thickness-.01;
	width=rod*2+thickness*2-0.1;

	difference() {

		intersection() {
			cube([
				height,
				width,
				width
			]);

			translate([
				rod*3+thickness-1,
				0,
				thickness+rod-1
			]) {
				rotate([
					0,
					135,
					0
				]) {
					translate([
						0,
						0,
						-rod
					]) {
						cube([
							width+2,					
							width,
							rod*2,
						]);
					}
				}
			}
		}

		//Rod1
		translate([
			rod+thickness,
			rod+thickness,
			-1
		]) {
			cylinder(
				r=rod,
				h=width+2
			);
		}

		translate([
			thickness-rod,
			thickness,
			-1
		]) {
			cube([
				rod*2,
				rod*2,
				width
			]);
		}

		//Printing
		translate([
			thickness+rod,
			thickness,
			thickness+rod-2
		]) {
			cube([
				rod*2,
				rod*2,
				width
			]);
		}

		//Rod2	
		translate([
			rod*3+thickness,
			width+1,
			thickness+rod
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r=rod,
					h=rod*2+thickness*2+2
				);
			}
		}
	}
}
