/*
 * Hand drill
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;

difference() {
	hull() {
		cylinder(
			r=9/2,
			h=18
		);
		translate([
			0,
			0,
			16
		]) {
			scale([
				.7,
				1,
				.5
			]) {
				sphere(
					r= 10
				);
			}
		}
	}
	
	cylinder(
		r = 8/2,
		h=18,
		$fn=6
	);
}