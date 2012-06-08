/*
 * TVRRUG Fan mount
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;
m8 = 7.80 / 2;
m3 = 3.5 / 2;

fan();
translate(	[
	20,
	0,
	0
]) {
	fan();
}

module fan(
	rod = m8,
	bolt = m3,
	thickness = 1.6,
	inset = 2.5,
	width = 10.4
) {
	shell = rod +thickness;
	length = bolt * 4;
	difference() {
		union() {
			cylinder(
				r=shell,
				h=length
			);
			translate(	[
				-(width+thickness*2)/2,
				0,
				0
			]) {
				cube([
					width+thickness*2,
					bolt*3+inset+rod,
					length
				]);
			}
		}
		translate(	[
			0,
			0,
			-1
		]) {
			cylinder(
				r=rod,
				h=length+2
			);
		}
		translate(	[
			-(width)/2,
			thickness,
			-1
		]) {
			cube([
				width,
				bolt*3+inset+thickness*2+rod*2+1,
				length+2
			]);
		}
		translate(	[
			-1-width/2-thickness,
			rod+bolt+inset,
			length/2
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r=bolt,
					h=width+thickness*2+2
				);
			}
		}

	}

}
