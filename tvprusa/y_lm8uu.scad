/*
 * y lm8uu
 *
 * Mount bed directly on y-rods. Reduces moving mass, ensures rigidity,
 * increases print height.
 * 
 * Copyright 2012 <b@Zi.iS>
 * License GPLv2
 *
 */
$fn = 60;

m3 = [
	3.6/2, //bolt
	6.1 /2, //nut
];
lm8uu = [
	26, //length
	15.2/2, //outside
];

mount();

module mount(
	bearing = 	lm8uu,
	height = 23, //center of rail to bottom of bed
	mount = [
		31,
		14,
		m3,
	],
	thickness = 1.75,
) {
	size = [
		thickness*2,
		mount[0] + mount[2][1]*4,
		bearing[0],
	];

	difference() {
		union() {
			cube(size);
			translate([
				height,
				size[1]/2,
				0,
			]) {
				cylinder(
					r = bearing[1] + thickness,
					h = bearing[0]
				);
			}
			translate([
				0,
				size[1]/2 - bearing[1],
				0,
			]) {
				cube([
					height,
					bearing[1] * 2,
					bearing[0]
				]);
			}
		}
		translate([
			height,
			size[1]/2,
			-1,
		]) {
			cylinder(
				r = bearing[1],
				h = bearing[0] + 2
			);
			cube([
				100,
				thickness,
				bearing[0] + 2,
			]);
		}
		for(x=[0:1]) {
			for(y=[0:1]) {
				rotate([
					90,
					90,
					90,
				]) {
					translate([
						-(size[2] - mount[1])/2 - mount[1]*x,
						mount[2][1]*2 +mount[0]*y,
						-1,
					]) {
						cylinder(
							r = mount[2][0],
							h = thickness*2 + 2
						);
						translate([
							0,
							0,
							1 + thickness
						]) {
							cylinder(
								r = mount[2][1],
								h = thickness+2,
								$fn=6
							);
						}	
					}
				}
			}
		}
	}
}

