translate([-1, -375/2, 0])
rotate([0,0,-90])
translate([0, 375/2, 0]) {
    intersection() {
        gas();
        translate([200+1, 0, 400])
            cube([400, 400, 300], center=true);
    }
    intersection() {
        gas();
        translate([200+1, 0, 900])
            cube([400, 400, 300], center=true);
    }
}

difference() {
    gas();
    translate([200-1, 0, 400])
        cube([400, 400, 300], center=true);

    translate([200-1, 0, 900])
        cube([400, 400, 300], center=true);
}

module gas() {
    difference() {
        union() {
            cylinder(
                d=375,
                h=1100
            );
            cylinder(
                d=200,
                h=1290
            );
            translate([0, 0, 1100])
                scale([1, 1, .5])
                    sphere(d=375);
        }
        translate([0, 0, 10])
            cylinder(
                d=375-6,
                h=1100
            );
    }
}