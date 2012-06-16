/*
 * TVRRUG hotend mount
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

m4 = 4.6/2;

support();

module support(
	length = 70,
	width = 28,
	thickness = 6.5,
	bolt = m4,
	offset = 8,
	pitch = 50,
	mount = 17.5/2,
	hole = 12/2,
	mount_height=4.64
	
) {
	difference() {
		cube([
			length,
			width,
			thickness
		]);
		translate([
			offset + (length-offset-pitch)/2,
			width/2,
			-1
		]) {
			cylinder(
				r=bolt,
				h=thickness+2
			);
		}
		translate([
			offset + (length-offset-pitch)/2+pitch,
			width/2,
			-1
		]) {
			cylinder(
				r=bolt,
				h=thickness+2
			);
		}
		translate([
			offset + (length-offset)/2,
			width/2,
			-1
		]) {
			cylinder(
				r=hole,
				h=thickness+2
			);
		}
		translate([
			offset + (length-offset)/2-hole,
			-1,
			-1
		]) {
			cube([
				hole*2,
				width/2+1,
				thickness+2
			]);
		}
		translate([
			offset + (length-offset)/2,
			width/2,
			mount_height
		]) {
			cylinder(
				r=mount,
				h=thickness+2
			);
		}
		translate([
			offset + (length-offset)/2-mount,
			-1,
			mount_height
		]) {
			cube([
				mount*2,
				width/2+1,
				thickness+2
			]);
		}
	}
}	