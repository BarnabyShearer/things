/*
 * y bushing
 *
 * Mount bed directly on y-rods. Reduces moving mass, ensures rigidity,
 * increases print height.
 * 
 * Copyright 2012 <b@Zi.iS>
 * License GPLv2
 *
 * Based on http://www.thingiverse.com/thing:4434 by whosawhatsis
 */
$fn = 60;

m8 = 8/2;
m3 = 3.6/2;
m3_nut = 6.1 /2;

mount();

module mount(
	rod = m8,
	height = 23,
	length = 10,
	pitch = 31,
	bolt = m3,
	nut = m3_nut,
	thickness = 3,
	bushing_thickness = 1
) {
	bushing(
		rod = rod,
		length = length,
		width = rod*4,
		height = height,
		thickness = bushing_thickness
	);

	width = pitch + length;

	difference() {
		translate([
			-width/2,
			height - thickness,
			0
		]) {
			cube([
				width,
				thickness,
				length
			]);
		}
		translate([
			-width/2+length/2,
			height+1,
			length/2
		]) {
			rotate( [90, 22.5, 0] ) {
				cylinder(
					h = thickness+2,
					r = bolt
				);
			}
		}
		translate([
			-width/2+length/2+pitch,
			height+1,
			length/2
		]) {
			rotate( [90, 22.5, 0] ) {
				cylinder(
					h = thickness+2,
					r = bolt
				);
			}
		}
		translate([
			-width/2+length/2,
			height-thickness/3*2,
			length/2
		]) {
			rotate( [90, 0, 0] ) {
				cylinder(
					h = thickness,
					r = nut,
					$fn = 6
				);
			}
		}
		translate([
			-width/2+length/2+pitch,
			height-thickness/3*2,
			length/2
		]) {
			rotate( [90, 0, 0] ) {
				cylinder(
					h = thickness+2,
					r = nut,
					$fn = 6
				);
			}
		}
	}
}
module bushing(
	rod = m8,
	length = m8*3,
	width = m8*4,
	height = m8*2,
	thickness = 1
) {
	linear_extrude(
		height = length,
		convexity = 5
	) {
		difference() {
			union() {
				translate([
					-width / 2,
					0,
					0
				]) {
					square(
						[
							width,
							height
						]
					);

				}
				circle(
					width /2
				);
			}
			
			rotate(45) {
				square(
					center = true,
					rod*2
				);
			}
			intersection() {
				for(a = [0:2]) {
					rotate(45 + 90 * (a-1)) {
						translate([
							width / 4 + thickness/2,
							width / 4 + thickness/2,
							0
						]) {
							square(
								center = true,
								width / 2
							);
						}
					}
				}
				circle(
					center = true,
					width /2 - thickness
				);
			}
			
			rotate(45 + 180) {
				translate([
					width / 4 + thickness/2,
					width / 4 + thickness/2,
					0
				]) {
					square(
						center = true, 
						width / 2
					);
				}
			}
		}
	}
}

