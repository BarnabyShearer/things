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
	t = .52*2
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
						r,
						h-tab[1]
					]) {
						rotate([
							45,
							0,
							0
						]) {
							cube([
								tab[1],
								tab[1]*2,
								tab[1]
							]);
						}
					}
					
				}
			}
		}
		//support hollow
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
				translate([
					-tab[1]/2 +t,
					r+t,
					h - t*2 -tab[1]
				]) {
					cube([
						tab[1] - t*2,
						tab[1],
						tab[1]
					]);
				}
			}

		}
		translate([
			0,
			0,
			t*2
		]) {
			cylinder(
				r=r,
				h=h+1
			);
		}
		translate([
			0,
			0,
			h
		]) {
			cylinder(
				r=100,
				h=100
			);
		}
		cube(center = true, [
			hole[0],
			hole[1],
			2 + t*3
		]);
		for(x=[0:1]) {
			translate([
				-r/5 *3 + r/5 *6*x,
				0,
				-1
			]) {
				cylinder(
					r=r/5,
					h= 2+t*2
				);
			}
		}

		
	}
}
