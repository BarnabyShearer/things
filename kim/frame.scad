/*
 * frame
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>
use <vitamin/rod.scad>

frame();

module frame(
	rod = 8,
	small_pitch = 58.5,
	large_pitch = 250,
	x_pitch = 200,
	ends = 25
) {
	tri = small_pitch - rod/cos(30) * 2; //Amount triangles extend behond cross-rods
	length = large_pitch + tri*2;
	
	for(i=[0:2]) {
		for(x=[0:1]) {
			rotate([
				360/3*i,
				0,
				0,
			]) {
				translate([
					x_pitch*x,
					0,
					length/2/cos(30)
				]) {
					rotate([
						-150,
						0,
						0,
					]) {
						translate([
							0,
							0,
							tri - ends
						]) {
							threaded_rod(
								h = large_pitch + ends*2
							);
						}
					}
				}
				translate([
					-ends -(i==0 ? ends : 0),
					-small_pitch/2 + small_pitch*x,
					length/2/cos(30) - (tri/2)/tan(30)
				]) {
					rotate([
						0,
						90,
						0,
					]) {
						threaded_rod(h=x_pitch + ends*2 +(i==0 ? 50 : 0));
					}
				}
			}
		}
	}
}
