floor = .2*6;
wall = 1;
height = 30;

difference() {
	cube([
		92 + wall*2,
		92 + wall*2,
		floor + height
	]);

	translate([
		wall,
		wall,
		floor
	]) {
		cube([
			92,
			92,
			height + 1
		]);
	}

	translate([
		-1,
		wall+25,
		floor
	]) {
		rotate([
			45,
			0,
			0
		]) {
			cube([
				2 + wall,
				9,
				9
			]);
		}
	}
}