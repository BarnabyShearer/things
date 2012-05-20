/*
 * MF70 shaft coupling
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;

m3 = 3.5 /2;

coupling_half();

module coupling_half(length = 20, clearence = 6, shaftA=4.5/2, shaftB=6.35/2, bolt=m3) {
	width = (max(shaftA, shaftB)+ clearence)*2;
	height = max(shaftA, shaftB) + clearence/2;
	difference() {
		cube([
			width,
			length,
			height
		]);
		translate([
			width/2,
			length/2,
			height
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r=shaftA,
					h=length/2+1
				);
			}
		}
		translate([
			width/2,
			length+1,
			height
		]) {
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r=shaftB,
					h=length/2+1
				);
			}
		}
		translate([
			clearence/2,
			length/4,
			-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}
		translate([
			width-clearence/2,
			length/4,
			-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}
		translate([
			clearence/2,
			length/4*3,
			-1
		]) {
			cylinder(
				r=bolt,
				h=height+2
			);
		}
		translate([
			width-clearence/2,
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



