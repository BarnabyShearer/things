/*
 * config
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

$fa = 1;
$fs = 1;
preview = 1;

// preview colors
color_steal = [.8,.8,.8];
color_wood = [.3,.3,0];
color_print = [0,.8,0];

// metric bolt sizes
function m_hole(size) = size*1.1/2;
function m_pilot(size) = size*.9/2;

mounting_bolt = 3;

// slightly move and slightly elongate objects in preview to overcome scad rounding errors
module e() {
	if(preview==1) {
		translate([
			0,
			0,
			-.1
		]) {
			scale([
				1,
				1,
				1.1
			]) {
				child();
			}
		}
	} else {
		child();
	}
}

module m_washer(
	size = 3
) {
	color(color_steal) {
		difference() {
			cylinder(
				r = size/2*2,
				h = size*.2
			);
			e() cylinder(
				r = size/2,
				h = size*.2
			);
		}
	}
	translate([
		0,
		0,
		size*.2
	]) {
		child();
	}
}

module m_nut(
	size = 3
) {
	color(color_steal) {
		difference() {
			cylinder(
				r = size*1.8/2,
				h = size*.8,
				$fn = 6
			);
		}
	}
	translate([
		0,
		0,
		size*.8
	]) {
		child();
	}
}

module m_nylock(
	size = 3
) {
	color(color_steal) {
		difference() {
			cylinder(
				r = size*1.8/2,
				h = size,
				$fn = 6
			);
		}
	}
	translate([
		0,
		0,
		size
	]) {
		child();
	}
}

module screw(
	r = 1,
	h = 1,
	pitch = 5,
) {
	linear_extrude(
		height = h,
		twist = -h/pitch*360
	) {
		translate([pitch/5,0,0]) { //H=.2*p works better in plastic then ISO's H=.866*p
			circle(
				r=r 
			);
		}
	}
}

fan40 = [
	40,			//width/length
	10,			//height
	32,			//bolt pitch
	3,			//bolt
];

lm8uu = [
	15.2/2,	//outside
	8/2,	//inside
	26,		//length
];