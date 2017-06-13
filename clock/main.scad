$f=60;
include <scadhelper/main.scad>;
use <scadhelper/vitamins/nema.scad>;
use <MCAD/involute_gears.scad>;

Ts=7;
Tr=11*Ts;
Tp=5*Ts;
D=250;
E=15;
P=D*180/Tr;

part(1, str("6mm MDF ", E, "x", D/2, "mm Min hand"))
drawing()
translate([0,0,12] * preview)
difference() {
    hull() {
        cylinder(r=E, h=6);
        translate([0,D/2,0])
            cylinder(d=1, h=6);
    }
    translate([0,0,-1])
        shaft();
        
        
}

part(2, str("6mm MDF ", E, "x", D/2.5, "mm Hour hand"))
drawing()
translate([0,0,6] * preview)
difference() {
    hull() {
        cylinder(r=E, h=6);
        translate([D/2.5, 0,0])
            cylinder(d=1, h=6);
    }
    translate([P*Ts/360 + P*Tp/360, 0,0])
            cylinder(d=3, h=6);
    translate([0,0,-1])
        cylinder(d=5, h=8);
        
        
}

part(3, "Motor")
rotate([0,0,180/12]*preview)
    translate([0,0,-6]*preview)
        nema(motor=nema_sizes[17], depth=34);

part(3, str("6mm MDF ", D+E, "x", D+E, "mm Back of rim")) {
drawing() {
translate([0,0,-6]*preview)
    difference() {
        cylinder(d=D+E, h=6);
        translate([0,0,-1])
            cylinder(d=D-E, h=8);
    }
difference() {
    union() {
        for(r=[0:180/6:180]) {    
            rotate([0,0,r])
                translate([0,0,-3] * preview)
                    cube(center=true, [D, E, 6]);
        }
    }
    cylinder(d=6, h=8);
    rotate([0,0,180/12]) nema_faceplate_drill(motor=nema_sizes[17]);
} }
}

part(4, str("6mm MDF ", D+E, "x", D+E, "mm Rim"))
drawing()
difference() {
    cylinder(d=D+E, h=6);
    translate([0,0,-1])
        gear(
            number_of_teeth = Tr,
            circular_pitch = P,
            gear_thickness = 8,
            rim_thickness = 8,
            hub_thickness = 8,
            bore_diameter = 0
        );
}

part(5, str("6mm MDF ", P*Ts/180, "x", P*Ts/180, "mm Sun"))
drawing()
difference() {
    gear(
        number_of_teeth = Ts,
        circular_pitch = P,
        gear_thickness = 6,
        rim_thickness = 6,
        hub_thickness = 6,
        bore_diameter = 0
    );
    shaft();
}

part(6, str("6mm MDF ", P*Tp/180, "x", P*Tp/180, "mm Planet"))
drawing()
translate([P*Ts/360 + P*Tp/360, 0, 0] * preview)
gear(
    number_of_teeth = Tp,
    circular_pitch = P,
    gear_thickness = 6,
    rim_thickness = 6,
    hub_thickness = 6,
    bore_diameter = 3
);

module shaft() {
    intersection() {
        cylinder(d=5,h=8);
        translate([-50,-1.5,0])
            cube([100,100,100]);
    }
}