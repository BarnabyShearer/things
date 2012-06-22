/*
 * MF70 shaft coupling
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;

m3 = 3.5 /2;

coupling_half();
translate([
	0,
	30,
	0
]) {
	coupling_half(D=.6);
}

translate([
	25,
	0,
	0
]) {
	coupling_half();
}
translate([
	25,
	30,
	0
]) {
	coupling_half(D=.6);
}
translate([
	50,
	0,
	0
]) {
	coupling_half(shaftA=6/2, ratio=3/5);
}
translate([
	50,
	30,
	0
]) {
	coupling_half(shaftA=6/2, ratio=3/5, D=.6);
}


module coupling_half(
	length = 20,
	shaftA=5/2, // With 4mm ID, 6mm OD "Aquarium" sylicon tubing for extra grip.
	shaftB=6.35/2,
	ratio = 1/2,
	D = 0,
	gap = 1,
	bolt=m3
) {
	width = max(shaftA, shaftB)*2 + bolt*8;
	height = max(shaftA, shaftB) *3;
	difference() {
		cube([
			width,
			length,
			height-gap/2
		]);
		translate([
			width/2,
			length*(1-ratio),
			height
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r=shaftA,
					h=length * (1-ratio)+1
				);
			}
		}
		difference() {
			translate([
				width/2,
				length+.99,
				height
			]) {
			
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r=shaftB,
						h=length * ratio+1
					);
				}
			}
			cube([
				width,
				length,
				height-shaftB+D
			]);
		}
		translate([
			bolt*2,
			length/4,
			-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}
		translate([
			width-bolt*2,
			length/4,
			-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}
		translate([
			bolt*2,
			length/4*3,
			-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}
		translate([
			width-bolt*2,
			length/4*3,
			-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}
	}
}



