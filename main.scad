/*
 * Selective Laser Sintering
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <scadhelper/vitamins/coupling.scad>;
use <scadhelper/vitamins/rod.scad>;
use <scadhelper/vitamins/hardware.scad>;
use <scadhelper/vitamins/nema.scad>;
use <scadhelper/vitamins/mdf.scad>;
use <scadhelper/vitamins/bearing.scad>;
use <scadhelper/vitamins/linear_bearing.scad>;

sls();

module sls(
	thickness = 6,
	nut = 8,
	shaft = 20,
	coupling = 20,
	motor = 48,
	laser_head = 150,
	rod = 8,
	motor_arm = 50,
	roller = 30,
	motor_size = 17
) {
	bed = [
		nema_faceplate(motor_size)[1] + thickness*2,
		nema_faceplate(motor_size)[1] + thickness*2,
		nema_faceplate(motor_size)[1] + thickness*2
	];
	
	shaft_h =
		+ bed[2]*2
		+ thickness*5
		+ shaft
		+ coupling
		+ motor
		+ bearing60_width(nut)/2
		+ nut*1.5
	;
	
	rail_length =
		+ bed[1]*3
		+ thickness*6
		+ nema_faceplate(motor_size)[1]
	;
	
	rail_height =
		- rod/2
	;
	
	rail_pitch = bed[0] + thickness*2 + rod*3;

	roller_support_height =
		+ roller/2
		+ nema_faceplate(motor_size)[1]/2
		- rail_height
		+ rod/2
		+ thickness
	;

	roller_support_width = nema_faceplate(motor_size)[0];

	roller_support_length =
		+ rail_pitch
		+ bearing60_width(rod)
		+ thickness*2
		+ motor_arm
		+ shaft
		- bearing60_width(rod)/2
		+ thickness
		+ coupling/2
	;

	bearing_slot_height = 
		sin(
			acos(
				(thickness + rod)
					/ (rod + linear_bearing_offset(rod))
				)
			) * (rod + linear_bearing_offset(rod)
		)
	;

	//Roller Rails
	for(x=[0:1]) {
		translate([
			-rail_pitch/2 + rail_pitch*x,
			-rail_length/2 - 1,
			rail_height
		] * preview) {
			rotate([
				-90,
				0,
				0
			] * preview) {
				rod(
					r = rod/2,
					h = rail_length + 2,
					id = 1+x
				);
			}
		}

		//Rollar Caraige Frame
		translate([
			(rail_pitch + rod + thickness*2)*x
				- rail_pitch/2
				- rod/2
				- thickness*1.5,
			(bed[1]*1.5 + thickness*2)
				* max(min(sin($t*180*5 - 180/2)*2, 1), -1),
			roller/2
		] * preview) {
			translate([
				rod/2
					+ thickness*1.5
					+ (-rod - thickness*2)*x,
				0,
				-roller/2 + rail_height
			] * preview) {
				rotate([
					-90,
					0,
					0
				] * preview) {
					linear_bearing(
						rod,
						id = 3+x
					);
				}
			}
			rotate([
				0,
				90,
				0
			] * preview) {					
				translate([
					roller_support_height/2
						- nema_faceplate(motor_size)[1]/2	
						+ 20*(1-x)/2,
					0,
					0
				] * preview) {
					mdf(
						[
							roller_support_height + 20*(1-x),
							roller_support_width
						],
						thickness = thickness,
						id = 5+x
					) {
						translate([
							- roller_support_height/2
								+ nema_faceplate(motor_size)[1]/2	
								- 20*(1-x)/2,
							0,
							0
						]) {
							//Slot for Linear bearing
							translate([
								roller/2 - rail_height - bearing_slot_height/2,
								-linear_bearing_length(rod)/2,
								0
							]) {
								kerf_cube([
									bearing_slot_height,
									linear_bearing_length(rod),
									thickness
								]);
							}
						
							if(x==0) {
								//Slot for drive nut
								translate([
									roller/2
										- rail_height
										- bearing_slot_height/2
										+ nema_faceplate(motor_size)[0]/2
										- nut*2.3/2,
									-thickness*1.5,
									0
								]) {
									kerf_cube([
										nut*2.3,
										thickness*3,
										thickness/2 + rod/2
									]);
								}
							}
		
							//Cable Tie holes for linear bearing
							for(y=[0:1]) {
								for(z=[0:1]) {
									translate([
										roller/2
											- 2
											+ (bearing_slot_height + 6)*z,
										linear_bearing_length(rod)*.8*y
											- linear_bearing_length(rod)*.4,
										0
									]) {
										kerf_cylinder(
											r = 3/2,
											h = thickness*10
										);
									}
								}
							}
	
							//Hole for radial bearing
							kerf_cylinder(
								r = 22/2 - 1,
								h = thickness
							);
							translate([
								0,
								0,
								thickness
									- bearing60_width(rod)/2
									- thickness*x
							]) {
								kerf_cylinder(
									r = 22/2,
									h = bearing60_width(rod)
								);
							}
						}
					}

				}
				//Radial bearing
				translate([
					0,
					0,
					thickness - thickness*x
				] * preview) {
					bearing60(
						rod,
						id = 7+x
					);
				}					
			}
		}
	}
	
	//Roller Rail supports
	rotate([
		-90,
		0,
		0
	]) {
		for(x=[0:1]) {
			translate([
				0,
				-rail_height,
				-rail_length/2 + (rail_length - thickness)*x
			] * preview) {
				mdf(
					[
						rail_pitch + rod + thickness*2,
						rod + thickness*2
					],
					thickness = thickness,
					id = 9+x
				) {
					for(y=[0:1]) {
						translate([
							-rail_pitch/2 + rail_pitch*y,
							0,
							0
						]) {
							kerf_cylinder(
								r = rod/2,
								h = thickness
							);
						}
					}
				}
			}
		}
	}

	//Roller cariage drive screw
	translate([
		-bed[0]/2 - nema_faceplate(motor_size)[0]/2,
		-rail_length/2 - motor_arm,
		- nema_faceplate(motor_size)[0]/2
	] * preview) {
		rotate([
			-90,
			0,
			0
		] * preview) {
			nema(
				motor_size,
				shaft = shaft,
				id = 11
			) {
				coupling(
					d1 = rod,
					d2 = 5,
					h = coupling,
					id = 12
				) {
					threaded_rod(
						r = rod/2,
						h = rail_length - coupling - shaft + motor_arm,
						id = 13
					);
				}
			}
			mdf(
				nema_faceplate(motor_size),
				thickness = thickness,
				id = 14
			) {
				nema_faceplate_drill(
					motor_size
				);
			}
			translate([
				nema_faceplate(motor_size)[0]/2,
				0,
				motor_arm/2
					+ thickness/2
					+ (
						rail_length
						- bed[1]*3
						- thickness*4
					)/4
					- thickness/2 
			] * preview) {
				rotate([
					0,
					90,
					0
				] * preview) {
					mdf(
						[
							motor_arm
								+ thickness
								+ (
									rail_length
									 - bed[1]*3
									 - thickness*4
								)/2
								- thickness,
							nema_faceplate(motor_size)[0]
						],
						thickness = thickness,
						id = 15
					) {
		
						//Slot for rod support
						translate([
							-(
								rail_length
								- bed[1]*3
								- thickness*4
							)/4
								- thickness/2 ,
							-nema_faceplate(motor_size)[0]/2,
							0
						]) {
							kerf_cube([
								thickness,
								rod + thickness,
								thickness
							]);
						}
					}
				}
			}
		}
	}

	//Drive nut
	translate([
		- bed[0]/2
			- nema_faceplate(motor_size)[0]/2,
		(bed[1]*1.5 + thickness*2)
			* max(min(sin($t*180*5 - 180/2)*2, 1), -1)
			- thickness*1.5,
		- nema_faceplate(motor_size)[0]/2
	] * preview) {
		rotate([
			-90,
			0,
			0
		] * preview) {
			mdf(
				[
					nut*2.3,
					nut*2.3,
				],
				thickness = thickness,
				id = 16
			) {
				kerf_cylinder(
					r = nut*1.1/2,
					h = thickness
				);
			}

			translate([
				0,
				0,
				thickness
			] * preview) {
				mdf(
					[
						nut*2.3,
						nut*2.3,
					],
					thickness = thickness,
					id = 17
				) {
					kerf_cylinder(
						r = nut*1.8/2,
						h = nut,
						$fn = 6
					);
				}
				translate([
					0,
					0,
					thickness
				] * preview) {
					mdf(
						[
							nut*2.3,
							nut*2.3,
						],
						thickness = thickness,
						id = 18
					) {
						kerf_cylinder(
							r = nut*1.1/2,
							h = thickness
						);
					}
				}

				m_nut(
					nut,
					id = 19
				);
			}
		}
	}

	//Roller Drive
	translate([
		0
			- rail_pitch/2
			- rod/2
			- thickness*.5
			- bearing60_width(rod)/2,
		(bed[1]*1.5 + thickness*2)
			* max(min(sin($t*180*5 - 180/2)*2, 1), -1),
		roller/2
	] * preview) {
		rotate([
			0,
			90,
			0
		] * preview) {
			translate([
				0,
				0,
				rail_pitch/2
					+ bearing60_width(rod)/2
					+ thickness
					- bed[0]/2
			] * preview) {
				rotate([
					0,
					0,
					2*360*max(min(sin($t*180*5 - 180/2)*2, 1), -1)
				] * preview) {
					roller_cylinder(
						r = roller/2,
						h = bed[0],
						id = 20
					);
				}
			}
			rod(
				r = rod/2,
				h = rail_pitch
					+ bearing60_width(rod)
					+ thickness*2
					+ motor_arm,
				id = 21
			) {
				coupling(
					d1 = rod,
					d2 = 5,
					h = coupling,
					id = 22
				) {
					translate([
						0,
						0,
						shaft
					] * preview) {
						rotate([
							180,
							0,
							0
						] * preview) {
							mdf(
								nema_faceplate(motor_size),
								thickness = thickness,
								id = 23
							){
								nema_faceplate_drill(
									motor_size
								);
							}
							rotate([
								0,
								90,
								0
							] * preview) {
								translate([
									-roller_support_length/2,
									0,
									-nema_faceplate(motor_size)[0]/2
										- thickness
								] * preview) {
									mdf(
										[
											roller_support_length,
											nema_faceplate(motor_size)[0]
										],
										thickness = thickness,
										id = 24
									);
								}
							}
							nema(
								size = motor_size,
								length = motor,
								id = 25
							);
						}
					}
				}
			}
		}
	}

	//Marker
	translate([
		0,
		0,
		laser_head
	] * preview) {
		marker(
			id = 26
		);
	}

	//Beem
	if(sin(-360/12+$t*360*5)<=-sin(360/12)) {
		translate([
			0,	
			0,
			laser_head
		] * preview) {
			rotate([
				180 + sin($t*15*360)*atan(bed[0]/3/laser_head),
				cos($t*15*360)*atan(bed[1]/3/laser_head),
				0	
			] * preview) {
				part(27, "Laser beam") {
					color([1,.5,.5]) cylinder(
						r = 1,
						h = laser_head
					);
				}
			}
		}
	}

	//Print Bed
	feed(
		bed = bed,
		thickness = thickness,
		nut = nut,
		shaft = shaft,
		coupling = coupling,
		motor = motor,
		motor_size = motor_size,
		t1 = 1-stepmove(.2),
		t2 = 1-stepmove(.2,.066),
		id = 28
	);
	
	//Powder Feeds
	translate([
		0,
		-bed[1] - thickness,
		0
	] * preview) feed(
		bed = bed,
		thickness = thickness,
		nut = nut,
		shaft = shaft,
		coupling = coupling,
		motor = motor,
		motor_size = motor_size,
		t1 = stepmove(.4, 0, .2),
		t2 = stepmove(.4, .066, .2),
		id = 39
	);

	translate([
		0,
		bed[1] + thickness,
		0
	] * preview) feed(
		bed = bed,
		thickness = thickness,
		nut = nut,
		shaft = shaft,
		coupling = coupling,
		motor = motor,
		motor_size = motor_size,
		t1 = stepmove(.4, .2, .2),
		t2 = stepmove(.4, .266, .2),
		id = 50
	);

	//Powder Bins
	for(x=[0:3]) {
		translate([
			0,
			(bed[1] + thickness)*x
				-bed[1]*1.5-thickness,
			-(
				bed[1]
				+ thickness*4
				+ bearing60_width(nut)/2
				+ nut*1.5
			)/2,
		] * preview) {
			rotate([
				90,
				0,
				0
			] * preview) {
				mdf(
					[
						bed[0],
						bed[1]
							+ thickness*4
							+ bearing60_width(nut)/2
							+ nut*1.5			
					],
					thickness = thickness,
					id = 61+x
				);
			}
		}
	}

	//Motor guides
	for(x=[0:1]) {
		color(color_wood,.5) translate([
			(nema_faceplate(motor_size)[1] + thickness)*x
				-nema_faceplate(motor_size)[1]/2,
			0,
			0
				- bed[2]
				- thickness*4
				- bearing60_width(nut)/2
				- nut*1.5
				- (
					shaft_h
					- bed[2]
					- thickness*4
					- bearing60_width(nut)/2
					- nut*1.5
				)/2,
		] * preview) {
			rotate([
				0,
				-90,
				0
			] * preview) {
				mdf(
					[
						shaft_h
							- bed[2]
							- thickness*4
							- bearing60_width(nut)/2
							- nut*1.5,
						bed[1]*3 + thickness*4
					],
					thickness = thickness,
					id = 65+x
				);
			}
		}
	}

	//Back/frount plate
	for(x=[0:1]) {
		color(color_wood,.5) translate([
			(nema_faceplate(motor_size)[1] + thickness*3)*x
				-nema_faceplate(motor_size)[1]/2
				- thickness,
			0,
			-(
				bed[2]
				+ thickness*6
				+ bearing60_width(nut)/2
				+ nut*1.5
			)/2,
		] * preview) {
			rotate([
				0,
				-90,
				0
			] * preview) {
				mdf([
						bed[2]
							+ thickness*6
							+ bearing60_width(nut)/2
							+ nut*1.5,
						rail_length - thickness*2
					],
					thickness = thickness,
					id = 67+x
				);
			}
		}
	}
}

module feed(
	bed,
	thickness,
	nut,
	shaft,
	coupling,
	motor,
	motor_size,
	t1,
	t2,
	id
) {

	//Nut
	translate([
		0,
		0,
		- bed[2]
			- thickness*2
			- bearing60_width(nut)/2
			- nut*1.5
	] * preview) {
		rotate([
			180,
			0,
			0
		] * preview) {
			m_nut(
				nut,
				id = id+0
			);
		}
	}
	
	//Motor
	translate([
		0,
		0,
		- bed[2]
			- thickness*4.5
			- shaft
			- coupling
			- bearing60_width(nut)/2
			- nut*1.5
			- bed[2]*t1
	] * preview) {
		nema(
			motor_size,
			motor,
			shaft,
			id = id+1
		) {
			coupling(
				d1 = 5,
				d2 = nut,
				h = coupling,
				id = id+2
			) {
				threaded_rod(
					r = nut/2,
					h = bed[2]
						+ thickness*3
						+ coupling/2
						+ bearing60_width(nut)/2
						+ nut*1.5,
					id = id+3
				) {
					translate([
						0,
						0,
						-bearing60_width(nut)/2
					] * preview) {
							rotate([
								180,
								0,
								0
							] * preview) {
								bearing60(nut, id=id+4) {
									m_nylock(nut, id=id+5);
								}
							}
					}
					translate([
						0,
						0,
						-thickness/2
					] * preview) {
						mdf_cylinder(
							22/2 + thickness,
							thickness = thickness,
							id = id+6
						) {
							kerf_cylinder(
								r = 22/2,
								h = thickness/2
							);
							kerf_cylinder(
								r = 22/2 - 1,
								h = thickness
							);							
						}
						translate([
							0,
							0,
							thickness
						] * preview) {
							mdf(
								[
									bed[0],
									bed[1],
								],
								thickness = thickness,
								id = id+7
							);
							translate([
								-bed[0]/2,
								-bed[0]/2,
								thickness
							] * preview) {
								part(0, "Plastic powder") color(color_plastic) cube([
									bed[0],
									bed[1],
									bed[2] * t2
								]);
							}
						}
					}
				}
			}
		}	
	}

	//Nut holder
	translate([
		0,
		0,
		- bed[2]
			- thickness*4
			- bearing60_width(nut)/2
			- nut*1.5
	] * preview) {
		mdf(
			[
				bed[0],
				bed[1]
			],
			thickness = thickness,
			id = id+8
		) {
			kerf_cylinder(
				r = nut/2 + 1,
				h = thickness*2
			);
		}
		translate([
			0,
			0,
			thickness
		] * preview) { 
			mdf(
				[
					bed[0],
					bed[1]
				],
				thickness = thickness,
				id = id+9
			) {
				kerf_cylinder(
					r = nut*1.8/2,
					h = thickness,
					$fn = 6
				);
			}
			m_nut(nut, id=id+10);
		}
	}
}

module marker(id) {
	part(id, "Laser marker head") {
		translate([
			0,
			0,
			-50
		]) {
			color(color_steal) cylinder(
				r = 70,
				h = 200
			);
		}
		rotate([
			0,
			90,
			0
		]) {
			color(color_steal) cylinder(
				r = 40,
				h = 700
			);
		}
	}
}

module roller_cylinder(
	r,
	h,
	id
) {
	part(id, "Roller cylinder") {
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
}

function stepmove(
	wavelength = .2,
	delay = 0,
	amount = .2,
	duty = 3,
	step = 0
) =
	wavelength*step+delay > 1 ? 1-step*amount : max(
		min(1-step*amount, 1-amount*step+(wavelength*step+delay-$t)*duty),
			stepmove(
			wavelength,
			delay,
			amount,
			duty,
			step+1
		)
	)
;
