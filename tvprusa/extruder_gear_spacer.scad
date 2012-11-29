/*
 * extruder gear spacer
 *
 * Moves the large gear out from the body to clear the bolt heads.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn=60;

difference() {

cylinder(
	r=11.6/2,
	h=6
);

cylinder(
	r=8.5/2,
	h=6
);
}