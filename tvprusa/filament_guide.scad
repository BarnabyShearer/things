/*
 * TVRRUG filament guide
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn=60;

m3 = 3.2 /2;

guide();

module guide(
	bolt = m3,
	filament = 3.5/2,
	width = 18,
	bolt_offset = 12,
	filament_offset = [
		5.5,
		7.5
	]
) {
	size = [
		width,
		filament_offset[1]+filament*2,
		bolt*4
	];
	
	difference() {
		cube(size);
		translate([
			filament_offset[0],
			filament_offset[1],
			-1
		]) {
			cylinder(
				r = filament,
				h = size[2]+2
			);
		}
		translate([
			bolt_offset,
			-1,
			size[2]/2
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = bolt,
					h = size[1]+2
				);
			}
		}
	}	
}

