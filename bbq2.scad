intersection() {
    gas();
    cube([400, 400, 500*2], center=true);
}
intersection() {
    gas();
    translate([0, 0, 652])
        cube([400, 400, 300-4], center=true);
}

translate([400, 0, 0])
intersection() {
    gas();
    translate([0, 0, 1104])
        cube([400, 400, 600], center=true);
}

translate([0, 0, 550])
    color([.7, .7, .7, .7])
        cylinder(d=320, h=10);

translate([0, 0, 700])
    color([.7, .7, .7, .3])
        cylinder(d=350, h=10);

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