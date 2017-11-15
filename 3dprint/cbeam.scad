include <scadhelper/main.scad>;
use <scadhelper/vitamins/nema.scad>;
use <scadhelper/vitamins/isel_lfs81.scad>;
use <scadhelper/vitamins/vslot.scad>;
use <scadhelper/vitamins/2d.scad>;
use <scadhelper/vitamins/coupling.scad>;
use <scadhelper/vitamins/rod.scad>;
use <scadhelper/vitamins/v_wheel.scad>;
use <scadhelper/vitamins/hardware.scad>;
use <kraken.scad>;
use <BulldogXL-101.scad>;

x = (1 + sin(360*$t))/2 * 420;
y = 440;

cbeam_module(500)
	translate([80,0,-97-40-12])
		rotate([0,0,-90])
			cbeam_module(500, 97)
				translate([60,20,-97-40-6])
					rotate([0,0,90]) 
						cbeam_module(500, 97)
						translate([80,0,-51])
						rotate([0,180,0]) {
							translate([24,-45,27])
								rotate([0,0,-90])
									bulldogxl();
							translate([48,26,27])
								bulldogxl();
							translate([-47,-22,27])
								rotate([0,0,180])
									bulldogxl();
							translate([-23,49,27])
								rotate([0,0,90])
									bulldogxl();

							translate([0,0,-90])
								kraken();
						}
translate([0,500+12,0])
	cbeam_module(500);
translate([500+200+6,0,0]) {
	cbeam_module(500)
		translate([-80,0,-97-40-12])
			rotate([0,0,90])
				cbeam_module(500, 97);
	translate([0,500+12,0])
		cbeam_module(500);
}

module cbeam_module(length, motor=76) {
	translate([0,0,motor])
		nema([57.15, 40, 8], motor)
			translate([0,-20,0])
			cbeam_end()
				cbeam(length) {
					translate([0,0,-y])
						cbeam_plate()
							children();
					cbeam_end();
				}
}	

module cbeam(length) {
    vslot(length, sections=4)
        children();
    translate([-30,20,0])
        vslot(length);
    translate([30,20,0])
        vslot(length);
}
    
module cbeam_end() {
    color([.1,.1,.1])
        translate([-40,-10,0])
            cube([80,40+7,12]);
    translate([0,0,12])
        children();
}

module cbeam_plate() {
    rotate([-90,0,0]) {
        color([.1,.1,.1])
            translate([-40, -40, 31])
                cube([80, 80, 6]);
        translate([0,0,37])
            children();
    } 
}