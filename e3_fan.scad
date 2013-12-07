/*
 * E3 Fan
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
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

}