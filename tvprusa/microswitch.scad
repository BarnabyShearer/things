/*
 * Microswitch
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
	6.2 /2, //nut
	2.4, //nut width
];
m8 = 8.4/2;

micro = [
	12.8,
	5.8,
	6.6,
];

mount();

translate([
	20,
	0,
	0
]) {
	mount();
}
translate([
	40,
	0,
	0
]) {
	mount();
}

module mount(
	switch = micro,
	rod = m8,
	bolt = m3,
	thickness = 1.85,
) {
	size = [
		switch[0] + thickness*2,
		switch[1] + thickness*2,
		switch[2] + thickness - 1,
	];

	difference() {
		union() {
			cube(size);
			translate([
				size[0]/2,
				-rod,
				0,
			]) {
				cylinder(
					r = rod + thickness,
					h = size[2]
				);
			}
			translate([
				size[0]/2 - rod - thickness,
				-(rod*2 + thickness*3 + bolt[2]),
				0,
			]) {
				cube([
					rod*2 + thickness*2,
					rod*2 + thickness*3 + bolt[2],
					size[2]
				]);
			}
		}
		translate([
			thickness,
			thickness,
			thickness,
		]) {
			cube(switch);
		}
		for(x=[0:2]) {
			translate([
				thickness + ((switch[0] - thickness*2)/3+thickness)*x,
				thickness,
				-1,
			]) {
				cube([
					(switch[0] - thickness*2)/3,
					switch[1],
					thickness+2,
				]);
			}
		}
		translate([
			size[0]/2,
			-rod,
			-1,
		]) {
			cylinder(
				r = rod,
				h = size[2] + 2
			);
		}
		translate([
			size[0]/2,
			-rod,
			size[2]/2,
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r = bolt[0],
					h = 100
				);
			}
		}
		translate([
			size[0]/2,
			-rod*2-thickness,
			size[2]/2,
		]) {
			rotate([
				90,
				30,
				0
			]) {
				cylinder(
					r = bolt[1],
					h = bolt[2],
					$fn = 6
				);
			}
		}
		translate([
			size[0]/2,
			-rod*2-thickness,
			size[2]/2+2,
		]) {
			rotate([
				90,
				30,
				0
			]) {
				cylinder(
					r = bolt[1],
					h = bolt[2],
					$fn = 6
				);
			}
		}
	}
}

