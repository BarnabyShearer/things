/*
 * Useless machine
 *
 * Copyright 2014 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <scadhelper/vitamins/2d.scad>;
use <scadhelper/vitamins/kerf_bend.scad>;
use <MCAD/involute_gears.scad>;
include <scadhelper/vitamins/servos.scad>;
use <scadhelper/vitamins/batteries.scad>;
use <scadhelper/vitamins/hardware.scad>;
use <scadhelper/bend.scad>;
use <switch.scad>;

case_material=[
	3,
	"Plywood",
	color_wood
];

mech_material=[
	8,
	"Acrylic",
	color_acrylic
];

arm_teeth = 60;
cog_teeth = 10;
arm_radius = 35;
circular_pitch = arm_radius * 360 / arm_teeth;
cog_radius = circular_pitch*cog_teeth/360;

part(1, "Dual throw, dual pole switch") {
	translate([-30/2, -18/2, -18])
		color([.3,.3,.3])
			cube([30, 18, 18]);
	translate([0,-18/2, -18-8/2])
		color([.9,.9,.2])
			rotate([-90,0,0])
				cylinder(d=8, h=18);
	translate([-30/2-8/2,-18/2, -8/2])
		color([.9,.9,.2])
			rotate([-90,0,0])
				cylinder(d=8, h=18);
	translate([30/2+8/2,-18/2, -8/2])
		color([.9,.9,.2])
			rotate([-90,0,0])
				cylinder(d=8, h=18);
	color([.9,.9,.9])
		cylinder(
			d=15,
			h=10
		);
	translate([0,0,8])
		rotate([0,$t<0.5 ? 20 :-20,0])
			color([.9,.9,.9])
				cylinder(
					d1=4,
					d2=6.5,
					h=17
				);
}

translate([0, -mech_material[0]/2,-5] * preview)
	rotate([-90,25+abs(130*($t-.5)),0] * preview)
		translate([+(arm_radius+5+5+2)/2-10, 0, 0] * preview) {
	2d(
		[arm_radius+5+5+2, arm_radius*2+2],
		mech_material,
		id=2
	) {
		difference() {
			translate([-(arm_radius+5+5+4)/2, -(arm_radius*2+4)/2, 0])
				cube([arm_radius+5+5+4, arm_radius*2+4, 100]);
			translate([-(arm_radius+5+5+2)/2+10,0,0])
				gear(
					number_of_teeth = arm_teeth,
					circular_pitch = circular_pitch,
					pressure_angle = 28,
					clearance = 0,
					twist = 0,
					gear_thickness = mech_material[0],
					rim_thickness = mech_material[0],
					hub_thickness = mech_material[0],
					bore_diameter = 0
				);
		}
		translate([-(arm_radius+5+5+2)/2+10,0,0])
			e() cylinder(r=arm_radius-10, h=mech_material[0]);
		translate([-100-arm_radius/2+15,0,0])
			cube(100);	
	}
	//On
	translate([-(arm_radius+5+5+4)/2-2,-arm_radius+6.5,4] * preview)
		rotate([0,90,0] * preview)
			2d([20,15], case_material, id=3);

}

// Gear
translate([0, mech_material[0]/2,-5] * preview) {
	rotate([0,45,0] * preview) translate([arm_radius+cog_radius, 0, 0] * preview) {
		rotate([90,-abs(130*arm_teeth/cog_teeth*($t-.5)),0] * preview)
			2d(
				[cog_radius*2+2, cog_radius*2+2],
				mech_material,
				id=4
			) {
				difference() {
					translate([-cog_radius-2, -cog_radius-2, 0])
						cube([cog_radius*2+4, cog_radius*2+4, 100]);
					gear(
						number_of_teeth = cog_teeth,
						circular_pitch = circular_pitch,
						pressure_angle = 28,
						clearance = 0,
						twist = 0,
						gear_thickness = mech_material[0],
						rim_thickness = mech_material[0],
						hub_thickness = mech_material[0],
						bore_diameter = 0
					);
				}
				gear(
					number_of_teeth = 23,
					circular_pitch = 2.4 * 360 / 23,
					pressure_angle = 45,
					clearance = 0,
					twist = 0,
					gear_thickness = mech_material[0],
					rim_thickness = mech_material[0],
					hub_thickness = mech_material[0],
					bore_diameter = 0
				);
			}
	}
}

//Off
translate([-arm_radius-1+15/2,0,5] * preview)
	2d([15,20], case_material, id=5);

//Geared motor
translate([29,16,-34] * preview)
	rotate([90,0,0] * preview)
		servo(AS_17[0], AS_17[1], id=6);

//Batterys
for(x=[0,14.5])
	for(z=[0,14.5])
		translate([27,-20-x,-36+z] * preview)
			rotate([0,-90,0] * preview)
				aa(id=7);
//Bolts
for(x=[0:1])
	translate([0,0,-5] * preview)
		rotate([0,20+45*x,0] * preview)
			translate([arm_radius-10-3/2,-20/2, 0] * preview)
				rotate([-90,0,0] * preview)
					part(8+x, "3M bolt")
						cylinder(d=3, h=20);

//Endstop
translate([-45, 3.5, 0] * preview)
	rotate([180,0,0] * preview)
		switch(id=10);

//Supports
for(x=[0,1]) {
	translate([0,7-11*x,-19] * preview)
		rotate([90,0,0] * preview)
			2d(
				[100, 48],
				case_material,
				castle=[0,48/5,0,48/5],
				id=11+x
			){
				if(x==0) {
					translate([29,-15,0])
						e() kerf_cylinder(12/2,  case_material[0]);
					translate([29-11,-15,0])
						e() kerf_cylinder(18.2/2,  case_material[0]);
					translate([29-20,-15,0])
						e() kerf_cylinder(7.5/2,  case_material[0]);
				}
				translate([-30/2,1,0])
					e() kerf_cube([30, 18, case_material[0]]);
				translate([-15/2,15,0])
					e() kerf_cube([15, 10, case_material[0]]);
				translate([-50/2,10,0])
					e() kerf_cube([50, 10, case_material[0]]);
				translate([-10/2,-8,0])
					e() kerf_cube([10, 10, case_material[0]]);
				for(x=[0:1])
					translate([0,48/2-10,0])
						rotate([0,0,-20-45*x])
							translate([arm_radius-10-3/2,0, -20/2])
								kerf_cylinder(d=3, h=20);
			}
}

//Lid
translate([0,0,8-3] * preview) {
	2d([100, 120], case_material, id=13) {
		e() kerf_cylinder(r=12/2, h=case_material[0]);
		translate([0,10,0])
			difference() {
				translate([-51,0,0]) cube([102,100,100]);
				e() cylinder(r=50, h=100);
			}
		translate([0,-10,0])
			difference() {
				translate([-51,-100,0]) cube([102,100,100]);
				e() cylinder(r=50, h=100);
			}
		translate([-arm_radius-1.5, -21/2, 0])
			e() e() kerf_cube([16,21,3]);
		translate([+arm_radius+1.5-16, -21/2, 0])
			e() kerf_cube([16,21,3]);
	}
}

//base
translate([0,0,-46] * preview) {
	2d([100, 120], case_material, id=14) {
		translate([0,10,0])
			difference() {
				translate([-51,0,0]) cube([102,100,100]);
				e() cylinder(r=50, h=100);
			}
		translate([0,-10,0])
			difference() {
				translate([-51,-100,0]) cube([102,100,100]);
				e() cylinder(r=50, h=100);
			}
	}
}

for(x=[0:1])
	rotate([0,0,180*x] * preview) {
		for(z=[0:1]) 
			translate([0,-10-(50-case_material[0])/2,5-case_material[0]+(-5+case_material[0]-46+case_material[0])*z] * preview) {
				2d([(50-case_material[0])*2, 50-case_material[0]], case_material, id=15+x*3+z) {
					difference() {
						translate([-(50-case_material[0])-1, -(50-case_material[0])/2-1, 0])
							cube(
								[(50-case_material[0])*2+2, 50-case_material[0]+2, 100]
							);
						translate([0, (50-case_material[0])/2, 0])
							kerf_cylinder(r=50-case_material[0], h=100);
					}
					translate([0, (50-case_material[0])/2, 0])
						kerf_cylinder(r=50-case_material[0]*2, h=100);
				}
			}
		part(17+x*3, str(
				case_material[0],
				"mm ",
				case_material[1],
				" ",
				20+(2/(360/180)*PI*(50-case_material[0])/case_material[0]) * (case_material[0]/2 + kerf) + kerf,
				"x",
				48 + kerf, "mm"
		)) {
			translate([0, 10, -46+case_material[0]] * preview)
			translate([10, 0, 0] * (1-preview))
				kerf_bend(180, 50-case_material[0], 48, case_material, -1);
			for(z=[0:1])
				translate([-50+(100-case_material[0])*z, 5, -19] * preview)
				translate([(10 + (2/(360/180)*PI*(50-case_material[0])/case_material[0]) * (case_material[0]/2 + kerf))*z, 0, 0] * (1-preview)) //HACK
					rotate([90, 0, 90] * preview)
						2d([10-kerf, 48], case_material, id=-1) {
							for(y=[-48/5*2,0,48/5*2])
								translate([-1,-48/5/2+y,0])
									e() kerf_cube([case_material[0], 48/5, case_material[0]]);
							for(y=[-48/5*2-.3,48/5*2+.3])
								translate([-1,-48/5/2+y,0])
									e() kerf_cube([case_material[0], 48/5, case_material[0]]);
						}
		}
	}