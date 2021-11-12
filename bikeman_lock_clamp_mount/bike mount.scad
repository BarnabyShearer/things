$fn=32;

*difference() {
    union() {
        translate([-39/2, -29/2, 0])
            cube([39, 29, 9]);
        translate([-39/2, -29/2-40, -5])
            cube([39, 40, 14]);
    }

    translate([-35/2, -25/2, -.001])
        cube([35, 25, 2]);
    
    rotate([90, 0, 0])
        translate([0, 0, -15])
            scale([1, 2, 1])
                cylinder(27.5, 3, 3);
    
    rotate([90, 0, 0])
        translate([0, 0, -14.5+5])
            scale([1, 2, 1])
                cylinder(4, 4.5, 4.5);
    
    for(i=[-11,11])
        translate([i, 0, 0]) {
            cylinder(100, 3, 3);
            translate([0, 0, 5.001])
                rotate([0, 0, 360/12])
                    cylinder(4, 5.6, 5.6, $fn=6);
 
            translate([0, -33+i, -50])
                cylinder(100, 3, 3);
            translate([0, -33+i, 0]) {
                translate([0, 0, 5.001])
                    rotate([0, 0, 360/12])
                        cylinder(4, 5.6, 5.6, $fn=6);
            }
        }
        

    translate([-50, -5, -5])
        rotate([90, 0, 60])
            cylinder(100, 5, 5);   
}


difference() {
    translate([-39/2, -29/2-40, -14])
        cube([39, 40, 9]);
    translate([-50, -5, -5])
        rotate([90, 0, 60])
            cylinder(100, 5, 5);   
    for(i=[-11,11])
        translate([i, 0, 0])
            translate([0, -33+i, -50])
                cylinder(100, 3, 3);
}