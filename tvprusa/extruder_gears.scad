/*
 * extruder gears
 *
 * Simple double helix gears for extruders
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn = 16; //preview
//$fn = 60; //render

use <MCAD/involute_gears.scad>

m3 = [
	3.2 /2, //bolt radius
	6.5/2, //nut radius
	2.5 //nut height
];
m8 = [
	8.5 / 2, //bolt radius
	15 /2 //nut radius
];
motor_shaft = 5.2/2;

gear_set();

module gear_set(
	height = 10,
	teath = [11, 45],
	pitch = 40,
	thickness = 2,
	shafts = [motor_shaft, m8],
	bolts = [m3,]
) {	
	setscrew_space = pow(pow(shafts[0] + bolts[0][2], 2) +  pow(bolts[0][1], 2), .5);
	e = .2;

	//We calculate the small gear's root_radius to ensure we use a printable overhang to make room for the setscrew
	root_radius = pitch * teath[0] / (teath[0] + teath[1]) - 2 * pitch * teath[0] / ((teath[0] + teath[1]) * teath[0]) - .2;
	overhang_height = setscrew_space + thickness - root_radius;

	//Small gear
	union() {	
		double_helix_gear(
			teath[0],
			teath[1],
			pitch,
			height,
			thickness,
			-360,
			shafts[0],
			2 // aprox. inside of rim
		);
		difference() {
			union() {
				translate([
					0,
					0,
					height
				]) {	
					cylinder(
						h = overhang_height,
						r1 = root_radius,
						r2 = setscrew_space + thickness
					);
				}
				translate([
					0,
					0,
					height + overhang_height
				]) {
					cylinder(
						h = bolts[0][1]*2 - overhang_height,
						r = setscrew_space + thickness
					);
				}
			}

			//motor shaft
			cylinder(
				r = shafts[0],
				h = 100
			);

			//setscrew
			translate([
				0,
				0,
				height + bolts[0][1]
			]) {
				rotate([
					90,
					0,
					0,
				]) {
					cylinder(
						r = bolts[0][0],
						h = 100
					);
					translate([
						0,
						0,
						shafts[0] - e
					]) {
						cylinder(
							r = bolts[0][1],
							h = bolts[0][2] + e,
							$fn = 6
						);
						translate([
							-bolts[0][1],
							0,
							0,
						]) {
							cube([
								bolts[0][1]*2,
								100,
								bolts[0][2] + e
							]);
						}
					}
				}
			}
		}
	}
	
	//Large gear
	%translate([
		pitch + 10,
		0,
		0
	]) {
		difference() {
			double_helix_gear(
				teath[1],
				teath[0],
				pitch,
				height,
				thickness,
				-360,
				shafts[1][0],
				shafts[1][1] + thickness
			);
			//Mounts over hex-bolt head
			translate([
				0,
				0,
				thickness * 2
			]) {
				cylinder(
					r = shafts[1][1],
					h = 100,
					$fn = 6
				);
			}
		}
	}
}


module double_helix_gear(
	number_of_teeth,
	partner_number_of_teeth,
	partner_pitch,
	height,
	thickness,
	twist,
	shaft,
	hub_thickness
) {
	circular_pitch = 360 * partner_pitch / (number_of_teeth + partner_number_of_teeth);
	union() {
		gear(
			twist = twist / number_of_teeth, 
			number_of_teeth = number_of_teeth, 
			circular_pitch = circular_pitch, 
			gear_thickness = thickness, 
			rim_thickness = height/2, 
			rim_width = thickness,
			hub_diameter=shaft*2 + hub_thickness*2,
			hub_thickness = height, 
			bore_diameter = shaft*2,
			circles = 7
		);
		translate([
			0,
			0,
			height
		]) {
			mirror([
				0,
				0,
				1
			]) {
				gear(
					twist = twist / number_of_teeth, 
					number_of_teeth = number_of_teeth, 
					circular_pitch = circular_pitch, 
					gear_thickness = 0, 
					rim_thickness = height/2, 
					rim_width = thickness,
					hub_thickness = 0, 
					hub_width = 0,
					bore_diameter = 0
				);
			}
		}
	}
}