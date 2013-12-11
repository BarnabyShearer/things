/*
 * Kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <x.scad>
use <y.scad>
use <e.scad>
use <frame.scad>

X = 0; //0-220
Y = 0; //0-200
Z = 0; //0-160

translate([
	-131,
	0,
	65
]) {
	frame(id=1);
}
y(Y = Y, id=13);
x(X = X, Z = Z, id=21);
