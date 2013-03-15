/*
 * Die
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn = 20;

die() {
	number(1);
	number(2);
	number(3);
	number(4);
	number(5);
	number(6);
}

module die(
	width=11,
	size = 3
) {
	difference() {
		intersection() {
			cube(
				size = width,
				center = true
			);
			sphere(
				r = width*.7
			);
		}
		for(x=[0:5]) {
			rotate(
				[
					[180,0],
					[90,0,0],
					[90,0,90],
					[90,0,-90],
					[90,0,180],
					[0,0,0],
				][x]
			) {
				translate([
					0,
					0,
					width/2
				]) {
					child(x);
				}
			}
		}
	}
}

module number(
	number = 1,
	pitch = 11/4,
	r = 2/2,
) {
	for(x=[0:2]) {
		for(y=[0:2]) {
			if(
				[
					0,
					[
						[0,0,0],
						[0,1,0],
						[0,0,0]
					],
					[
						[0,0,1],
						[0,0,0],
						[1,0,0]
					],
					[
						[1,0,0],
						[0,1,0],
						[0,0,1]
					],
					[
						[1,0,1],
						[0,0,0],
						[1,0,1]
					],
					[
						[1,0,1],
						[0,1,0],
						[1,0,1]
					],
					[
						[1,0,1],
						[1,0,1],
						[1,0,1]
					],
				][number][y][x]
			) {
				translate([
					-pitch + pitch*x,
					-pitch + pitch*y,
					0
				]) {
					sphere(
						r = r
					);
				}
			}
		}
	}
}