/*
 * Holder for 18mm snap-off blades
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>;

knife();
if(preview==0) {
			catch();
} else {
	translate([
		0,
		-10,
		.5
	]) {
		rotate([
			180,
			0,
			0
		]) {
			catch();
		}
	}
}


module catch(
	blade=[
		100,
		18,
		.5
	],
	round = 4,
	handle = [
		10,
		21,
		1
	],
	dot = 4.5/2
) {
	translate([
		handle[1]/3,
		blade[1]/2,
		.5
	]) {
		cylinder(
			r = dot,
			h = handle[2]+blade[2]
		);
	}
	difference() {
		intersection() {
			translate([
				2,
				0,
				blade[2]+1,
			]) {
				cube([
					handle[1],
					blade[1],
					round-1,
				]);
			}
			union() {
	
				translate([
					-round-1,
					-round+(blade[1]+round*2-blade[1])/2,
					blade[2]/2
				]) {
					translate([
						handle[1],
						0,
						blade[2]-.01,
					]) {
						rotate([
							0,
							-90,
							0
						]) {
							linear_extrude(
								height = handle[1]
							) {
								polygon([
									[0,0],
									[sin(60)*blade[1],cos(60)*blade[1]],
									[0,blade[1]],
								]);
							}
						}
					}
				}
				for(y=[0:(handle[1]-4)/3]) {
					translate([
						y*3,
						0,
						0
					]) {
						rotate([
							-30,
							0,
							0
						]) {
							cylinder(
								r=1,
								h=10
							);
						}
					}
					translate([
						y*3,
						blade[1],
						0
					]) {
						rotate([
							30,
							0,
							0
						]) {
							cylinder(
								r=1,
								h=10
							);
						}
					}
				}
			}
		}
		for(x=[0:4]) {
			translate([
				round + .5+x*2,	
				round,
				round
			]) {
				cube([
					1,
					handle[0],
					1
				]);
			}
		}
	}
}

module knife(
	blade=[
		100,
		18.5,
		.5
	],
	round = 4,
	handle = [
		10,
		50,
		1
	]
) {

	difference() {
		minkowski() {
			cube([
				blade[0]+15,
				blade[1],
				blade[2]*2
			]);
			sphere(
				r = round
			);
		}
		translate([
			-round-1,
			-round+(blade[1]+round*2-blade[1])/2,
			blade[2]/2
		]) {
			cube([
				blade[0]+30,
				blade[1],
				blade[2]+.5
			]);
			translate([
				blade[0]+10,
				0,
				blade[2]-.01,
			]) {
				rotate([
					0,
					-90,
					0
				]) {
					linear_extrude(
						height = blade[0]+10 +1
					) {
						polygon([
							[0,0],
							[sin(60)*blade[1],cos(60)*blade[1]],
							[0,blade[1]],
						]);
					}
				}
			}
		}
		translate([
			-round-1,
			(blade[1]+round*2-handle[0])/2-round,
			blade[2]/2-handle[2]
		]) {
			cube([
				blade[0]+10,
				handle[0],
				blade[2]*2+round*2
			]);
		}
		for(y=[0:(blade[0]+3)/3]) {
			translate([
				y*3,
				0,
				0
			]) {
				rotate([
					-30,
					0,
					0
				]) {
					cylinder(
						r=1,
						h=10
					);
				}
			}
			translate([
				y*3,
				blade[1],
				0
			]) {
				rotate([
					30,
					0,
					0
				]) {
					cylinder(
						r=1,
						h=10 
					);
				}
			}
		}
	}
}