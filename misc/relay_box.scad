/*
 * XRF Relay Base Box
 *
 * http://shop.ciseco.co.uk/xrf-relaybase-also-for-xbee-wireless-dual-relay-module-for-switching-kit/
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>;

lid();

module box(
	size = [81,61,23],
	t = 1.255
) {
	difference() {
		cube([
			size[0]+t*2,
			size[1]+t*3,
			size[2]+t
		]);
		translate([
			t,
			t,
			t
		]) {
		cube([
			size[0],
			size[1],
			size[2]+1
		]);
			
		}
		translate([
			-1,
			t+size[1]-5,
			t+11,
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r=10/2,
					h=t+2
				);
			}
		}
		for(x=[0:2]) {
			translate([
				size[0]+t-10-16*x,
				size[1]+t-1,
				size[2]/2+t
			]) {
				rotate([
					-90,
					0,
					0
				]) {
					cylinder(
						r=6.5/2,
						h=t*3+2
					);
				}
			}
		}
	}
}

module lid(
	size = [81,61,23],
	t = 1.255
) {
	difference() {
		union() {
			cube([
				size[0]+t*2,
				size[1]+t*3,
				t
			]);
			translate([
				t+.1,
				t+.1,
				0
			]) {
				cube([
					size[0]-.2,
					size[1]-.2,
					t+4
				]);
			}
		}
		translate([
			t*2+.1,
			t*2+.1,
			t
		]) {
			cube([
				size[0]-t*2-.2,
				size[1]-t*2-.2,
				size[2]+1
			]);
		}
	}
}

