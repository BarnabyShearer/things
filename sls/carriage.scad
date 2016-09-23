/*
 * Carriage
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
include <scadhelper/vitamins/bearing.scad>;
use <scadhelper/vitamins/2d.scad>
use <scadhelper/vitamins/thrust_bearing.scad>;
use <scadhelper/vitamins/rod.scad>;
use <scadhelper/vitamins/hardware.scad>;
use <bevel_gears.scad>;
use <drive.scad>;

carriage();

module carriage(
	size = [
		50,
		50,
		50
	],
	length = (6 + 50 + 6) * 3,
	rod = 8,
	roller = 15/2,
	material = [
        6,
        "STEEL",
        [color_steel[0], color_steel[1], color_steel[2], .5]
    ],
	rail_pitch = 30,
	rod1 = 60*$t,
	rod2 = 59*$t,
	id
) {
	rotate([
		180,
		-90,
		0
	]) {
		translate([
			-rail_pitch,
			0,
			0
		]) {
			threaded_rod(
				r = rod/2,
				l = length
			);
		}
		translate([
			rail_pitch,
			0,
			0
		]) {
			rod(
				r = rod/2,
				l = length
			);
		}
			threaded_rod(
				r = rod/2,
				l = length
			);
			rotate([
				0,
				0,
				90
			]){ 
				translate([
					0,
					0,
					10 + rod1*3
				]) {
					translate([
						0,
						0,
						material[0]
					]) {
						thrust_bearing(
							size = (rod+2),
							rotation = -(rod1-rod2)*360
						) {
							insert(
								rod = rod
							) {
								bevel_gears(rotation = -(rod1-rod2)*360) {
									translate([
										material[0],
										0,
										0
									]) {
										2d(
											[
												34,
												rail_pitch*2 + 20
											],
											material
										) {
											translate([
												-material[0],
												0,
												0
											]) {	
												kerf_cylinder(
													r = rod/2 + bearing60_offset(rod)/2
												);
											}
										}
									}
									bearing60(
										size = rod
									) {
										roller(
											rod = rod,
											r = roller,
											h = size[1],
											thickness = material[0],
											rod1 = rod1,
											rod2 = rod2
										) {
											bearing60(
												size = rod
											);
											translate([
												material[0],
												12,
												1.5
											]) {
												2d(
													[
														34,
														56
													],
													material
												) {
													translate([
														-material[0],
														-12,
														0
													]) {	
														kerf_cylinder(
															r = rod/2 + bearing60_offset(rod)/2
														);
													}
												}
											}
										}
									}
								}
								translate([
									0,
									0,
									13.5 +9
									] * preview) {
										rotate([
											0,
											180,
											0
										] * preview) {
										thrust_bearing(
											size = (rod+2),
											rotation = (rod1-rod2)*360
										);
									}
								}
							}
						}
					}
				for(i=[0,40]) {
					translate([
						0,
						0,
						i
					]) {
						translate([
							0,
							rail_pitch,
							0
						]) {
							color(color_brass) {
								m_nut(rod);
							}
						}
						translate([
							0,
							-rail_pitch,
							0
						]) {
							bearing60(rod);
						}
						2d(
							[
								rail_pitch,
								rail_pitch*2 + 20
							],
							material
						) {
							union() {
								kerf_cylinder(
									r = rod/2 + 1,
									h = material[0]
								);
								translate([
									0,
									-rail_pitch,
									0
								]) {
									kerf_cylinder(
										r = rod/2 + bearing60_offset(rod)/2,
										h = material[0]
									);
								}
								translate([
									0,
									rail_pitch,
									0
								]) {
									kerf_cylinder(
										r = rod*1.8/2,
										h = material[0],
										$fn = 6
									);
								}
							}
						}
						for(y=[-rail_pitch, rail_pitch]) {
							translate([
								0,
								y,
								material[0]
							]) {
								2d(
									[
										rail_pitch,
										20
									],
									material
								) {
									kerf_cylinder(
										r = rod/2 + 1 + (y==0 && i!=0 ? 10 : 0),
										h = material[0]
									);
								}
							}
						}

						translate([
							48,
							0,
							-material[0]
						]) {
							2d(
								[
									126,
									rail_pitch*2 + 20
								],
								material
							) {
								union() {
									for(y=[-rail_pitch, 0, rail_pitch]) {
										translate([
											-48,
											y,
											0
										]) {
											kerf_cylinder(
												r = rod/2 + 1 + (y==0 && i!=0 ? 10 : 0),
												h = material[0]
											);
										}
									}
									translate([
										126/2-(size[1] + material[0]*3.5 + 2),
										rod/2,
										0
									]) {
										kerf_cube(
											[
												size[1] + material[0]*3.5 + 3,
												100,
												material[0]
											]
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

module roller(
	rod,
	r,
	h,
	thickness,
	rod1,
	rod2,
	id
) {
	part(id, str(r, "x", h, "mm roller")) {
		translate([
			0,
			0,
			-thickness
		] * preview) {
			color([1,1,1]) cylinder(
				r = rod/2,
				h = h + thickness*4 + 2
			);
		}
		rotate([0,0, (rod1-rod2)*360*2.75]) {
			translate([0,0,.1 + thickness + 1]) color([1,1,1]) difference() {
				cylinder(r = r+.1, h = h);
				e() cube([r, r, h]);
				e() translate([-r, -r, 0]) cube([r, r, h]);
			}
			translate([0,0,thickness + 1]) color([1,0,0]) intersection() {
				cylinder(r = r, h = h);
				union() {
					e() cube([r, r, h]);
					e() translate([-r, -r, 0]) cube([r, r, h]);
				}
			}
		}
	}
	translate([
		0,
		0,
		thickness*2 + h + 2
	] * preview) {
		if($children>0) for (i = [0 : $children-1]) child(i);
	}
}