/*
 * Bendy tube
 *
 * This is just a hack and not based on plausable phisics
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>
use <scadhelper/vitamins/rod.scad>
use <scadhelper/vitamins/linear_bearing.scad>
use <scadhelper/vitamins/hardware.scad>
use <scadhelper/vitamins/nema.scad>
use <scadhelper/vitamins/chain.scad>
use <e3.scad>
use <e3_fan.scad>


delta_x = 100;
a = 45;
b = 0;

r = delta_x / (sin(a) + sin(b) + 2);
c = 2*PI*r;
echo(c/360*a);
rotate([0,a,0])
	translate([0,0,-1])
		cylinder(r=1, h=1);

s_c = c/360*a;
s_r = -a/s_c;
t_c = c/260*b;
t_r = -b/t_c;

rotate([0,a,0]) {
	for(i=[0:s_c]) {
		translate([
			bend_x(i, s_r),
			0,
			bend_y(i, s_r)
		]) {
			rotate([0, i*s_r, 0]) cylinder(r=1, h=1);
		}
	}
	translate([
		bend_x(s_c, s_r),
		0,
		bend_y(s_c, s_r)
	]) {
		rotate([0, -a, 0]) {
			for(i=[0:c/2]) {
				translate([
					bend_x(i, 180/(c/2)),
					0,
					bend_y(i, 180/(c/2))
				]) {
					rotate([0, i*s_r, 0]) cylinder(r=1, h=1);
				}
			}
		}
	}
	translate([
		bend_x(s_c, s_r),
		0,
		bend_y(s_c, s_r)
	]) {
		rotate([0, -a, 0]) {
			translate([
				bend_x(c/2, 180/(c/2)),
				0,
				bend_y(c/2, 180/(c/2))
			]) {
				rotate([0, -180, 0]) {
					for(i=[0:t_c]) {
						translate([
							bend_x(i, t_r),
							0,
							bend_y(i, t_r)
						]) {
							rotate([0, i*t_r, 0]) cylinder(r=1, h=1);
						}
					}
				}
			}
		}
	}
}

function bend_x(i, s_r, rec=0) = i<=0 ? rec : bend_x(i-1, s_r, rec + sin(s_r*i));
function bend_y(i, s_r, rec=0) = i<=0 ? rec : bend_y(i-1, s_r, rec + cos(s_r*i));
