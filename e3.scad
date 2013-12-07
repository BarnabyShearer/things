/*
 * E3
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>

E3();

module E3(id) {
    part(id, "E3 Nozzle") color(color_brass) {
        difference() {
            union() {
                cylinder(
                        r1 = 1.2/2,
                        r2 = 1.2/2 - cos(125)*2,
                        h = 2
                        );
                translate([
                        0,
                        0,
                        2
                        ]) {
                    cylinder(
                            r = 8 * 1/pow(3, .5),
                            h = 3,
                            $fn = 6
                            );
                    cylinder(
                            r = 5/2,
                            h = 5
                            );
                    translate([
                            0,
                            0,
                            5
                            ]) {
                        cylinder(
                                r = 6/2,
                                h = 5.5
                                );
                    }
                }
            }
            e() cylinder(
                    r = 0.4/2,
                    h = 25.1
                    );
            translate([
                    0,
                    0,
                    4]) {
                e() cylinder(
                        r = 3.2/2,
                        h = 25.1
                        );}

        }
    }
    part(id+1, "E3 Heat Block") color(color_steel) {
        translate([
                -8,
                -4,
                5
                ]) {
            difference() {
                cube([
                        16,
                        16,
                        12
                        ]);
                translate([
                        8,
                        4,
                        0
                        ]) {
                    e() cylinder(
                            r = 6/2,
                            h = 12
                            );
                }
                translate([
                        8,
                        10,
                        7
                        ]) {
                    e() cylinder(
                            r = 3/2,
                            h = 9
                            );
                }
                translate([
                        0,
                        11,
                        7
                        ]) {
                    rotate([0, 90, 0]) e() cylinder(
                            r = 6.2/2,
                            h = 16
                            );
                }
                translate([
                        0,
                        13,
                        2
                        ]) {
                    rotate([0, 90, 0]) e() cylinder(
                            r = 2/2,
                            h = 16
                            );
                }
                translate([
                        0,
                        2,
                        2
                        ]) {
                    rotate([0, 90, 0]) e() cylinder(
                            r = 2.5/2,
                            h = 4.5
                            );
                }
            }
        }
    }
    part(id+2, "E3 Heat Break") color(color_steel) {
        translate([
                0,
                0,
                5 + 12 -5
                ]) {
            difference() {
                union() {
                    cylinder(
                            r = 6/2,
                            h = 5
                            );
                    cylinder(
                            r = 4.8/2,
                            h = 25.1
                            );
                    translate([
                            0,
                            0,
                            5 + 2.1
                            ]) {
                        cylinder(
                                r = 6/2,
                                h = 20.6 - 2.1 - 5
                                );				
                    }
                }
                e() cylinder(
                        r = 3.2/2,
                        h = 25.1
                        );
            }
        }
    }
    part(id+3, "E3 Heat Sink") color(color_steel) {
        translate([
                0,
                0,
                5 + 12 + 2.1 
                ]) {
            difference() {
                union() {
					for(i=[0:9]) {
						translate([0, 0, 3.4*i]) {
							cylinder(
								r = 25/2,
								h = 3.4 - 2.2
							);
						}
					}
                    cylinder(
                            r = 15/2,
                            h = 3.4*5
                            );
                    cylinder(
                            r = 13/2,
                            h = 3.4*6
                            );
                    cylinder(
                            r = 9/2,
                            h = 50.1
                            );
                    translate([0, 0, 50.1 - 14.6 -2]) cylinder(
                            r = 16/2,
                            h = 2
                            );
                    translate([0, 0, 50.1 - 12.3]) cylinder(
                            r = 16/2,
                            h = 12.3-9.3
                            );
                    translate([0, 0, 50.1 - 12.3]) cylinder(
                            r = 12/2,
                            h = 12.3
                            );
                    translate([0, 0, 50.1 - 3.7]) cylinder(
                            r = 16/2,
                            h = 3.7
                            );
                }
                e() cylinder(
                        r = 6/2,
                        h = 18
                        );
                e() cylinder(
                        r = 3.2/2,
                        h = 50.1
                        );
            }
        }
    }
}
