include <scadhelper/main.scad>;

bequiet_tfx();

module bequiet_tfx(id) {
    part(id, "Bequite TFX PSU") {
    color([.2,.2,.2]) {
    	cube([98.7+77.8, 65.5, 85.5]);
    	translate([98.7-82, 0, 0])
    		cube([82, 70.3, 85.5]);
    	translate([98.7+77.8,65.5-7.5-23.4,7.5])
    		cube([3.7, 23.4, 30.5]);
    }
    translate([0,65.5-8-18/2,18/2+11])
    	rotate([0,-90,0])
    		cylinder(d=18, h=20);
	}
}
