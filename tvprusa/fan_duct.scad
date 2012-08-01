/*
 * fan duct
 *
 * Ducts the air to just below the hotend whilst taking the minimum of space.
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 *
 * Inspired by Michel Pollet <buserror@gmail.com>
 */
$fn=20;

fan40 = 40;
fan40_pitch = 32;
m3 = 3.6 / 2;
m3_nut = 6.2/2;

difference() {
	torus();
	vortex();
}
translate([15,0,0]) {
	fan_mount();
}

module fan_mount(
	r = 26,
	r2=4,
	mount = fan40,
	pitch = fan40_pitch,
	thickness = 1.1,
	height = 33,
	offset = 52.6+5,
	drop = 3,
	depth =10,
	bolt = m3,
	nut = m3_nut,
) {
	translate([
		0,
		0,
		-height + depth+thickness*2
	]) {
		difference() {
			translate([
				r+r2,
				-mount/2,
				height - thickness -thickness - depth,
			]) {
				cube([
					offset-r-r2+mount/2,
					mount,
					thickness*2 + depth,
				]);
			}
			translate([
				r-r2-1,
				-mount/2-1,
				height-drop,
			]) {
				cube([
					offset-r-mount/2+1+r2,
					mount+2,
					drop+1,
				]);
			}
			translate([
				 + offset,
				0,
				height - thickness  - depth,
			]) {
				cylinder(
					r = mount/2-thickness,
					h = thickness+ depth +1
				);
			}
			translate([
				r,
				-depth,
				height - thickness  - depth,
			]) {
				cube([
					offset-r,
					depth*2,
					depth-drop,
				]);
			}
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						offset - pitch/2 + pitch*x,
						-pitch/2 + pitch *y,
						height - thickness -thickness - depth-1,
					]) {
						cylinder(
							r = bolt,
							h = thickness*2 + depth+2
						);
						cylinder(
							r = nut,
							h = depth-2*thickness+1,
							$fn=6
						);
					}
				}
			}
		}
		difference() {
			difference() {
				translate([
					r+ mount/2 + r2,
					0,
					height - thickness -thickness - depth,
				]) {
					cylinder(
						r = mount/2 + r2*2+thickness,
						h = thickness*2 + depth-drop
					);
				}
				translate([
					r+  r2,
					-mount,
					-1,
				]) {
					cube([
						mount*2,
						mount*2,
						height+2,
					]);
				}
			}
			intersection() {
				cylinder(
					r = r + r2,
					h = height-thickness-drop
				);
				translate([
					r+mount/2 + r2,
					0,
					0,
				]) {
					cylinder(
						r = mount/2 + r2*2,
						h = height-thickness
					);
				}
			}
			translate([
				r,
				-depth,
				height - thickness  - depth-drop,
			]) {
				cube([
					offset-r,
					depth*2,
					depth,
				]);
			}
		}
	}
}
	
module torus(
	r = 26,
	r2 = 4,
	thickness = 1.1,
	mount = fan40,
	height = 33,
	drop = 3,
	depth =10,
){
	difference() {
		union() {
			rotate_extrude() {
				translate([
					r,
					r2/2,
					0
				]) {
					difference() {
						circle(
							r = r2
						);
						translate([
							-r2-1,
							-(r2*2+1)+r2/2,
							0,
						]) {
							square([
								r2*2+1,
								r2+1,
							]);
						}
					}
				}
			}
			intersection() {
				cylinder(
					r = r + r2,
					h = height-drop-thickness*2
				);
				translate([
					r + mount/2 + r2,
					0,
					0,
				]) {
					cylinder(
						r = mount/2 + r2*2,
						h = height-drop-thickness*2
					);
				}
			}
		}
		rotate_extrude() {
			translate([
				r,
				r2/2,
				0
			]) {
				difference() {
					circle(
						r = r2-thickness
					);
					translate([
						-r2-1,
						-(r2*2+1)+r2/2+thickness,
						0
					]) {
						square([
							r2*2+1,
							r2+1,
						]);
					}
				}
			}
		}
		intersection() {
			translate([
				0,
				0,
				thickness,
			]) {
				cylinder(
					r = r + r2-thickness,
					h = height-drop-thickness
				);
			}
			translate([
				r + mount/2 + r2,
				0,
				thickness,
			]) {
				cylinder(
					r = mount/2 + r2*2-thickness,
					h = height-drop-thickness
				);
			}
		}
		translate([
			r,
			-depth,
			height - thickness- depth,
		]) {
			cube([
				r2+1,
				depth*2,
				depth,
			]);
		}
	}

}

module vortex(
	r=26,
	r2=4,
	count = 20,
	hole_r = 2,
	angle = [10,70,0],
) {
	for (i = [0:count]) {
		rotate([
			0,
			0,
			i * (360 / count),
		]) {
			translate([
				r-r2, 
				0,
				r2/4,
			]) {
				rotate(angle) {
					cylinder(
						r = hole_r,
						h = r2+1
					);
				}
			}
		}
	}
}	
