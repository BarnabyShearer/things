/*
 * x carriage plate
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../config.scad>

x_carriage_plate();

module x_carriage_plate(
	heads = 17,
	bars = 50
) {
	color([.5,.5,0]) {
		translate([
			-20,
			-bars/2,
			0
		]) {
			cube([
				50,
				bars,
				4.64
			]);
		}
	}
}


