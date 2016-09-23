/*
 * y-carriage
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>

use <scadhelper/vitamins/linear_bearing.scad>
use <scadhelper/vitamins/rod.scad>
use <heated_bed.scad>

y();

module y(
	rod = [8, 410],
	bars = 150,
	bearings = 100,
	Y = 0,
	id
) {
	//bars
	for(x=[0:1]) {
		translate([
			space(bars, x),
			rod[1]/2,
			-20
		]) {
			rotate([90,0,0]) {
				rod(
					rod[0]/2,
					rod[1],
					id = id + x
				);
			}
		}
	}
	translate([
		0,
		90 - Y,
		0
	]) {
		y_carriage(
			rod = rod[0],
			bars = bars,
			bearings = bearings,
			id = id + 3
		);
		heated_bed(id = id + 7);
	}
}

module y_carriage(
	rod,
	bars,
	bearings,
	id = 1
) {
	rotate([
		90,
		0,
		0
	]) {
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					space(bars, x),
					-20,
					space(bearings, y),
				]) {
					linear_bearing(
						rod,
						id = id + x*2+y
					);
				}
			}
		}
	}
}


