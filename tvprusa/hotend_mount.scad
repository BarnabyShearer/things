/*
 * hotend mount
 *
 * NOTE: This needs to be milled out of a rigid heat resistant material.
 * It is tested with MDF.
 *
 * Mounts a j-head hotend via the notch at the top of barrel.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn=60;

m4 = 4.6/2;

translate([
	0,
	0,
	-6.5
]) {
	support1();
}
translate([
    75,
    0,
    -6.5
]) {
	support2();
}

module support1(
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
		union() {
			cube([
				length,
				width,
				thickness
			]);
			//Lip to help mill outline (remove if not milling)
			translate([
				-3,
				-3,
				0
			]) {
				cube([
					length+6,
					width+6,
					1
				]);
			}
		}

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

module support2(
	length = 70,
	width = 28,
	thickness = 6.5,
	bolt = m4,
	offset = 8,
	pitch = 50,
	mount = 17.5/2,
	hole = 12/2,
	step = 3-.2,
	step_inset = 4.6,
) {
	difference() {
		union() {
			cube([
				length,
				width,
				thickness
			]);
			//Lip to help mill outline (remove if not milling)
			translate([
				-3,
				-3,
				0
			]) {
				cube([
					length+6,
					width+6,
					1
				]);
			}
		}

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
				r=mount,
				h=thickness+2
			);
		}
		translate([
			-1,
			-1,
			thickness-step
		]) {
			cube([
				1+offset + (length-offset-pitch)/2+step_inset,
				width+6,
				step+1
			]);
		}
		translate([
			offset + (length-offset-pitch)/2-step_inset+pitch,
			-1,
			thickness-step
		]) {
			cube([
				100,
				width+6,
				step+1
			]);
		}
	}
}	
