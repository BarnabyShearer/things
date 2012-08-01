/*
 * TVRRUG extruder mount
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

/*
 * Serendipitously you can just run an M6 nyloc nut onto the end of the PTFE
 * tube for a perfect grip
 */

$fn = 60;
m8 = 8 / 2;
m4 = 4.2 /2;
m3 = 3.2 /2;
m6_nyloc = [
	11.28 /2,
	6
];

translate([
	0,
	20,
	0
]) {
	mount(offset=-8);
}
translate([
	0,
	-10,
	0
]) {
	clamp();
}

module clamp(
	rod=m8,
	bowden=5.6/2,
	bowden_nut = m6_nyloc,
	bolt = m3,
	t=3
) {
	cable_pitch =  bowden*2+bolt*4;
	width = bowden*2+bolt*8;
	length = rod*2+bolt*8;
	height = bowden_nut[0] + t;

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
			for(y=[0:1]) {
				translate([
					-cable_pitch/2+cable_pitch*x,
					-rod-bolt+rod*2*y+bolt*2*y,
					-1
				]) {
					cylinder(
						r=bolt,
						h=height+2
					);
				}
			}
		}

		//bowden nut	
		translate([
			0,
			bowden_nut[1]/2,
			height
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r = bowden_nut[0],
					h = bowden_nut[1],
					$fn = 6
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
	length=72,
	width=32,
	rod=m8,
	bolt = m4,
	offset = 8,
	pitch = 50,
	bowden=6.5/2,
	bowden_nut = m6_nyloc,
	bowden_bolt = m3,
) {
	height = rod+bowden_bolt*3;
	cable_clamp = bowden*2+bowden_bolt*8;
	cable_pitch =  bowden*2+bowden_bolt*4;
	rod_offset = -rod*2- bowden_nut[0]*sqrt(3)*.5;

	difference() {
		translate([
			-length/2-offset/2,
			-width/2,
			0
		]) {
			cube([
				length,
				width,
				height
			]);
		}

		//bowden nut	
		translate([
			0,
			0,
			height-bowden_nut[1]/2
		]) {
			cylinder(
				r = bowden_nut[0],
				h = bowden_nut[1],
				$fn = 6
			);
		}
		
		//cable
		translate([
			0,
			0,
			-1
		]) {
			cylinder(
				r = bowden,
				h = height+2
			);
		}


		translate([
			-cable_clamp/2 - bolt,
			0,
			-1
		]) {
			cube([
				cable_clamp+ bolt*2,
				width/2+1,
				height+2
			]);
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
				-cable_pitch/2 + cable_pitch*x,
				1,
				bowden_bolt*2
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r = bowden_bolt,
						h =width/2+2
					);
				}
			}
		}

		//Rod
		translate([
			-length/2-offset/2-1,
			rod_offset+rod,
			height
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r = rod,
					h = length+2
				);
			}
		}

		//Improve printability
		for(x=[0:1]) {
			translate([
				-bowden-bowden_bolt*3+cable_pitch*x,
				rod_offset,
				height-rod-bowden_bolt
			]) {
				cube([
					bowden_bolt*2,
					rod*2,
					rod*2+1
				]);
			}
		}
	}
}	
