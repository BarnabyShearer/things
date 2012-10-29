/*
 * hotend mount
 *
 * NOTE: This needs to be milled out of a rigid heat resistant material.
 * It is tested with MDF.
 *
 * Mount for hotend_direct_bowden.scad
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn=60;

translate([
	0,
	0,
	-6
]) {
	difference() {
		cube([
			60,
			30,
			6
		]);
		translate([
			5,
			15,
			0
		]) {
			cylinder(
				r=3/2,
				h=7
			);
		}
		translate([
			30-11.5,
			15,
			0
		]) {
			cylinder(
				r=3/2,
				h=7
			);
		}
		translate([
			30,
			15,
			0
		]) {
			cylinder(
				r=5.6/2,
				h=7
			);
		}
		translate([
			30+11.5,
			15,
			0
		]) {
			cylinder(
				r=3/2,
				h=7
			);
		}
		translate([
			55,
			15,
			0
		]) {
			cylinder(
				r=3/2,
				h=7
			);
		}
	}
}
	
	
