/*
 * Holder for screwdrivers
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */
include <config.scad>;

holder_screwdriver();

module holder_screwdriver(
	r = 14/2,
	r_max = 27/2,
	r_gap = 20,
	t = 3
) {
	r_top = (r_max-r)/(r_gap/t)+r;

	difference() {
		union() {
			for(x=[0:1]) {
				translate([
					-r_top-t + (r_top*2+t*2)*x,
					0,
					t
				]) {
					tag(chirality=x);
				}
			}
			translate([
				-r_top-t,
				0,
				0
			]) {
				cube([
					r_top*2+t*2,
					r_max+r_top+t,
					t
				]);
			}
		}
		e() translate([
			-r,
			r_max,
			-1
		]) {
			cube([
				r*2,
				r_max,
				t*2
			]);
		}
		e() translate([
			0,
			r_max,
			0
		]) {
			cylinder(
				r1=r,
				r2=r_max,
		     	h = r_gap
			);
		}
	}

	//Screwdriver
	translate([
		0,
		r_max,
		0
	]) {
		%cylinder(
			r1=r,
			r2=r_max,
	     	h = r_gap
		);
	}
	translate([
		0,
		r_max,
		-r_gap*2
	]) {
		%cylinder(
			r=r,
	     	h = r_gap*2
		);
	}
}

module tag(
	size = 3,
	t = 1,
	chirality = 0
) {
	center_chirality = chirality == 0 ? 1 : -1;
	r = size*1.8/2;

	difference() {
		translate([
			-(r+t)*2 * chirality,
			0,
			0,
		]) {
			cube([
				(r+t)*2,
				t,
				r*2,
			]);
		}
		translate([
			(r+t) * center_chirality,
			-1,
			r,
		]) {
			rotate([
				-90,
				0,
				0
			]) {
				cylinder(
					r = size/2,
					h = t+2
				);
			}
		}
	}
	for(x=[0:1]) {
		translate([
			t-t*chirality-(r*2+t)*x*-center_chirality,
			t,
			0,
		]) {
			rotate([
				0,
				-90,
				0
			]) {
				linear_extrude(
					height = t
				) {
					polygon([
						[0,0],
						[r*2,0],
						[0,r*2],
					]);
				}
			}
		}
	}
}