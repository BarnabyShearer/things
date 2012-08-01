/*
 * belt clamp
 *
 * Clamp for the y-carriage incorporating a ratchet for easy tightening.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 *
 */
$fn = 60;

m3 = 3.6/2;
m3_nut = 6.3 /2;

hole_spacing = 18;

mount();

module mount(
	width = 7,
	pitch = 18,
	bolt = m3,
	nut = m3_nut,
	thickness = 7,
	belt_thickness = 1.5
) {
	length = pitch + bolt *4;

	difference() {
		cube([
			width,
			length,
			thickness
		]);

		translate([
			-1,
			bolt*4,
			1
		]) {
			cube([
				width+2,
				1,
				thickness
			]);
		}
		translate([
			-1,
			length-bolt*4-1,
			1
		]) {
			cube([
				width+2,
				1,
				thickness
			]);
		}
		translate([
			-1,
			bolt*4,
			thickness-belt_thickness
		]) {
			cube([
				width+2,
				pitch-bolt*4,
				belt_thickness+1
			]);
		}

		translate([
			-1,
			bolt*4,
			1
		]) {
			rotate([
				0,
				-32,
				0
			]) {
				cube([
					width+20,
					pitch-bolt*4,
					thickness
				]);
			}
		}
		
		translate([
			bolt*2,
			bolt*2,
			-1
		]) {
			cylinder(
				h = thickness+2,
				r = bolt
			);
		}
		translate([
			bolt*2,
			bolt*2 + pitch,
			-1
		]) {
			cylinder(
				h = thickness+2,
				r = bolt
			);
		}
		translate([
			bolt*2,
			bolt*2,
			-1
		]) {
			rotate([
				0,
				0,
				180/6
			]) {
				cylinder(
					h = 2,
					r = nut,
					$fn = 6
				);
			}
		}
		translate([
			bolt*2,
			bolt*2 + pitch,
			-1
		]) {
			rotate([
				0,
				0,
				180/6
			]) {
				cylinder(
					h = 2,
					r = nut,
					$fn = 6
				);
			}
		}
	}
}
