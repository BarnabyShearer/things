echo("\r\rWIP: The large belt offset causes twisting forces result in a
 reduced working life.\r\r");

/*
 * x carriage
 *
 * Lightweight x carriage for my hotend mount.
 *
 * Copyright 2012 <b@Zi.iS>
 * License GPLv2
 *
 * incorporating http://www.thingiverse.com/thing:4434 by whosawhatsis
 */
$fn = 60;

m8 = 8/2;
m3 = 3.6/2;
m4 = 4.6/2;
m3_nut = 6.1 /2;
fan40_gap = 32;

translate([
	10,
	-20,
	0
]) {
	belt_guide();
}
translate([
	-10,
	-20,
	0
]) {
	belt_guide();
}
translate([
	10,
	-30,
	0
]) {
	belt_clamp();
}
translate([
	-10,
	-30,
	0
]) {
	belt_clamp();
}

carriage();

translate([
	0,
	30,
	0
]) {
	carriage(
		support_hole = 5.2,
		clamp_pos = 1
	);
}

module belt_blank(
	bolt = m3,
	pitch = 10,
	belt_width=6,
	belt_thickness=1.5,
	tooth_height=1.5,
	e=.1
) {
	union() {
		translate([
			bolt*2,
			0,
			0
		]) {
			
			cube([
				pitch ,
				bolt*4+e*2,
				(belt_thickness+tooth_height)*2
			]);		
		}
		translate([
			bolt*2,
			bolt*2,
			0
		]) {
		cylinder(
				r = bolt*2+e,
				h= (belt_thickness+tooth_height)*2
			);
		}
		translate([
			bolt*2+pitch,
			bolt*2,
			0
		]) {
			cylinder(
				r = bolt*2+e,
				h= (belt_thickness+tooth_height)*2
			);
		}
	}
}

module belt_guide(
	bolt = m3,
	pitch = 10,
	belt_width=6,
	belt_thickness=1.5,
	tooth_height=1.5
) {
	difference() {
		belt_blank(
			bolt = bolt,
			pitch = pitch,
			belt_width = belt_width,
			belt_thicknes = belt_thickness,
			tooth_height = tooth_height
		);

		translate([
			bolt*2,
			bolt *2,
			-1
		]) {
			cylinder(
				r = bolt,
				h = (belt_thickness+tooth_height)*2 +2
			);
		}
		translate([
			bolt*2+ pitch,
			bolt *2,
			-1
		]) {
			cylinder(
				r = bolt,
				h = (belt_thickness+tooth_height)*2 +2
			);
		}
		translate([
			(pitch + bolt*4)/2 - belt_width/2,
			-1,
			belt_thickness+tooth_height-1
		]) {
			cube([
				belt_width,
				bolt*4+2,
				belt_thickness+tooth_height+2
			]);	
		}
	}
}

module belt_clamp(
	bolt = m3,
	nut = m3_nut,
	pitch = 10,
	belt_width=6,
	belt_thickness=1.5,
	tooth_height=1.5,
	tooth_spacing=5
) {
	difference() {
		belt_blank(
			bolt = bolt,
			pitch = pitch,
			belt_width = belt_width,
			belt_thicknes = belt_thickness,
			tooth_height = tooth_height
		);

		translate([
			bolt*2,
			tooth_spacing/4*3,
			-1
		]) {
			cylinder(
				r = bolt,
				h = (belt_thickness+tooth_height)*2 +2
			);
		}
		translate([
			bolt*2+ pitch,
			tooth_spacing/4*3,
			-1
		]) {
			cylinder(
				r = bolt,
				h = (belt_thickness+tooth_height)*2 +2
			);
		}

		translate([
			bolt*2,
			tooth_spacing/4*3,
			-1
		]) {
			cylinder(
				r = nut,
				h = 3,
				$fn = 6
			);
		}
		translate([
			bolt*2+ pitch,
			tooth_spacing/4*3,
			-1
		]) {
			cylinder(
				r = nut,
				h = 3,
				$fn = 6
			);
		}

		translate([
			(pitch + bolt*4)/2 - belt_width/2,
			-1,
			belt_thickness+tooth_height*2,
		]) {
			cube([
				belt_width,
				bolt*4+2,
				tooth_height+1
			]);	
		}
		translate([
			(pitch + bolt*4)/2 - belt_width/2,
			tooth_spacing/2,
			belt_thickness+tooth_height-1
		]) {
			cube([
				belt_width,
				tooth_spacing/2,
				tooth_height+tooth_height+1
			]);	
		}
		translate([
			(pitch + bolt*4)/2 - belt_width/2,
			tooth_spacing/2+tooth_spacing,
			belt_thickness+tooth_height-1
		]) {
			cube([
				belt_width,
				tooth_spacing/2,
				tooth_height+tooth_height+1
			]);	
		}
	}
}

module carriage(
	rod = m8,
	rod_gap = 50,
	bolt = m4,
	bushing_thickness=1,
	thickness = 3,
	support_width = 28.4,
	support_hole = 10.5, //to edge
	fan_hole = (50-fan40_gap)/2,
	fan_bolt = m3,
	hang = 1.5,
	clamp_offset = 12.5,
	clamp_pitch = 10,
	clamp_bolt = m3,
	clamp_nut = m3_nut,
	clamp_level = 11.5,
	clamp_pos = -1
) {
	height = thickness+support_hole + bolt*3;

	difference() {
		union() {
		translate([
				-rod_gap/2,
				0,
				0
			]) {
				bushing(
					rod = rod,
					length = rod*3,
					width = rod*4,
					height = rod*2,
					thickness = bushing_thickness
				);
			}

			translate([
				rod_gap/2,
				0,
				0
			]) {
				bushing(
					rod = rod,
					length = rod*3,
					width = rod*4,
					height = rod*2,
					thickness = bushing_thickness
				);
			}

			translate([
				-rod_gap/2 - rod*2 - (clamp_pos<0 ? clamp_offset-clamp_bolt*2 - rod*2:0),
				rod*2-bushing_thickness,
				0
			]){
				cube([
					rod_gap+rod*2 + clamp_offset-clamp_bolt*2,
					thickness*2,
					height
				]);
			}
			translate([
				(rod_gap/2 + rod*2) * -clamp_pos - (clamp_pos>0 ? fan_bolt*4-.002:0)-.001,
				rod*2-bushing_thickness-hang,
				0
			]){
				cube([
					fan_bolt*4,
					thickness*2+hang,
					height + fan_bolt*4
				]);
			}
		}
	
	translate([
			-support_width/2,
			rod*2-bushing_thickness+thickness,
			thickness
		]){
			cube([
				support_width,
				thickness+1,
				height+1
			]);
		}

		translate([
			0,
			rod*2-bushing_thickness+thickness+1,
			thickness+bolt+support_hole
		]){
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r = bolt,
					h=thickness+2
				);
			}
		}
		translate([
			(rod_gap/2 + rod*2 + fan_bolt*2) * -clamp_pos,
			rod*2-bushing_thickness+thickness*2+1,
			thickness+bolt+support_hole+fan_hole
		]){
			rotate([
				90,
				0,
				0
			]) {
				cylinder(
					r = fan_bolt,
					h=thickness*2+2+hang
				);
			}
		}

	}

	clamp_width = clamp_pitch + clamp_bolt*4;
	clamp_height = clamp_nut *2;
	translate([
		(rod_gap/2+clamp_offset- clamp_bolt*2) * clamp_pos + (clamp_pos<0 ? -clamp_width :0),
		clamp_level-clamp_nut *4,
		0
	]) {
		difference() {
			cube([
				clamp_width,
				clamp_nut *4,
				clamp_bolt*4
			]);
			translate([
				clamp_bolt*2,
				clamp_nut *4 +1,
				clamp_bolt*2
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r = clamp_bolt,
						h = clamp_nut *4 +2
					);
				}
			}
			translate([
				clamp_bolt*2 + clamp_pitch,
				clamp_nut *4 +1,
				clamp_bolt*2
			]) {
				rotate([
					90,
					0,
					0
				]) {
					cylinder(
						r = clamp_bolt,
						h = clamp_nut *4 +2
					);
				}
			}
			translate([
				(clamp_bolt*4 + clamp_pitch)/2,
				clamp_nut *2,
				-1
			]) {
				cylinder(
					r = clamp_bolt,
					h =clamp_bolt*4 +2
				);
			}
			translate([
				(clamp_bolt*4 + clamp_pitch)/2,
				clamp_nut *2,
				clamp_bolt*4 - 2.4
			]) {
				cylinder(
					r = clamp_nut,
					h =clamp_bolt*4 +2,
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
