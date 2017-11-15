$fn = 60;

difference() {
	union() {
*cube(center = true,
	[
		30,	
		30,
		5
	]
);
translate([0,0,2.5])
	cylinder(
		r = 25.5/2+1,
		h = 1
	);
translate([0,0,3.5])
	cylinder(
		r = 25.5/2,
		h = 5.2
	);
	translate([25.4/2,0,8])
	rotate([0,45,0,])
	cube(center = true,
		[
			1,
			3,
			1
		]
	);
translate([-25.4/2,0,8])
	rotate([0,45,0,])
	cube(center = true,
		[
			1,
			3,
			1
		]
	);
translate([0,-25.4/2,8])
	rotate([45,0,0,])
	cube(center = true,
		[
			3,
			1,
			1
		]
	);
translate([0,25.4/2,8])
	rotate([45,0,0,])
	cube(center = true,
		[
			3,
			1,
			1
		]
	);
}
	translate([0,0,2.5+1])
	cylinder(
		r = 25.5/2-1,
		h = 10
	);
	translate([0,-2,8.5])
	cube(center = true,
		[
			1000,
			1,
			10
		]
	);
	translate([0,2,8.5])
	cube(center = true,
		[
			1000,
			1,
			10
		]
	);
	translate([-2,0,8.5])
	cube(center = true,
		[
			1,
			1000,
			10
		]
	);
	translate([2,0,8.5])
	cube(center = true,
		[
			1,
			1000,
			10
		]
	);
}