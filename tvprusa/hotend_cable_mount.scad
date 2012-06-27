/*
 * TVRRUG hotend cable mount
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;
m8 = 8 / 2;
m4 = 4.2 /2;
m3 = 3.2 /2;

mount();

translate([
	0,
	-17,
	0
]) {
	clamp();
}

module clamp(
	bowden=6.5/2,
	bolt = m3,
	thickness = 2
) {
	cable_pitch =  bowden*2+bolt*4;
	length = bowden*2+bolt*8;
	width = bolt*4;
	height = bowden+thickness;

	difference() {
		translate([
			-length/2,
			-width/2,
			0
		]) {
			cube([
				length,
				width,
				height
			]);
		}

		//bolts
		for(x=[0:1]) {
			translate([
				-cable_pitch/2+cable_pitch*x,
				0,
				-1
			]) {
				cylinder(
					r=bolt,
					h=height+2
				);
			}
		}

		//cable
		translate([
			0,
			-width/2-1,
			height
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = bowden,
					h = width+2
				);
			}
		}
	}
}
module mount(
	bolt = m4,
	pitch = 50,
	bowden=6.5/2,
	bowden_bolt = m3,
	hotend = 17.5/2,
	hotend_length = 3.5,
	thickness = 2
) {
	height = thickness;
	width = bolt*4;

	difference() {
		union() {
			translate([
				-pitch/2,
				-width/2,
				0
			]) {
				cube([
					pitch,
					width,
					height
				]);
			}
			//mounting bolts
			for(x=[0:1]) {
				translate([
					-pitch/2 + pitch*x,
					0,
					0
				]) {
					cylinder(
						r = bolt+thickness,
						h =height
					);
				}
			}

			//Hotend
			translate([
				0,
				0,
				0
			]) {
				cylinder(
					r = hotend+thickness,
					h = hotend_length+thickness
				);
			}

			//cable
			translate([
				-bowden-bowden_bolt*4,
				0,
				0
			]) {
				cube([
					bowden*2+bowden_bolt*8,
					bowden+bowden_bolt,
					 hotend_length+thickness+bowden_bolt*4
				]);
			}
		}		

		//cable
		translate([
			0,
			0,
			-1
		]) {
			cylinder(
				r = bowden,
				h = hotend_length+thickness+bowden_bolt*4+2
			);
		}

		//Hotend
		translate([
			0,
			0,
			-1
		]) {
			cylinder(
				r = hotend,
				h = hotend_length+1
			);
		}

		//mounting bolts
		for(x=[0:1]) {
			translate([
				-pitch/2 + pitch*x,
				0,
				-1
			]) {
				cylinder(
					r = bolt,
					h =height+2
				);
			}
		}


		//Cable bolts
		for(x=[0:1]) {
			translate([
				-bowden-bowden_bolt*2 + (bowden_bolt*4+bowden*2)*x,
				-1,
				 hotend_length+thickness+bowden_bolt*2
			]) {
				rotate([
					-90,
					0,
					0
				]) {
					cylinder(
						r = bowden_bolt,
						h =bowden+thickness+2
					);
				}
			}
		}

	}
}	