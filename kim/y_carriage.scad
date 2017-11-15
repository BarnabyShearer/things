/*
 * y-carriage
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>

use <vitamin/linear_bearing.scad>
use <vitamin/rod.scad>
use <vitamin/heated_bed.scad>
use <other/y_carriage_plate.scad>

//bars
%rotate([
	90,
	0,
	0
]) {
	translate([
		-150/2,
		-20,
		-125
	]) {
		rod();
		translate([
			150,
			0,
			0
		]) {
			rod();
		}
	}
}
y_carriage();

module y_carriage(
	bars = 150,
	bearings = 100,
) {
	rotate([
		90,
		0,
		0
	]) {
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					-bars/2 + bars*x,
					-20,
					-bearings/2 + bearings*y,
				]) {
					linear_bearing();
				}
			}
		}
	}
	
	color([.8,0,0]) {
		heated_bed();
	}
}


