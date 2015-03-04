/*
 * Kim
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

//TODO: Belt tie
//TODO: fan
//TODO: HE clamp (-1mm)

include <scadhelper/main.scad>
use <x.scad>
use <y.scad>
use <e.scad>
use <prusa_derived_frame.scad>
use <x_carriage_kraken.scad>

X = $t*200; //0-220
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

x_carriage(
	X = X,
	Z = Z,
	id = id + 18
);
