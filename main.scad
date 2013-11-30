/*
 * Selective Laser Sintering
 *
 * Copyright 2013 <b@Zi.iS>, <richard.ibbotson@btinternet.com>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <MCAD/involute_gears.scad>
use <scadhelper/vitamins/coupling.scad>
use <scadhelper/vitamins/rod.scad>
use <scadhelper/vitamins/hardware.scad>
use <scadhelper/vitamins/nema.scad>
use <scadhelper/vitamins/2d.scad>
use <scadhelper/vitamins/bearing.scad>
use <scadhelper/vitamins/linear_bearing.scad>
use <feed.scad>

sls();

*translate([
	-100/2,
	-250/2,
	-150
]) #cube([130, 250, 200]);

module sls(
	size = [
		50,
		50,
		50
	],
	drive_rod = 6,
    slide_rod = 8,
    feed_rod = 8,
	motor = [
		17,		//Size
		20,		//Shaft length
		5		//Shaft diameter
	],
	coupling = 20,
	roller = 20,
	chain_gear = [
		10,		//teeth
		6,		//ID
		12.8,	//OD
		10,		//hub h
		2.6   	//h
	],
	roller_gear = [
		20,
		8.1,
		20,
		13.25,
		2.6
	],
	chain = [
		6,		//pitch
		7.8		//material[0]
	],
	motor_depth = 150,
	bed_height = 100,
	material = [
		6,
		"STEEL",
		[color_steel[0], color_steel[1], color_steel[2], .5]
	],
	bolt = 3,
	length = 250,
	id = 0
) {
	width = size[1]*3 + material[0]*6;
	gear_pitch = real_gear_pitch(
		chain[0]*chain_gear[0] / (2*PI),
		(size[1]*1.5 + material[0]*3)*2 + roller*2,
		chain
	);
	guide_pitch = size[0]/2
		+ material[0]*2.5
		+ (chain[1] + roller_gear[4])/2
		+ roller_gear[3]
		+ 1
		+ slide_rod*1.5
		+ size[0]/2
		+ slide_rod*2
		+ 2
	;
	gear_r = chain[0]*chain_gear[0] / (2*PI);
	roller_r = chain[0]*roller_gear[0] / (2*PI);

	translate([
		0,
		-width/2 + width*$t,
		roller/2
	] * preview) {
		roller(
			r = roller/2,
			h = size[1],
			gear_depth = material[0]*2.5 + (chain[1] + roller_gear[4])/2,
			rod = slide_rod,
			chain = chain,
			chain_gear = chain_gear,
			roller_gear = roller_gear,
			pos = 360/(roller*PI)*$t*width + 360/chain_gear[0]/3, //Contra-rotate at double speed
			id = id 
		);
	}

	//Guide rods
	for(i=[0:1]) {
		translate([
			size[0]/2
				+ material[0]*2.5
				+ (chain[1]
				+ roller_gear[4])/2
				+ roller_gear[3]
				+ 2
				+ slide_rod*1.5
				- guide_pitch * i,
			length/2,
			roller/2
		] * preview) {
			rotate([
				90,
				0,
				0
			] * preview) {
				rod(
					r = slide_rod/2,
					h = length,
					id = id + 5 + i
				);
			}
		}
	}

	//Rod supports
	for(i=[0:1]) {
		translate([
						size[0]/2
						+ material[0]*2.5
							+ (chain[1] + roller_gear[4])/2
							+ roller_gear[3]
							+ 2
							+ slide_rod*1.5	
							- guide_pitch/2,
			(length)/2
			 - (length -material[0])*i,
			roller/2
		] * preview) {
			rotate([
				90,
				0,
				0
			] * preview) {
				2d(
					[
						guide_pitch
							+ slide_rod*2,
						slide_rod*2,
					],
					material = material,
					id = id + 7 + i
				) {
					union() {
						translate([
								size[0]/2
								+ material[0]*3
								+ (chain[1] + roller_gear[4])/2
								+ roller_gear[3]
								+ bolt/2
								+ slide_rod*1.5
								+ 1
								- guide_pitch/2,
								0,
								0
						]) {
							kerf_cylinder(
								r = bolt/2,
								h = material[0]
							);
						}
						for(y=[0:1]) {
							translate([
								-guide_pitch/2+ guide_pitch*y,
								0,
								0
							]) {
								kerf_cylinder(
									r = slide_rod/2,
									h = material[0]
								);
							}
						}
					}
				}
			}
		}
	}

	//Support rods 
	for(i=[0:1]) {
		translate([
			size[0]/2 + material[0],
			-(gear_pitch-gear_r*6)/2 + (gear_pitch-gear_r*6)*i,
			roller/2 + roller_r + gear_r
		]) {
			rotate([
				0,
				90,
				0
			]) {
				rod(
					r = drive_rod/2,
					h = motor_depth - size[0]/2 - material[0],
					id = id + 9 + i
				);
			}
		}
		translate([
			size[0]/2 + material[0],
			-(length-drive_rod*3)/2 + (length-drive_rod*3)*i,
			-bed_height+drive_rod*1.5
		]) {
			rotate([
				0,
				90,
				0
			]) {
				rod(
					r = drive_rod/2,
					h = motor_depth - size[0]/2 - material[0],
					id = id + 11 + i
				);
			}
		}
	}

	//Chain
	translate([
		size[0]/2 + material[0]*2.5,
		0,
		roller/2
	] * preview) {
		dual_chain(
			gear_pitch = gear_pitch,
			chain = chain,
			chain_gear = chain_gear,
			roller_gear = roller_gear,
			rod = drive_rod,
			motor_depth = motor_depth - size[0]/2 - material[0]*3,
			motor = motor,
			coupling = coupling,
			pos1 = $t*width - (chain_gear[0]*chain[0])/(roller*PI)*$t*width*2,
			pos2 = -$t*width - (chain_gear[0]*chain[0])/(roller*PI)*$t*width*2,
			id = id + 13
		);
	}

	//Feed
	for(i=[-1:1]) {
		translate([
			0,
			i*(size[1] + material[0]*2),
			0,
		] * preview) {
			feed(
				size = size,
				rod = feed_rod,
				material = material,
				t = (i == 0 ? $t : 1-$t),
				bolt = bolt,
				id = id + 24+16+16*i
			) {
				union() {
						translate([
							0,
							0,
							3.5
						] * preview) {
							bearing60(
								drive_rod,
								id = id + 24+16+16*i + 13
							);
						}
						rod(
							drive_rod/2,
							h = motor_depth - coupling/2 - motor[1] - 32.5,
							id = id + 24+16+16*i + 14
						) {
							coupling(
								h = coupling,
								d1 = drive_rod,
								d2 = motor[2],
								id = id + 24+16+16*i + 15
							) {
								rotate([
									180,
									0,
									0
								] * preview) {
									translate([
										0,
										0,	
										-motor[1]
									] * preview) {
										nema(
											motor = motor,
											id = id + 24+16+16*i + 16
										);
									}
								}
							}
						}
				}
			}
		}
	}

	//Feed Supports
	translate([
		0,
		0,
		-feed_length(size, material, feed_rod) 
	] * preview) {
		translate([
			size[1]/2+material[0]*2,
			0,
			0
		] * preview) {
			rotate([
				0,
				90,
				0
			] * preview) {
				2d(
					[
						30,
						width + material[0]*2 + bolt*6,
					],
					material = material,
					id = id + 73
				) union() {
					for(x=[-2.8,-1,1,2.8]) {
						translate([
							material[0],
							(size[1]/2 + material[0]) * x,
							0
						]) {
							kerf_cylinder(
								r = bolt/2,
								h = material[0]
							);
						}
					}
					for(x=[0:1]) {
						for(y=[0:1]) {
							translate([
								-10 + 20*y,
								-(width + material[0]*2 + (bolt*3))/2 + (width + material[0]*2 + bolt*3)*x,
								0
							]) {
								kerf_cylinder(
									r = bolt/2,
									h = material[0]
								);
							}
						}
					}
					for(i=[-1:1]) {
						translate([
							-material[0]/2,
							i*(size[1] + material[0]*2),
							0
						]) {
							kerf_cylinder(
								r = (drive_rod + bearing60_offset(drive_rod))/2,
								h = material[0]
							); 
						}
					}
				}
			}
		}
		translate([
			material[0]*.5,
			0,
			-material[0]*2
		] * preview)
		2d(
			[
				size[0] + material[0]*3,
				width,
			],
			material = material,
			id = id + 74
		) union() {
			for(i=[-1:1]) {
				translate([
					15,
					-10+i*(size[1] + material[0]*2),
					0
				]) {
					kerf_cube([
						30,
						20,
						material[0]
					]);
				}		
				translate([
					-(size[0] + material[0]*3)/2-.1,
					-ease(feed_rod)/2+i*(size[1] + material[0]*2),
					0
				]) {
					kerf_cube([
						(size[0] + material[0]*3)/2 + .1,
						ease(feed_rod),
						material[0]
					]);
				}
			}
		}
	}

	//Backplate
	rotate([
		0,
		90,
		0
	] * preview) {
		translate([
			bed_height/2 - (roller/2  + roller_gear[0] + chain_gear[0]*2 )/2,
			0,
			size[1]/2 + material[0]
		] * preview) {
			2d(
				[
					bed_height + roller/2 + roller_gear[0] + chain_gear[0]*2,
					length
				],
                material = material,
				id =id + 75
			) union() {
				//roller slot
				translate([
					-bed_height/2 + (roller/2  + roller_gear[0] + chain_gear[0]*2)/2 - roller + drive_rod-.5,
					-(width + slide_rod*2)/2,
					0
				]) {
					kerf_cube([
						slide_rod + 1,
						width + drive_rod*2,
						material[0]
					]);
				}
				//chain bearings
				for(x=[0:1]) {
					for(y=[0:1]) {
						translate([
							-bed_height/2
								+ (roller/2
									+ roller_gear[0]
									+ chain_gear[0]*2
								)/2
								- roller/2
								- roller_r
								- gear_r
								+ (roller_r + gear_r)*2*y
							,
							-gear_pitch/2 + gear_pitch*x,
							0
						]) {
							kerf_cylinder(
								r = (drive_rod + bearing60_offset(drive_rod))/2,
								h = material[0]
							);
						}
					}
				}
				//Feed drive slot
				translate([
					-bed_height/2 + (roller/2  + roller_gear[0] + chain_gear[0]*2)/2 + feed_length(size, material, drive_rod) - 30/2,
					-(width + drive_rod*2)/2,
					0
				]) {
					kerf_cube([
						30,
						width + material[0]*2,
						material[0]
					]);
				}
				//Feed drive bolt slots
				for(i=[0:1]) {
					translate([
						-bed_height/2 + (roller/2  + roller_gear[0] + chain_gear[0]*2)/2 + feed_length(size, material, drive_rod) - 40/2,
						-(width + material[0]*2 + bolt*4)/2 + (width + material[0]*2 + bolt*3)*i,
						0
					]) {
						kerf_cube([
							40,
							bolt,
							material[0]
						]);
					}
				}
				//Rail support slots
				for(i=[0:1]) {
					translate([
						-bed_height/2 + (roller/2  + roller_gear[0] + chain_gear[0]*2)/2 - roller/2 - slide_rod,
						(length )/2
							 - (length -material[0])*i - material[0],
						0,
						
					]) {
						kerf_cube([
							slide_rod*2,
							material[0],
							material[0]
						]);
					}
				}
				//support rods
				for(i=[0:1]) {
					translate([
						-(roller/2  + roller_gear[0] + chain_gear[0]*2 )/2-(roller/2 + roller_r + gear_r),
						-(gear_pitch-gear_r*6)/2 + (gear_pitch-gear_r*6)*i,
						0,
					]) {
						kerf_cylinder(
							r = drive_rod/2,
							h =  material[0]
						);
					}
					translate([
						-(roller/2  + roller_gear[0] + chain_gear[0]*2 )/2-(-bed_height+drive_rod*1.5),
						-(length-drive_rod*3)/2 + (length-drive_rod*3)*i,
						0,
					]) {
						kerf_cylinder(
							r = drive_rod/2,
							h = material[0]
						);	
					}
				}
			}
		}
	}


	//Motor plate
	rotate([
		0,
		90,
		0
	] * preview) {
		translate([
			bed_height/2 - (roller/2  + roller_gear[0] + chain_gear[0]*2 )/2,
			0,
			motor_depth - material[0]
		] * preview) {
			2d(
				[
					bed_height + roller/2 + roller_gear[0] + chain_gear[0]*2 + 20,
					gear_pitch + nema_faceplate(motor[0])[0]
				],
                material = material,
				id = id + 76
			) union() {
				//chain drives
				for(x=[0:1]) {
					for(y=[0:1]) {
						translate([
							-bed_height/2
								+ (roller/2
									+ roller_gear[0]
									+ chain_gear[0]*2
								)/2
								- roller/2
								- roller_r
								- gear_r
								+ (roller_r + gear_r)*2*y
							,
							-gear_pitch/2 + gear_pitch*x,
							0
						]) {
							nema_faceplate_drill(motor);
						}
					}
				}
				
				//support rods
				for(i=[0:1]) {
					translate([
						-(roller/2  + roller_gear[0] + chain_gear[0]*2 )/2-(roller/2 + roller_r + gear_r),
						-(gear_pitch-gear_r*6)/2 + (gear_pitch-gear_r*6)*i,
						0,
					]) {
						kerf_cylinder(
							r = drive_rod/2,
							h =  material[0]
						);
					}
					translate([
						-(roller/2  + roller_gear[0] + chain_gear[0]*2 )/2-(-bed_height+drive_rod*1.5),
						-(length-drive_rod*3)/2 + (length-drive_rod*3)*i,
						0,
					]) {
						kerf_cylinder(
							r = drive_rod/2,
							h = material[0]
						);	
					}
				}

				//Feed Drives
				for(i=[-1:1]) {
					translate([
						-(roller/2  + roller_gear[0] + chain_gear[0]*2 )/2 + feed_length(size, material, feed_rod) ,
						i*(size[1] + material[0]*2),
						0,
					]) {
						nema_faceplate_drill(motor);
					}
				}

			}
		}
	}
}

function feed_length(size, material, rod) = material[0]*2.5
	+ size[2]
	+ 16.5 + material[0]/2
;

module simple_gear(
	r,
	gear,
	id
) {
	pitch = r * 360 / gear[0];
	part(id, str(r, "x", gear[3], "mm ", gear[0], " tooth gear")) {
		color(color_steel) {
			gear(
				number_of_teeth = gear[0],
				circular_pitch = pitch,
				gear_thickness = gear[4],
				rim_thickness = gear[4],
				hub_thickness = gear[3],
				hub_diameter = gear[2],
				bore_diameter = gear[1]
			);
		}
	}
	translate([
		0,
		0,
		gear[3]
	] * preview) {
		if($children>0) for (i = [0 : $children-1]) child(i);
	}
}

module roller(
	r,
	h,
	gear_depth,
	rod,
	chain,
	chain_gear,
	roller_gear,
	pos,
	id
) {
	gear_r = chain[0]*roller_gear[0] / (2*PI);

	rotate([
		pos,
		0,
		0
	] * preview)
	rotate([
		0,
		90,
		0
	] * preview) {
		translate([
			0,
			0,
			-h/2 - rod*3 -1
		] * preview) {
			rotate([
				0,
				0,
				-pos
			] * preview) {
				sliding_block(
					rod = rod,
					id = id + 1
				);
				translate([-25-4,0,135/2-2]*preview)
					rotate([90,0,0]*preview) 2d(
					[
						50,
						135
					],id=999
				) {
					union() {translate([-15,-95/2,0]) kerf_cube([50,95,6]);
					translate([20,95/2+20/3,0]) kerf_cylinder(r=3/2, h=60);
translate([20,95/2+(20/3)*2,0]) kerf_cylinder(r=3/2, h=60);

					translate([20,-95/2-20/3,0]) kerf_cylinder(r=3/2, h=60);
translate([20,-95/2-(20/3)*2,0]) kerf_cylinder(r=3/2, h=60);
					}
				}
			}
			translate([
				0,
				0,
				2*rod
			] * preview) {
				translate([
					0,
					0,
					rod + 1
				] * preview) {
					part(id+2, str(r, "x", h, "mm roller")) {
						translate([
							0,
							0,
							-(rod + 1)
						] * preview) {
							color([1,1,1]) cylinder(
								r = 8/2,
								h = h + gear_depth - roller_gear[4] + roller_gear[3] + rod*2 + 2
							);
						}
						translate([0,0,.1]) color([1,1,1]) difference() {
							cylinder(r = r+.1, h = h);
							e() cube([r, r, h]);
							e() translate([-r, -r, 0]) cube([r, r, h]);
						}
						color([1,0,0]) intersection() {
							cylinder(r = r, h = h);
							union() {
								e() cube([r, r, h]);
								e() translate([-r, -r, 0]) cube([r, r, h]);
							}
						}
					}
					translate([
						0,
						0,
						h + gear_depth - roller_gear[4]
					] * preview) {
		
						simple_gear(
							r = gear_r,
							gear = roller_gear,
							id = id+3
						) {
							translate([
								0,
								0,
								1 + rod*3
							] * preview) {
								rotate([
									180,
									0,
									-pos
								] * preview) {
									sliding_block(
										rod = rod,
										id = id+4
									);
								}
							}
						}
					}
				}
			}
		}
	}
}

module sliding_block(
	rod,
	id
) {
	part(id, str("Sliding block")) color(color_plastic) difference() {
		translate([
			-rod,
			-rod,
			0
		]) {
			cube([
				rod*2,
				rod*2,
				rod*3
			]);
		}
		translate([
			0,
			0,
			rod*2
		]) {
			e() cylinder(
				r = rod/2,
				h = rod
			);
		}
		translate([
			0,
			-rod-.1,
			rod
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				#e() cylinder(
					r = rod/2,
					h = rod*2+.2
				);
			}
		}
	}
}

function real_gear_pitch(gear_r, gear_pitch, chain) = ((ceil((2*PI*gear_r + gear_pitch*2)/chain[0]) * chain[0]) - 2*PI*gear_r)/2;

module dual_chain(
	gear_pitch,
	chain,
	chain_gear,
	roller_gear,
	rod,
	motor_depth,
	motor,
	coupling,
	pos1 = 0,
	pos2 = 0,
	id
) {
	gear_r = chain[0]*chain_gear[0] / (2*PI);
	roller_r = chain[0]*roller_gear[0] / (2*PI);
	chain_length = ceil((2*PI*gear_r + gear_pitch*2)/chain[0]) * chain[0];
	real_gear_pitch = real_gear_pitch(gear_r, gear_pitch, chain);
	chain_links = chain_length/chain[0];

	rotate([
		0,
		90,
		0
	] * preview) {	
		for(z=[0:1]) {
			part(id+z, str(chain_length, "mm of ", chain[0], "mm pitch chain")) {
				for(i=[0:chain_links-1]) {
					translate([
						 -roller_r  + gear_r*2*z + roller_r*2*z,
						0,
						0
					]) {
						chain(
							pos = i*chain[0] + pos1*(1-z) + pos2*z + chain[0]/2,
							gear_pitch = real_gear_pitch,
							gear_r = gear_r
						) {
							color(i%5==0 ? [1,0,0] : [1,1,1]) cylinder(
								r = chain[2]/3/2,
								h = chain[1]
							);
						}
					}
				}
			}

			for(x=[0:1]) {
			
				translate([
					-gear_r -roller_r  + gear_r*2*z + roller_r*2*z,
					-real_gear_pitch/2 + real_gear_pitch*x,
					(chain[1] - chain_gear[4])/2
				] * preview) {
					rotate([
						0,
						0,
						(360/(chain[0]*chain_gear[0]))*pos1*(1-z)+(360/(chain[0]*chain_gear[0]))*pos2*z
					] * preview) {
						simple_gear(
							r = gear_r,
							gear = chain_gear,
							id = id+2+2*z+x
						);
					}
					if(x==z) {
						rod(
							rod/2,
							motor_depth - coupling/2 - motor[1],
							id = id+6+x
						) {
							coupling(
								h = coupling,
								d1 = rod,
								d2 = motor[2],
								id = id+8+x
							) {
								rotate([
									180,
									0,
									0
								] * preview) {
									translate([
										0,
										0,	
										-motor[1]
									] * preview) {
										nema(
											motor = motor,
											id = id+10+x
										);
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

module chain(
	pos = 0,
	gear_pitch,
	gear_r
) {
	chain_length = 2*PI*gear_r + gear_pitch*2;
	link_pos = (pos + chain_length*10) % chain_length; //HACK
	translate([
		 (
			link_pos < gear_pitch ?
				0
			:
				link_pos < gear_pitch + PI*gear_r ?
					-gear_r + cos((link_pos-gear_pitch)/(2*PI*gear_r)*360) * gear_r
				:
					link_pos < gear_pitch + PI*gear_r + gear_pitch ?
						-gear_r*2
					:
						-gear_r - cos((link_pos-gear_pitch*2 - PI*gear_r)/(2*PI*gear_r)*360) * gear_r
		),
		-gear_pitch/2 + (
			link_pos < gear_pitch ?
				link_pos
			:
				link_pos < gear_pitch + PI*gear_r ?
					gear_pitch + sin((link_pos-gear_pitch)/(2*PI*gear_r)*360) * gear_r
				:
					link_pos < gear_pitch + PI*gear_r + gear_pitch ?
						gear_pitch - (link_pos - gear_pitch - PI*gear_r)
					:
						-sin((link_pos-gear_pitch*2 - PI*gear_r)/(2*PI*gear_r)*360) * gear_r
		),
		0
	]) {
		if($children>0) for (i = [0 : $children-1]) child(i);
	}
}
