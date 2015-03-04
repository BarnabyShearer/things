/*
 * E3
 *
 * Copyright 2013 E3D-Online Limited, <b@Zi.iS>
 * License CC BY 3.0
 */
$fn=60;
include <scadhelper/main.scad>


for(x=[0:2])
	rotate([0,0,360/3*x])
		bodge();

module bodge() {
	difference() {
		union() rotate([0,0,360/3*2])
			translate([0,-.4,.1])
				rotate([35,0,0])
					E3();
	
		for(x=[0:1])
			intersection() {
				rotate([0,0,360/3*x])
					translate([0,-.4,.1])
						rotate([35,0,0])
								E3();
			
				rotate([0,0,180+360/3*x]) {
					linear_extrude(h=200) polygon([
						[0, 0],
						[tan(60)*100, 100],
						[-tan(60)*100, 100],
					]);
				}
			}

		translate([0,-5,0])
			cube([20,10,20]);
		rotate([0,0,-150])
			cube([20,5,20]);		

		translate([-100,-100,-100])
			cube([200,200,100]);
	}
}




module E3(id) {
	E3_nozzle(id);
	E3_block(id+1);
	translate([0,0,8.5]) {
		E3_break(id+2);
		E3_sink(id+3);
	}
}

module E3_nozzle(id) {
    part(id, "E3 Nozzle") color(color_brass) {
        difference() {
            union() {
                cylinder(
                        d1=3,
                        r2 = 3/2 - cos(125)*2.4,
                        h = 2.4
                        );
                translate([
                        0,
                        0,
                        2.4
                        ]) {
                     cylinder(
                            r = 7 * 1/pow(3, .5),
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
                    r = 1.2/2,
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
}
module E3_block(id) {
    part(id, "Volcano") color(color_steel) {
        translate([
                -15.5,
                -11.5+4.5,
                5.4
                ]) {
            difference() {
                cube([
                        20,
                        11.5,
                        20
                        ]);
                *translate([
                        8,
                        11.5-4,
                        0
                        ]) {
                    e() cylinder(
                            r = 6/2,
                            h = 12
                            );
                }
                *translate([
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
                        8,
                        11.5-4,
                        0
                        ]) {
                    e() cylinder(
                            r = 6.2/2,
                            h = 21
                            );
                }
                *translate([
                        4,
                        13,
                        2
                        ]) {
                    rotate([0, 90, 0]) e() cylinder(
                            r = 2/2,
                            h = 16
                            );
                }
                *translate([
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
}
module E3_break(id) {
    part(id, "E3 Heat Break") color(color_steel) {
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
}
module E3_sink(id) {
    part(id, "E3 Heat Sink") color(color_steel) {
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
