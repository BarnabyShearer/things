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
    [0, 0, 0],
    [110, 180, 0],
    [-110, 180, 0]
];

material = [
    3,
    "Laser Ply",
    [.8, .8, .7]
];

motor_d = 28.3;
skid_r = 30;
battery_w = 28;
arm_w = material[0]*3;
kk_size = 36;
span = rotors[1][0] - rotors[2][0]+ motor_d;
length = rotors[1][1] + motor_d/2 + material[0]/2 + skid_r;
top = rotors[1][1]- (rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + kk_size/2 + motor_d/2;
height = 50;

//Sides
for(x=[0:1])
    translate([-battery_w/2-material[0] + (battery_w+material[0])*x, -(rotors[0][1] + rotors[1][1] + rotors[2][1])/3 - motor_d/2 +length/2, -height/2] * preview)
        rotate([90, 0, 90] * preview)
            2d(
                [length, height],
                material,
                id=1 + x
            ) {
                translate([length/2, -height/2, 0]) mirror([0,1,0]) corner(skid_r);
                translate([-length/2, -height/2, 0]) mirror([1,1,0]) corner(skid_r);

                //rear cutout
                translate([-length/2+arm_w, -height/2+arm_w, 0]) 
                    minkowski() {
                        intersection() {
                            translate([skid_r, skid_r, 0])
                                cylinder(r=skid_r-3, h=material[0]);
                            cube([30-3,20-3,100]);
                        }
                        cylinder(r=3, h=material[0]);
                    }

                //mid cutout
                translate([-50, -(height-arm_w*2)/2+3, 0])
                    minkowski() {
                        cube([120, height-arm_w*2-6, material[0]]);
                        cylinder(r=3, h=material[0]);
                    }

                //Frount cutout
                translate([length/2 - skid_r - material[0], -6, 0])
                    cube([1000, 1000, material[0]]);

                //tail cutout
                translate([-length/2, height/2-13.8+4, 0])
                    cube([42, 1000, material[0]]);

                for(x=[0:1]) {
                    //Tail activator mounts
                    translate([-length/2 + motor_d/2 + 35.3, height/2-13.8+12-(22.6+material[0])*x, 0])
                        cube([10/2, material[0], material[0]]);
    
                    //Battery mounts
                    translate([(rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + motor_d/2 -length/2 - 47, height/2-36-material[0], 0])
                        cube([5, 2, material[0]]);
                    translate([(rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + motor_d/2 -length/2 + kk_size/2, height/2-36-material[0], 0])
                        cube([5, 2, material[0]]);
                }

                //Tail mounts
                translate([-length/2 + motor_d/2 + 11.2, height/2-13.8-material[0], 0])
                   cube([13/2, material[0], material[0]]);

 
               //Top cutout
                translate([(rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + motor_d/2 -length/2 - kk_size/2, height/2-material[0]+.2, 0])
                    cube([1000, material[0], material[0]]);
            }

//Front
translate([0, rotors[1][1]- (rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + material[0]/2, -height/2] * preview)
    rotate([90, 0, 0] * preview)
        2d(
            [span, height],
            material,
            id=3
        ) {
            translate([span/2, -height/2, 0]) mirror([0,1,0]) corner(skid_r);
            translate([-span/2, -height/2, 0]) mirror([1,1,0]) corner(skid_r);
            for(x=[0:1])
                mirror([x, 0, 0]) {
                    translate([-battery_w/2-material[0], -height/2, 0]) cube([material[0], height/2-6, material[0]]);
                    translate([arm_w, height/2-material[0], 0]) cube([span/2 - arm_w*2, material[0], material[0]]);

                    minkowski() {
                        union() {
                             translate([span/2 - arm_w*3 - battery_w/2 + material[0], -height/2 + arm_w, 0])
                                intersection() {
                                cube([
                                    skid_r,
                                    height-arm_w*2 - 3,
                                    material[0]
                                ]);
                                translate([-3, skid_r, 0]) cylinder(r=skid_r-3, h=material[0]);
                            }
        
                            translate([
                                battery_w/2 + material[0] + arm_w + 3,
                                -height/2 + arm_w + 3,
                                0
                            ])
                                    cube([
                                    span/2 - arm_w*3 - battery_w/2 + material[0]-(battery_w/2 + material[0] + arm_w + 3),
                                    height-arm_w*2 - 6,
                                    material[0]
                                ]);
                        }
                        cylinder(r=3, h=material[0]);
                    }
                }
        }

//Top
translate([
    0,
    top/2 - kk_size/2,
    -material[0]
] * preview)
    2d(
        [span, top],
        material,
        id = 4
    )   {
        difference() {
            translate([-span/2, -top/2, 0])
                cube([span, top, material[0]]);
            for(x=[0, 1]) {
                mirror([x, 0, 0]) {
                    translate([(span-motor_d)/2, (top-motor_d)/2, 0])
                        hull() {
                            cylinder(d=motor_d, h=material[0]);
                            translate([-motor_d*2/3, -arm_w/2, 0])
                                cube([motor_d*2/3, arm_w, material[0]]);
                        }
                    translate([-battery_w/2 - material[0], (top-motor_d)/2-arm_w/2, 0])
                       corner(skid_r);
                }
            }
            translate([-(span-motor_d)/2, (top-motor_d)/2-arm_w/2, 0])
                cube([span-motor_d, arm_w, material[0]]);
    
            translate([-battery_w/2 - material[0], -top/2, 0])
                cube([battery_w + material[0]*2, top-motor_d/2, material[0]]);
            
    }

    translate(
        [0,  -top/2 + kk_size/2, 0]
    ) {

        //motor mount
        for(r=[1,2]) {
             translate([
                0,
                -(rotors[0][1] + rotors[1][1] + rotors[2][1])/3,
                0
            ] + rotors[r]) {
                cylinder(
                    d = 5,
                    h = material[0]
                );
                for(i=[-1,1])
                   rotate([0,0,-45])
                        translate([16/2*i, 0, 0])
                            cylinder(
                                d = 3,
                                h = material[0]
                            );
            }
            //Front registration
            mirror([r-1, 0, 0])
                translate([span/2 - arm_w, -(rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + rotors[1][1]- material[0]/2, 0])
                    cube([arm_w, material[0], material[0]]);
        }
        //Camera mount
        translate([18, -(rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + rotors[1][1] - material[0]*2, 0])
            cube([5, 2, material[0]]);
    
        //Front registration
        translate([-arm_w, -(rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + rotors[1][1] - material[0]/2, 0])
            cube([arm_w*2, material[0], material[0]]);
    }        
}

translate([0, rotors[1][1]- (rotors[0][1] + rotors[1][1] + rotors[2][1])/3 + arm_w/2, -30] * preview) {
    gopro(5);
}

translate([0, 54, 0] * preview) {
    vtx_aerial(6);
}

translate([0, 54, -material[0]] * preview) {
    rotate([0, 0, 180] * preview)
        vtx(7);
}

translate([0, 0, -material[0]] * preview)
    battery(8);

translate([0, 0, 0] * preview)
    pilot(9);

for(z=[0:2])
    translate([battery_w/2+material[0], 0, -12 -14*z] * preview)
        rotate([0, 90, 0] * preview)
            ESC(10+z);

rotate([0, -90, 0] * preview)
    translate([-25/2 -material[0], 0, battery_w/2+material[0]] * preview)
        rx(13);

BEC(14); //todo

translate([ //Zero Centroid
    -(rotors[0][0] + rotors[1][0] + rotors[2][0])/3,
    -(rotors[0][1] + rotors[1][1] + rotors[2][1])/3,
    0
] * preview) {

    translate(rotors[1] * preview)
        rotor(15);

    translate(rotors[2] * preview)
        rotor(17);
   
    translate(([0, 0, -13.8] + rotors[0]) * preview) {
        for(x=[0:1])
            translate([0, 35.3, 12-(22.6+material[0])*x] * preview)
                2d(
                    [battery_w + material[0]*2, 10],
                    material,
                    id=19 + x
                ) {
                    translate([-12.5/2, -2.5/2, 0])
                        cube([12.5, 2.5, material[0]]);
                    for(i=[0:1]) 
                        mirror([i, 0, 0]) translate([battery_w/2, -1000, 0]) cube([1000, 1000, material[0]]);
                }


        translate([0, 11.2, -material[0]] * preview)
            2d(
                [battery_w + material[0]*2, 13],
                material,
                id=21
            ) {
                for(i=[0:1]) {
                    translate([-19/2+19*i, 0, 0])
                        cylinder(d=3, h=material[0]);
                    mirror([i, 0, 0]) translate([battery_w/2, -1000, 0]) cube([1000, 1000, material[0]]);
                }
            }
        tail(22);
    }
}

module tail(id) {
    translate([0, 36.5, 5+2])
        rotate([90, -90, 0])
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
        translate([-28/2, -108/2, -35])
            color([.2, 0, .5]) cube([29, 108, 35]);
}

module pilot(id) {
    part(id, "KK-mini")
        translate([-36/2, -36/2, 0])
            color([.2, .5, .2]) cube([36, 36, 12]);
}

module BEC(id) {
    part(id, "BEC")
        translate([-25/2, -50/2, 0])
            color([.2, .5, .2]) cube([10, 10, 2]);
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
       translate([-24.5/2, 33, 4])
            rotate([90, 0, 0])
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
