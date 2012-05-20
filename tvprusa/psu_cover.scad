/*
 * TVRRUG PSU cover (SUNPOWER FDP3-350A)
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;

translate([
	0,
	-10,
	0,
]) {
	cable_clamp();
}

psu();

module cable_clamp(
	mains = 6.6/2,
	bolt = 2.8/2,
) {
	rotate([
		90,
		0,
		0
	]) {
		difference() {
			//Support for mains cable
			translate([
				0,
				0,
				0,
			]) {
				cube([
					mains*2+bolt*8,
					mains*2,
					bolt*4,
				]);
			}
		
			//Hole for mains cable
			translate([
					0+(mains*2+bolt*8)/2,
				mains*2,
				-1,
			]) {
				cylinder(
					r=mains,
					h=bolt*4+2
				);
			}
			//Holes for cable clamp bolts
			translate([
				bolt*2,
				mains*2+1,
				bolt*2,
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r=bolt,
						h=mains*2+2
					);
				}
			}
			translate([
				bolt*6 +mains*2,
				mains*2+1,
				bolt*2,
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r=bolt,
						h=mains*2+2
					);
				}
			}
		}
	}
}

module psu(
	width = 113.5,
	height = 50,
	overlap = 10,
	extend = 20,
	wall = 2,
	wire = 2.8/2,
	wires = 4,
	bolt = 2.8/2,
	mains = 6.6/2,
	vents = 14,
	looseness = .1,
) {
	in_width = width + 2*looseness;
	in_height = height + 2*looseness;
	in_length = extend + overlap;
	out_width = in_width + 2*wall;
	out_height = in_height + 2*wall;
	out_length = in_length + wall;
	offset = wall + looseness;

	difference() {
		union() {	

			//Case
			difference() {
				cube([
					out_width,
					out_height,
					max(wall+extend+28,out_length)
				]);
				translate([
					wall,
					wall,
					wall
				]) {
		
					cube([
						in_width,
						in_height,
						max(wall+extend+28,out_length)
					]);
				}
				translate([
					-1,
					-1,
					out_length
				]) {
		
					cube([
						out_width+2,
						out_height+1-wall*3,
						28
					]);
				}


				//vents
				for(i=[0:vents-1]) {
					translate([
						offset+in_height/6+i*(in_width-in_height/3-2.5)/(vents-1),
						offset+in_height/2,
						-1
					]) {
						cube([
							2.5,
							in_height/3,
							wall+2
						]);
						translate([
							2.5/2,
							0,
							0
						]) {
							cylinder(
								r=2.5/2,
								h=wall+2
							);
						}
						translate([
							2.5/2,
							in_height/3,
							0
						]) {
							cylinder(
								r=2.5/2,
								h=wall+2
							);
						}
					}
				}
			}	

			//Support for mains cable
			translate([
				offset + 10,
				0,
				0,
			]) {
				cube([
					mains*2+bolt*8,
					wall+10+mains,
					wall+bolt*4,
				]);
			}
		}

		//Hole for mains cable
		translate([
			offset + 10 + (mains*2+bolt*8)/2,
			wall+10+mains,
			-1,
		]) {
			cylinder(
				r=mains,
				h=wall+bolt*4+2
			);
		}

		//Holes for power wires
		for(i=[0:wires-1]) {
			translate([
				offset + width-26-10*i,
				wall+10+mains, //line up with mains
				-1,
			]) {
				cylinder(
					r=wire,
					h=wall+2
				);
			}
		}

		//Holes for cable clamp bolts
		translate([
			offset + 10 +  bolt*2,
			wall+10+mains+1,
			wall+bolt*2,
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r=bolt,
					h=wall+10+mains+2
				);
			}
		}
		translate([
			offset + 10 +  bolt*6 +mains*2,
			wall+10+mains+1,
			wall+bolt*2,
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r=bolt,
					h=wall+10+mains+2
				);
			}
		}

	}
}



