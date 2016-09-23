include <scadhelper/main.scad>;
use <scadhelper/vitamins/hardware.scad>;

lp097qx1();

module lp097qx1(id) {
	part(id, "LP097QX1") {
	color([.3, .3, .3])
		cube([208.88, 2.60, 167.12]);
	translate([(208.88-196.61)/2, -.1, (167.12-147.44)/2])
		cube([196.61, .1, 147.44]);
	
	translate([-2.25, 0, 167.12-5])
		ear();
	
	translate([208.88+2.5, 0, 167.12-5])
		mirror()
			ear();
	
	translate([208.88+2, 0, 5])
		mirror()
			ear();
	
	translate([5, 0, -2.25])
		rotate([0,-90,0])
			ear();
	}
}

module lp097qx1_drill() {
    translate([-2.25, 167.12-5, 0])
        m_tap(2, h=1000);
    translate([208.88+2.5, 167.12-5, 0])
        m_tap(2, h=1000);
    translate([208.88+2, 5, 0])
        m_tap(2, h=1000);
    translate([5, -2.25, 0])
        m_tap(2, h=1000);
}    

module ear() {
	color([.8, .8, .8])
		difference() {
			hull() {
				rotate([-90,0,0])
					cylinder(d=4.5, h=.5);
				translate([2.5, 0, -5])
					cube([.1,.5,7.25]);
			}
			rotate([-90,0,0])
				e() cylinder(d=2.5, h=3.5);
		}
}	
