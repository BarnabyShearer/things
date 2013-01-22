/*
 * Potting seal
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */
$fn=60;

seal();

module seal(
	r = 50/2,
	h = 30,
	hole = [14.7, 19.5],
	tab = [3/2, 10],
	t = 1
) {

	difference() {
		union() {
			cylinder(
				r=r+t,
				h=h
			);
			for(x=[0:2]) {
				rotate([
					0,
					0,
					360/3*x
				]) {
					translate([
						-tab[1]/2,
						0,
						h-t*2
					]) {
						cube([
							tab[1],
							r+tab[1],
							t*2
						]);
					}
					//Support
					translate([
						0,
						r + tab[1]/2,
						0
					]) {
						cylinder(
							r = tab[0]+.1,
							h = h
						);
					}
					translate([
						-tab[1]/2,
						0,
						0
					]) {
						cube([
							tab[1],
							r+tab[1],
							h
						]);
					}
				}
			}
		}
		for(x=[0:2]) {
			rotate([
				0,
				0,
				360/3*x
			]) {
				translate([
					0,
					r + tab[1]/2,
					1
				]) {
					cylinder(
						r = tab[0],
						h = h + t*2
					);
				}
			}
		}
		translate([
			0,
			0,
			t
		]) {
			cylinder(
				r=r,
				h=h+1
			);
		}
		cube(center = true, [
			hole[0],
			hole[1],
			2 + t
		]);
		for(x=[0:1]) {
			translate([
				-r/5 *3 + r/5 *6*x,
				0,
				-1
			]) {
				cylinder(
					r=r/5,
					h= 2+t
				);
			}
		}

		
	}
}
