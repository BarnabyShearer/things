	/*
 * Model railway workshop cradle
 *
 * Copyright 2014 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <scadhelper/vitamins/2d.scad>;
use <MCAD/involute_gears.scad>;

material=[
    7.5,
    "Acrylic",
    color_acrylic
];

bolt=3;
arm_teeth = 60;
cog_teeth = 15;
arm_radius = 50;
circular_pitch = arm_radius * 360 / arm_teeth;
cog_radius = circular_pitch*cog_teeth/360;

translate([0,arm_radius+cog_radius,0]) rotate([0,0,-360/cog_teeth/4])
2d(
	[cog_radius*2+5, cog_radius*2+5],
	material
) {
	difference() {
		translate([-cog_radius-10, -cog_radius-10,0]) cube([cog_radius*2+20, cog_radius*2+20, material[0]]);
		gear(
			number_of_teeth = cog_teeth,
			circular_pitch = circular_pitch,
			pressure_angle = 28,
			clearance = 0,
			twist = 0,
			gear_thickness = material[0],
	      rim_thickness = material[0],
	      hub_thickness = material[0],
	      bore_diameter = 0
		);	
	}
	translate([-material[0]/2, -material[0]/2,0])
	e() kerf_cube([material[0], material[0], material[0]]);
}

2d(
	[arm_radius*2+5, arm_radius*2+5],
	material
) {
	difference() {
		translate([-arm_radius-10, -arm_radius-10,0]) cube([arm_radius*2+20, arm_radius*2+20, material[0]]);
		gear(
			number_of_teeth = arm_teeth,
			circular_pitch = circular_pitch,
			pressure_angle = 28,
			clearance = 0,
			twist = 0,
			gear_thickness = material[0],
	      rim_thickness = material[0],
	      hub_thickness = material[0],
	      bore_diameter = 0
		);	
	}
	e() difference() {
		kerf_cylinder(r=arm_radius*.8, h=material[0]);
		kerf_cylinder(r=arm_radius*.7, h=material[0]);
		translate([-arm_radius, -arm_radius,0]) cube([arm_radius*2, arm_radius+15, material[0]]);
	}
	difference() {
		kerf_cylinder(r=arm_radius*.6, h=material[0]);	
		rotate([0, 0, 90]) {
			translate([arm_radius*.5, 0, 0]) {
				cylinder(r=arm_radius*.1, h=material[0]);
				translate([0,-arm_radius*.1,0]) cube([arm_radius*.1, arm_radius*.2, material[0]]);
			}
		}
	}
	difference() {
		translate([-arm_radius-10, -arm_radius-10,0]) cube([arm_radius*2+20, arm_radius+10, material[0]]);
		difference() {
			cylinder(r=arm_radius*.74, h=material[0]);
			translate([-arm_radius-10, -arm_radius-10,0]) cube([arm_radius*2+20, arm_radius-10, material[0]]);
		}
		rotate([0, 0, -40]) {
			translate([arm_radius*.7, 0, 0])
				cylinder(r=arm_radius*.1, h=material[0]);
		}
		rotate([0, 0, -140]) {
			translate([arm_radius*.7, 0, 0])
				cylinder(r=arm_radius*.1, h=material[0]);
		}

	}
		rotate([0, 0, -40]) {
			translate([arm_radius*.7, 0, 0])
				kerf_cylinder(r=bolt/2, h=material[0]);
		}
		rotate([0, 0, -140]) {
			translate([arm_radius*.7, 0, 0])
				kerf_cylinder(r=bolt/2, h=material[0]);
		}
		rotate([0, 0, 90]) {
			translate([arm_radius*.5, 0, 0])
				cylinder(r=bolt/2, h=material[0]);
		}
}
