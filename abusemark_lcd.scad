include <scadhelper/main.scad>;
use <scadhelper/vitamins/hardware.scad>;

abusemark_lcd();

module abusemark_lcd(id) {
	part(id, "Abusemark LCD") {
		translate([0,0,1.6])
			color([1, 1, 1])
				difference() {
					cube([80, 40, 1.6]);
					translate([80-3, 3, 0])
						e() cylinder(d=3, h=1.6);
					translate([35, 3, 0])
						e() cylinder(d=3, h=1.6);
					translate([17, 40-3, 0])
						e() cylinder(d=3, h=1.6);
					translate([50, 40-3, 0])
						e() cylinder(d=3, h=1.6);
				}
		translate([-1, 22, 3.2])
			color([.7, .7, .7])
				cube([14.5, 17, 7]);
		translate([0, 12, 3.2])
			color([.7, .7, .7])
				cube([6, 6.5, 8]);
		translate([0,15.5, 8])
			color([.3, .3, .3])
				rotate([0, -90, 0])
					cylinder(d=3.5, h=1.5);

		translate([-1.5,2, 3.2])
			color([.7, .7, .7])
				cube([9.5, 8, 4]);

		translate([80-4.5-17, 40-2.5-4, 3.2])
			color([1, 1, .7])
				cube([17, 4, 1]);

		rotate([0,0,180]) translate([4,-40,0]) children();
	}
}

module abusemark_lcd_drill() {
	translate([80-3, 3, 0])
		m_tap(3, h=1000);
	translate([35, 3, 0])
		m_tap(3, h=1000);
	translate([17, 40-3, 0])
    	m_tap(3, h=1000);
	translate([50, 40-3, 0])
		m_tap(3, h=1000);
}
