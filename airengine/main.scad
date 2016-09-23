/*
 * Oscillating cylinder air engine
 *
 * Inspired by http://www.thingiverse.com/thing:25624
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <mount.scad>;
use <base.scad>;
use <piston_cylinder.scad>;
use <piston.scad>;
use <flywheel.scad>;

air_engine();

module air_engine(
	crank_r = 15,
	valve_r = 2,
	piston_r = 6,
	piston_h = 3,
	double = 1,
	thickness = 2,
	clearence = 2,
	width = 5,
) {
	offset1 = crank_r + 3 + clearence + width*2;
	offset2 = piston_length(crank_r, valve_r, thickness, double, clearence, piston_h);
	outer_r = ease(piston_r) + thickness;
	edge = outer_r*2 / sqrt(4 + 2*sqrt(2));
	cylinder_width = edge*(1 + sqrt(2));

	color([.25,.25,.25]) rotate([
		0,
		-90,
		0
	]) {
		mount(
			width = width,
			crank_r = crank_r,
			valve_r = valve_r,
			piston_h = piston_h,
			double = double,
			clearence = clearence,
			thickness = thickness
		);
	}
	
	color([.25,.25,.25]) translate([
		0,
		0,
		-offset1
	]) {
		base(
			width = width,
			crank_r = crank_r,
			piston_r = piston_r,
			thickness = thickness
		);
	}

	translate([
		0,
		0,
		offset2
	]) {
		rotate([
			-90 + acos((-cos(360*$t) * crank_r)/ (offset2 - sin(360*$t) * crank_r)),
			0,
			0
		]) {
			rotate([
				90,
				0,
				90
			]) {
				color([.25,.25,.75]) piston_cylinder(
					crank_r = crank_r,
					valve_r = valve_r,
					piston_r = ease(piston_r),
					piston_h = piston_h,
					thickness = thickness,
					double = double
				);
				color([.5,.5,.75]) piston_cylinder_endcap(
					crank_r = crank_r,
					valve_r = valve_r,
					piston_r = ease(piston_r),
					piston_h = piston_h,
					thickness = thickness,
					double = double
				);
			}
		}
	}
	translate([
		cylinder_width/2,
		cos(360*$t) * crank_r,
		sin(360*$t) * crank_r
	]) {

		rotate([
			-90 + acos((-cos(360*$t) * crank_r)/ (offset2 - sin(360*$t) * crank_r)),
			0,
			0
		]) {
			color([.25,.75,.25]) piston(
				crank_r = crank_r,
				valve_r = valve_r,
				piston_r = piston_r,
				piston_h = piston_h,
				thickness = thickness,
				clearence = clearence,
				double = double
			);
		}
	}
	translate([
		thickness/2,
		0,
		0
	]) {

		rotate([
			0,
			90,
			0
		]) {
			rotate([
				0,
				0,
				360*$t + 90
			]) {
				color([.75,.25,.25]) flywheel(
					crank_r = crank_r,
					piston_r = piston_r,
					thickness = thickness
				);
				translate([
					0,
					0,
					-thickness/2
				]) {
					flywheel_washer(
						thickness = thickness
					);
				}
				translate([
					crank_r,
					0,
					piston_r*2-thickness
				]) {
					flywheel_washer(
						thickness = thickness
					);
				}
			}
		}
	}
}