include <scadhelper/main.scad>;
use <scadhelper/vitamins/2d.scad>;

material=[
	3,
	"Arcylic",
	[1,1,1,.5]
];

2d([10,10], material, id=1) union() {
	for(x=[-1.1,1.1]) {
		for(y=[-0.95, 0, 0.95]) {
			translate([x, y, 0]) {
				cylinder(r=.8/2, h=material[0]);
			}
		}
	}
}

translate([0,0,material[0]]*preview) {
	2d([10,10], material, id=1) {
		translate([-2.9/2, -3/2, 0]) {
			kerf_cube([2.9, 3, material[0]]);
		}
	}
}