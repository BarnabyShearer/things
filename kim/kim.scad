/*
 * kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>

use <frame.scad>
use <x_carriage.scad>
use <y_carriage.scad>

frame();
translate([
	200/2,
	0,
	-50
]) {
	y_carriage();
	x_carriage();
}