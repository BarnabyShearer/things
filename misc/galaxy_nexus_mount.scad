/*
 * Galaxy Nexus Mount
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0.
 *
 */

thickness = 1.1;
depth = 15;

mount_width=30;
mount_height=43;
mount_offset=45;
mount_lip = 2.4;
mount_depth = 2.4;
mount_thickness=2.7;
mount_overhang = 4;
mount_size = 5;
mount_pitch_x = 19.5;
mount_pitch_y = 24;
mount_print = sqrt(pow((mount_overhang-mount_thickness),2)*2);

horn=25;

difference() {

	union() {

		//Case
		cube([
			135.3+2*thickness,
			depth,
			70
		]);
		translate([
			mount_offset,
			depth,
			0
		]) {
			cube([
				mount_width,
				mount_lip+mount_depth,
				mount_height+mount_size
			]);
		}

		//Horn
		difference() {
			cylinder(
				r=horn,
				h=70
			);
			translate([
				-horn,
				-horn,
				-1
			]) {
				cube([
					horn*2,
					horn,
					72
				]);
			}
			intersection(){
				translate([
					0,
					0,
					thickness
				]) {
					cylinder(
						r=horn-thickness*2,
						h=70-thickness*2
					);
				}
				translate([
					-83,
					-30,
					72/2-thickness
				]) {
					rotate([
						0,
						45,
						0
					]) {
						cube([
							72,
							72,
							72
						]);
					}
				}
			}
		}
	}




	//Phone
	translate([
		thickness,
		thickness,
		thickness
	]) {
		linear_extrude(100) {
			polygon([
				[0,0],
				[0,10],
				[14,12.3],
				[100,10],
				[123,10],
				[133,8],
				[135.3,3.5],
				[135.3,0],
			]);
		}
	}

	//Screen
	translate([
		thickness+4.5,
		-1,
		1
	]) {
		cube([
			135.3-4.5*2,
			thickness+2,
			70
		]);
	}

	// Power button
	translate([
		95,
		-1,
		-1
	]) {
		cube([
			15,
			8+1,
			thickness+2
		]);
	}

	//Flash
	translate([
		106.5,
		50,
		35
	]) {
		rotate([
			90,
			0,
			0
		]) {
			cylinder(
				r=7/2,
				h=100
			);
		}
	}

	//Camera
	translate([
		116.5,
		50,
		35
	]) {
		rotate([
			90,
			0,
			0
		]) {
			cylinder(
				r=12/2,
				h=100
			);
		}
	}

	//Speeker
	translate([
		12,
		16,
		35
	]) {
		rotate([
			90,
			0,
			0
		]) {
			cylinder(
				r=12/2,
				h=12
			);
		}
	}

	//USB
	translate([
		-thickness,
		3,
		thickness+29
	]) {
		cube([
			2+thickness,
			5,			
			9,
		]);
	}

	//Hollow
	translate([
		mount_offset+thickness,
		depth,
		thickness
	]) {
		cube([
			mount_width-thickness*2,
			mount_depth,
			mount_height+mount_size
		]);
	}

	//Fixings
	for(x=[0:1]) {
		for(y=[0:1]) {
			translate([
				mount_offset+(mount_width-mount_pitch_x-mount_overhang)/2 + mount_pitch_x*x,
				depth+mount_depth-1,
				(mount_height-mount_pitch_y-mount_size*2)/2+mount_pitch_y*y
			]) {
				cube([
					mount_overhang,
,					mount_lip+2,
					mount_size,
				]);
			}
			translate([
				mount_offset+(mount_width-mount_pitch_x-mount_overhang)/2 + mount_pitch_x*x+(mount_overhang-mount_thickness)*x,
				depth+mount_depth-1,
				(mount_height-mount_pitch_y-mount_size*2)/2+mount_pitch_y*y+mount_size
			]) {
				cube([
					mount_thickness,
					mount_lip+2,
					mount_size,
					
				]);
			}
			
			translate([
				mount_offset+(mount_width-mount_pitch_x-mount_overhang)/2+mount_overhang-sqrt(pow(mount_print,2)*2)+ (mount_pitch_x-mount_thickness+sqrt(pow(mount_print,2)*2)/2)*x,
				depth+mount_depth-1,
				(mount_height-mount_pitch_y-mount_size*2)/2+mount_pitch_y*y+mount_size
			]) {
				rotate([
					0,
					45,
					0
				]) {
					cube([
						mount_print,
						mount_lip+2,
						mount_print,
					]);
				}
			}
		}
	}
}
