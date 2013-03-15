/*
 * Die
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

use <die.scad>;

die() {
	number(1);
	number(2);
	number(3);
	number(4);
	number(5);
	paw();
}

module paw() {
	translate([
		0,
		-.5,
		0
	]) {
		scale([
			1,
			1,
			.5
		]) {
			sphere(
				r=1.5
			);
			translate([
				-1,
				-1,
				0
			]) {
				sphere(
					r=1.4
				);
			}
			translate([
				1,
				-1,
				0
			]) {
				sphere(
					r=1.4
				);
			}
		}		
	}
	rotate([
		0,
		0,
		20
	]) {
		translate([
			-0,
			3,
			0
		]) {
			scale([
				.6,
				1,
				.5
			]) {
				sphere(
					r=1.3
				);
			}
		}
	}	
	rotate([
		0,
		0,
		-20
	]) {
		translate([
			0,
			3,
			0
		]) {
			scale([
				.6,
				1,
				.5
			]) {
				sphere(
					r=1.3
				);
			}
		}
	}	
	rotate([
		0,
		0,
		30
	]) {
		translate([
			-1.4,
			2.5,
			0
		]) {
			scale([
				.6,
				1,
				.5
			]) {
				sphere(
					r=1.1
				);
			}
		}
	}	
	rotate([
		0,
		0,
		-30
	]) {
		translate([
			1.4,
			2.5,
			0
		]) {
			scale([
				.6,
				1,
				.5
			]) {
				sphere(
					r=1.1
				);
			}
		}
	}	
}