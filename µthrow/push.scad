include <scadhelper/main.scad>;
use <scadhelper/vitamins/2d.scad>;
use <switch.scad>;

surface = [
	1,
	"White Acrylic",
	[1,1,1]
];

material = [
	7,
	"Clear Acrylic",
	[0,0,1,.2]
];

defuse = [
	3,
	"Frosted Acrylic",
	[1,1,1,.5]
];


translate([-7.5,0,0] * preview)
	2d([35,20], surface, id=1)
		translate([7.5,0,0])
			kerf_cylinder(r=5,h=1);

translate([0,0,0] * preview)
	2d_cylinder(5, defuse, id=2) e();

translate([0,0,-3] * preview)
	2d_cylinder(6, defuse, id=3)
		translate([-2.5,-2.5,0])
			kerf_cube([5,5, defuse[0]]);

translate([0,0,-3] * preview)
	2d([15, 15], defuse, id=4)
		kerf_cylinder(6, defuse[0]);

translate([-19.5,-3.3,-20.5] * preview)
	part(5, "Switch")
		switch();

part(6, "WS2812")
	translate([0,0,-2.5/2] * preview)
		color([0,0,1])
			cube([5,5,2.5], center=true);

translate([-6,3.5,-30/2] * preview)
rotate([90,0,0]*preview)
	2d([32, 30], material, id=7) union() {
			translate([-12.75,-10,0])
				kerf_cube([18,5,material[0]]);
			translate([-13.5,-5.5,0])
				kerf_cube([19.8,10.2,material[0]]);
			translate([-12.5,4,0])
				kerf_cube([22,5,material[0]]);
			translate([-1,5,0])
				kerf_cube([14,10,material[0]]);
			translate([-1.5,15-defuse[0],0])
				kerf_cube([15,defuse[0],material[0]]);
}