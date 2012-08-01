/*
 * psu mount
 *
 * Mounts a SUNPOWER FDP3-350A inside the frame under the bed.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn = 60;

m8 = 7.80 / 2;
m4 = 3.8 /2;

front();
translate([
	40,
	0,
	0
]) {
	front();
}
translate([
	80,
	0,
	0
]) {
	back();
}
translate([
	120,
	0,
	0
]) {
	back();
}

module front(
	rail_gap=156,
	psu_width=113.5,
	rod = m8,
	bolt = m4,
	thickness = 3,
	pitch=25,
	offset = 1 //bottom of screw to top of rod
) {
	height = (rail_gap-psu_width)/2;
	shell = rod +thickness;
	length = bolt * 2 + thickness*2;
	translate(	[
		-shell-rod,
		0,
		0
	]) {

		difference() {
			union() {
				cube([
					shell*2,
					height+shell,
					length
				]);
				translate([
					rod-bolt+offset,
					height,
					0
				]) {
					cylinder(
						r=shell,
						h=length
					);
				}
				translate(	[
					-length,
					0,
					0
				]) {
					cube([
						(pitch+2*thickness+2*bolt),
						thickness,
						length
					]);
				}
			}
			translate(	[
				thickness,
				-1,
				-1
			]) {
				cube([
					rod*2,
					height+rod+1,
					length+2
				]);
			}
			translate(	[
				m8-bolt+offset,
				height,
				-1
			]) {
				cylinder(
					r=rod,
					h=length+2
				);
			}

			translate(	[
				-length+bolt+thickness,
				thickness+1,
				bolt+thickness
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r = bolt,
						h = thickness+2
					);
				}
			}
			translate(	[
				-length+bolt+thickness+pitch,
				thickness+1,
				bolt+thickness
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r = bolt,
						h = thickness+2
					);
				}
			}

		}

		
	}

}

module back(
	rail_gap=156,
	psu_width=113.5,
	rod = m8,
	bolt = m4,
	thickness = 3,
	pitch=25,
	offset = 1 //bottom of screw to top of rod
) {
	height = (rail_gap-psu_width)/2;
	shell = rod +thickness;
	length = bolt * 2 + thickness*2;
	translate(	[
		-shell-rod,
		0,
		0
	]) {

		difference() {
			union() {
				translate([
					-rod,
					0,
					0
				]) {
					cube([
						shell+rod,
						height,
						length
					]);
				}
				translate([
					rod-bolt+offset,
					height,
					0
				]) {
					cylinder(
						r=shell,
						h=length
					);
				}
				translate(	[
					-rod,
					0,
					0
				]) {
					cube([
						(pitch+thickness+bolt),
						thickness,
						length
					]);
				}
			}
			translate(	[
				thickness,
				height-rod,
				-1
			]) {
				cube([
					rod*2,
					rod*2,
					length+2
				]);
			}
			translate(	[
				m8-bolt+offset,
				height,
				-1
			]) {
				cylinder(
					r=rod,
					h=length+2
				);
			}

			
			translate(	[
				-length+bolt+thickness+pitch,
				thickness+1,
				bolt+thickness
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r = bolt,
						h = thickness+2
					);
				}
			}

		}

		
	}

}
