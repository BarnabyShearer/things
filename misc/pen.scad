$fn = 60;
rotate([0,90,0]) {
	difference() {
		cylinder(
			r = 4.75/2 + 3,
			h = 25+55+1,
			$fn = 8
		);
		translate([0, 0, 1]) {
			cylinder(
				r = 4/2,
				h = 26
			);
		}
		translate([0, 0, 26]) {
			cylinder(
				r = 4.75/2 + .5,
				h = 56
			);
		}
	}
}