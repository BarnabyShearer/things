/*
 * Default settings
 *
 * Copyright 2014 <b@Zi.iS>
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <scadhelper/vitamins/servos.scad>;
use <scadhelper/vitamins/2d.scad>;

rotors = [
    [0, 0, 13.3],
    [110, 180, 0],
    [-110, 180, 0]
];

plate = [
    rotors[1][0]*2 + 27.3,
    rotors[1][1] + 27.3/2 - 15 + 3.8 + 5
];

material = [
    3,
    "Laser Ply",
    [.8, .8, .7]
];


translate([ //Centroid
    -(rotors[0][0] + rotors[1][0] + rotors[2][0])/3,
    -(rotors[0][1] + rotors[1][1] + rotors[2][1])/3,
    0
]*preview) {

translate([
    0,
    plate[1]/2 +15 - 3.8 - 5,
    -material[0]
] * preview) {    
    2d(
        plate,
        material,
        id=1
    ) {
        difference() {
            translate([-plate[0]/2-.5, -plate[1]/2-.5, 0]) cube([plate[0]+1, plate[1]+1, material[0]]);
            frame();
            mirror() frame();
        }
        //not semetric
        for(r=[1,2])
            translate([
                0,
                -(plate[1]/2 +15 - 3.8 - 5),
                0
            ] + rotors[r])
                for(i=[-1,1]) //motor mount
                    rotate([0,0,-45])
                        translate([16/2*i, 0, 0])
                            cylinder(
                                d = 3,
                                h = material[0]+1000
                            );

        translate([0, -(plate[1]/2 +15 - 3.8 - 5) + 180, 0]) //vTx mount
            cylinder(d=5.3, h=material[0]);

        translate([13, -(plate[1]/2 +15 - 3.8 - 5) + 180, 0]) //Camera mount
            cube([5, 2, material[0]]);

    }
}

for(i=[-1,1])
    translate([30*i, 175, -material[0]] * preview)
        rotate([0, 90, 180-55*i] * preview) 
            skid(3 + i);

translate([0, 28, -material[0]] * preview)
    rotate([0, 90, 0] * preview)
        skid(3);

translate([0, 187, -30] * preview) {
    gopro(5);
}

translate([0, 180, 0] * preview) {
    vtx_aerial(6);
}

translate([0, 180, -material[0]] * preview) {
    vtx(7);
}

translate([ //Centroid
    (rotors[0][0] + rotors[1][0] + rotors[2][0])/3,
    (rotors[0][1] + rotors[1][1] + rotors[2][1])/3,
    0
]) {
    translate([0, 0, -material[0]] * preview)
        battery(8);
    translate([0, 0, 4] * preview)
        pilot(9);
    translate([35/2, 0, -25/2-material[0]] * preview)
        rotate([0, 90, 0] * preview)
            BEC(10);
    translate([0, 0, -material[0]] * preview)
        ESC(11);
    rotate([0, -90, 0] * preview)
        translate([-25/2 -material[0], 0, 35/2] * preview)
            rx(12);
}

for(i=[1,2]) {
    translate([
        rotors[i][0]/2,
        rotors[i][1],
        0
    ] * preview)
        rotate([0, 0, 90] * preview) 
           ESC(12+i);
}

translate(rotors[1] * preview)
    rotor(15);

translate(rotors[2] * preview)
    rotor(17);

tail(19);

}

module tail(id) {
    translate([0, 36.5, 5+2])
        rotate([90, 90, 0])
            servo(
                [
                    [2.5, 2.5, 22.6-5, 5, 2.5, 2.5],
                    [6.25, 0, 6.25],
                    [16, 2.5, 1.5, 5.6, 5]
                ],
                [2, 5],
                id = id
            );

    part(id+1, "Hinge")
        translate([-13, -3.8, 0])
            color([1, 1, 1]) cube([
                26,
                30,
                13.3
            ]);

    translate([0, 0, 13.3])
	    rotor(id+2);
}

module rotor(id) {
    part(id, ">2000kV brushless") color([0, .5, .2]) {
        cylinder(d = 27.3, h = 19.1);
        cylinder(d = 16, h = 21.6);        
        cylinder(d = 5, h = 21.6 + 5.8);
        translate([0, 0, 21.6 + 5.8]) {
            cylinder(d1 = 11, d2 = 5, h = 13);
        }
    }
    part(id + 1, "5030 Rotor") {
        translate([0, 0, 21.6]) {
            color([1, 1, 1, .2]) cylinder(d = 128, h = 5.8);
        }
    }
}

module battery(id) {
    part(id, "2200mAh LiPo")
        translate([-35/2, -108/2, -28])
            color([.2, 0, .5]) cube([35, 108, 28]);
}

module pilot(id) {
    part(id, "KK-mini")
        translate([-36/2, -36/2, 0])
            color([.2, .5, .2]) cube([36, 36, 12]);
}

module BEC(id) {
    part(id, "BEC")
        translate([-25/2, -50/2, 0])
            color([.1, .1, .1]) cube([25, 50, 12]);
}

module ESC(id) {
    part(id, "20A afroslim")
        translate([-13/2, -80/2, 0])
            color([.2, .5, .2]) cube([13, 80, 7]);
}

module rx(id) {
    part(id, "6ch Receiver")
        translate([-25/2, -50.5/2, 0])
            color([.4, .4, .4]) cube([25, 50.5, 15]);

}

module gopro(id) {
    part(id, "GoPro Hero3") {
        translate([-59/2+15, 0, 0]) {
            color([.1, .1, .1]) cube([59, 20, 41]);
            translate([0, 20, 0])
                color([.8, .8, .8]) cube([59, 1, 41]);
        }
        translate([0, 0, 27])
            rotate([-90, 0, 0])
                color([.1, .1, .1]) cylinder(d = 23, h = 8+21);
    }
}

module vtx_aerial(id) {
    part(id, "5.8Ghz Tx Aerial")
        color([.1, .1, .1]) cylinder(d1=10, d2=7.5, h=108);
}

module vtx(id) {
    part(id, "TS5823 Video Tx")
       translate([-21+4.5, -4, -31])
            color([.2, .5, .2])
                cube([21, 8, 31]);
}

module corner(r=3, h=material[0]) {
    translate([-r,-r,0])
        difference() {
            cube([r, r, h]);
            e() cylinder(r = r, h=h);
        }
}

module frame() {
        difference() {
            translate([0, -plate[1]/2, 0])
                cube([
                    26/2,
                    35,
                    material[0]
                ]);
            translate([19/2, -plate[1]/2 + 5, 0])
                e() cylinder(d = 3, h = material[0]);
            translate([0, -plate[1]/2 + 27.8, 0])
                e() cube([12.5/2, 2.5, material[0]]);
        }
        translate([
            0,
            -plate[1]/2+35,
            0])
                cube([
                    13/2,
                    60-35,
                    material[0]
                ]);

        difference() {
            translate([
                0,
                -plate[1]/2 + 59,
                0])
                    cube([
                        40/2,
                        110,
                        material[0]
                    ]);
            translate([0, -25, 0])
                cube([15/2, 90, 6]); //ESC

            for(i=[-1,1])
                translate([31/2, 27.3/2+15-5-3.8+31/2*i, 0])
                    cylinder(d=2.5, h=3); //KK mount
        }


        translate([
            0,
            plate[1]/2 - 27.3/2 - 13/2,
            0]
        )
            cube([
                plate[0]/2 - 27.3+4,
                13,
                material[0]
            ]);

        translate([
            plate[0]/2 - 27.3/2,
            plate[1]/2 - 27.3/2,
            0]
        )
            difference() {
                cylinder(
                    d = 27.3,
                    h = material[0]
                );
                cylinder( //Axil hole
                    d = 5,
                    h = material[0]
                );
            }

        translate([
            -40/2, 
            plate[1]/2 - 27.3/2 - 13/2,
            0
        ])
            corner(40);

        translate([
            -13/2, 
            -plate[1]/2 +59,
            0
        ])
            corner(10);

        translate([
            -13/2, 
            -plate[1]/2 + 35,
            0
        ])
            mirror([0,1,0])
                corner(5);

        translate([0, -81.9, 0]) //skid mount
            kerf_cube([material[0]/2, 10, material[0]]);

        translate([30, 75, 0])
            rotate([0, 90, -55]) 
                translate([-material[0], 0, -material[0]/2])
                    kerf_cube([material[0], 10, material[0]]);
        
}

module skid(id) {
    translate([46/2-material[0], -70/2, -material[0]/2] * preview)
    2d(
        [46, 70],
        material,
        id = id
    ) {
        difference() {
            translate([-48/2, -71/2, 0]) cube([48, 71, material[0]]);
            translate([-46/2+material[0], 70/2, 0]) {
                intersection() {
                    difference() {
                        translate([75-3, 0, 0]) cylinder(d = 150, h = material[0]);
                        e() translate([260/2, 20, 0]) cylinder(d = 250, h = material[0]);
                        e() translate([-20, -20, 0]) cube([20, 10, material[0]]);
                    }
                    translate([-30, -100, 0]) cube([100, 100, material[0]]);
                }
                translate([-material[0], -10, 0]) cube([3, 10, material[0]]);
            }
        }
    }
}
