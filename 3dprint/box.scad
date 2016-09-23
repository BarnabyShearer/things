include <scadhelper/main.scad>;
use <scadhelper/vitamins/2d.scad>;

case = [
	8,
	"Acrylic",
	color_acrylic
];

castle=[40, 40, 40, 40];

size=[550,550,550];

//t/b
for(x=[0:1])
	translate([0, 0, -size[2]/2 + x*(size[2]-case[0])])
		2d(
			[size[0], size[1]],
			case,
			castle = castle
		);

rotate([90,0,0])
	for(x=[0:1])
		translate([0, 0, -size[1]/2 + x*(size[1]-case[0])])
			2d(
				[size[0], size[2]],
				case,
				castle = castle,
				castle_alt = [1, 0]
			);

rotate([0,90,0])
	for(x=[0:1])
		translate([0, 0, -size[0]/2 + x*(size[0]-case[0])])
			2d(
				[size[2], size[1]],
				case,
				castle = castle,
				castle_alt = [0, 0]
			);
