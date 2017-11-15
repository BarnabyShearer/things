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

top = [
	3,
	"Black Acrylic",
	[0,0,0]
];

2d([80,80], surface, id=1)
	kerf_cylinder(r=4,h=1);


rotate([180,0,0] * preview) {
	part(2, "bumpy")
		translate([0,0, 1.5] * preview)
			color(material[2])
				drawing()
					bumpy(10, 7, 9);
	
	part(3, "Microswitch")
		rotate([0,0,360/9*7.5] * preview)
			translate([-30.5,0,0] * preview)
				rotate([90,0,90] * preview)
					translate([-19,0,0] * preview)
						switch(pressed=1);

	part(4, "Microswitch")
		rotate([0,0,360/9*2.75] * preview) //1/4 out of phase
			translate([-30.5,0,0] * preview)
				rotate([90,0,90] * preview)
					translate([-19,0,0] * preview)
						switch(pressed=1);

	2d([70, 70], material, id=5) union() {
		kerf_cylinder(r=15, h=7);

		rotate([0,0,360/9*7.5]) {
			translate([-35,-18,0])
				kerf_cube([10.2,18,7]);
			translate([-30.5,-19,0])
				kerf_cube([10.2,19.8,7]);
			translate([-20.5,-18,0])
				kerf_cube([5,22,7]);
			translate([-20.5,-5,0])
				kerf_cube([10,10,7]);
		}
		rotate([0,0,360/9*2.75]) {
			translate([-35,-18,0])
				kerf_cube([10.2,18,7]);
			translate([-30.5,-19,0])
				kerf_cube([10.2,19.8,7]);
			translate([-20.5,-18,0])
				kerf_cube([5,22,7]);
			translate([-20.5,-5,0])
				kerf_cube([10,10,7]);
		}
		translate([20, 0, 0])
			kerf_cube([5,5,14], center=true);
	}

}

part(6, "WS2812")
	translate([20, 0, -material[0]+2.5/2] * preview)
		color([0,0,1])
			cube([5,5,2.5], center=true);

translate([0,0,-1.5] * preview)
	2d_cylinder(4, material, id=7) e();

translate([0,0,7-1.7-3] * preview)
	2d_cylinder(20, defuse, id=8)
		kerf_cylinder(r=4, h=defuse[0]);

translate([0,0,7-1.7] * preview)
	2d_cylinder(20, top, id=9) e();

module bumpy(r, h, teeth, smooth=1.1) {
	cylinder(r=r,h=h);
	for(i=[0:teeth]) {
		rotate([0,0, 360/teeth*i]) {
			translate([r, 0, 0]) {
				cylinder(r = PI*r/teeth*smooth, h=h);
			}
		}
	}
}