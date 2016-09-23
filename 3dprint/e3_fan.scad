/*
 * E3 Fan
 *
 * Copyright 2013 E3D-Online Limited, <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/fan.scad>

use <e3.scad>

%E3();
E3_fan();

module E3_fan(id = 0) {
	part(id, "Fan shrowd") color([1,.1,.1]) {
		translate([
			100,
			-17,
			-65
		]) {
			rotate([
				90,
				0,
				180
			]) {
				import("FanDuctForV4.1.stl");
			}
		}
	}
	translate([
		0,
		-25,
		35
	]) {
		rotate([
			90,
			0,
			180
		]) {
			fan(
				size = [
					30,
					8,
					25,
					3
				],
				id = id+1
			);
		}
	}
}