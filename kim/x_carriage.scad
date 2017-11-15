/*
 * x carriage
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>

use <vitamin/j_head.scad>
use <printed/x_carriage_bowden_mount.scad>
use <vitamin/fan.scad>
use <printed/fan_baffle.scad>
use <printed/fan_mount.scad>
use <vitamin/linear_bearing.scad>
use <vitamin/rod.scad>
use <other/x_carriage_plate.scad>

x_carriage();

module x_carriage(
	heads = 17,
	bars = 50,
	height = 10,
) {
	translate([
		0,
		-heads/2 + heads,
		0
	]) {
		rotate([
			0,
			0,
			180
		]) {
			jhead();
		}
	}

	translate([
		0,
		-heads/2,
		0
	]) {
		jhead() {
			translate([
				0,
				heads/2,
				-height,
			]) {
				rotate([
					0,
					90,
					0
				]) {
					for(i=[0:1]) {
						translate([
							0,
							-bars/2 + bars*i,
							0,
						]) {
							linear_bearing();
						}
					}
				}
				
				translate([
					0,
					0,
					height + 4.64
				]) {
					bowden_mount();
				}
	
				translate([
					-43,
					0,
					1.64
				]) {
					rotate([	
						0,
						135,
						0
					]) {
						fan();
						fan_baffle();
						for(i=[0:1]) {
							translate([
								0,
								-32*i,
								0
							]) {
								fan_mount(thickness = 4.64);
							}
						}
					}
				}
				translate([
					0,
					0,
					height
				]) {
					x_carriage_plate(
						heads = heads,
						bars = bars
					);
				}
			}
		}
	}
}


