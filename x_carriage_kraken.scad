/*
 * kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/linear_bearing.scad>
use <scadhelper/vitamins/2d.scad>
use <scadhelper/bend.scad>
use <kraken.scad>
use <../tvrrug/tvprusa/SCADs/x-end-idler.scad>

projection()
x_carriage();

module x_carriage(
	rod = 8,
	nozzel_height = 37,
	x_rod_pitch = 50,
	X = 0,
	Z = 0,
	material = [
		8,
		"Acrylic",
		[color_steel[0], color_steel[1], color_steel[2], .5]
	],
    belt_width=5,
    belt_thickness=2.5,
    belt_height = 24,
    belt_offset = 35,
    pully = 14,
    pully_length=20,


	id = 1
) {

	translate([
				-150 + X ,
				-20 ,
				nozzel_height - 3
	]) {	

		//Placeholders
		%for(r=[0:1]) {

			//X-Rods
			translate([
				0,
				-x_rod_pitch/2+x_rod_pitch*r,
				0
			]) {
				rotate([
					0,
					90,
					0,
				]) {
					cylinder(
						r = rod/2,
						h =100
					);
				}
			}
			translate([
				7,
				-belt_offset,
				belt_height
			])
				rotate([90,0,0]) cylinder(r=pully/2, h = 10);

			//Belt
			translate([
				0,
				-belt_offset - belt_width-2,
				-belt_thickness/2 + belt_height + space(pully + belt_thickness, r)
			]) {
				cube([
					100,
					belt_width,
					belt_thickness,
				]);
			}
		}
		
		*translate([0,0,-9]) rotate(90) xendidler();
	}

	//Hotend
	%translate([
		-110 + X,
		-20,
		0,
	]) {
		*kraken(id) {
			bend([0, 500, -Z], 1000) water_tube(1,id + 24);
			bend([0, 500, -Z], 1000) water_tube(1, id + 25);
			bend([-100-X, 0, 0], 400) bowden(1,id + 26);
			bend([-100-X, 0, 0], 400) bowden(1,id + 27);
			bend([300-X, 0, 0], 400) bowden(1,id + 28);
			bend([300-X, 0, 0], 400) bowden(1,id + 29);
		}
	}
	//Y bearings
	%for(z=[0:1]) {
		for(x=[0:1]) {
			translate([
				-110 + X + z*space(40, x),
				-20 + space(x_rod_pitch, z),
				nozzel_height - 3
			]) {
				rotate([
					0,
					90,
					0
				]) {
					linear_bearing(
						size = rod,
						id = id + 16 + z
					);
				}
			}
		}
	}
	translate([
		-110 + X,
		-25,
		nozzel_height +2
	]) {
		2d(
			size = [80, 85],
			material = material,
			id = id + 17
		) union() translate([0, 5, 0]) {

			translate([-10,-belt_offset-belt_width-2,0]) kerf_cube([
				belt_thickness*2,
				belt_width+2,
				material[0]
			]);
			translate([10-belt_thickness*2,-belt_offset-belt_width-2,0]) kerf_cube([
				belt_thickness*2,
				belt_width+2,
				material[0]
			]);
			for(x=[0:1]) for(y=[0:1]) {
				translate([
					space(34, x),
					space(29, y),
					0
				]) {
					kerf_cylinder(
						r=3/2,
						h = material[0] 
					);
				}
			}
			translate([0,-5,0])
			cube([100,10,material[0]]);
			hull() {
					translate([
						0,
						15,
						0
					]) {
						kerf_cylinder(
							r=5,
							h = material[0] 
						);
					}				
				for(x=[0:1]) for(y=[0:1]) {
					translate([
						space(20, x),
						space(20, y),
						0
					]) {
						kerf_cylinder(
							r=5,
							h = material[0] 
						);
					}
				}
				for(x=[0:1]) {
					translate([
						space(17, x),
						0,
						0
					]) {
						kerf_cylinder(
							r=10,
							h = material[0] 
						);
					}
				}
			}
			for(z=[0:1]) {
				for(x=[0:1]) {
					translate([
						 z*space(40, x) - linear_bearing_length(rod)/2,
						 space(x_rod_pitch, z)-6,
						0
					]) {
						cube([linear_bearing_length(rod),12,material[0]]);
					}
				}
			}
	
			for(z=[0:1]) {
				for(x=[0:1]) {
					translate([
						 x*space(105, x) -30,
						 x_rod_pitch/2+space(20,z)-2.5/2,
						0
					]) {
						cube([5,2,material[0]]);
					}
				}
			}
					translate([
						 15,
						 -20,
						0
					]) {
						cube([5,2,material[0]]);
					}
					translate([
						 -20,
						 -35,
						0
					]) {
						cube([5,2,material[0]]);
					}
		}
	}
}