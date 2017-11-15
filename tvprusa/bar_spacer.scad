$fn=60;

bar_spacer();
translate([15,0,0]) bar_spacer();
translate([30,0,0]) bar_spacer();
translate([0,15,0]) bar_spacer();
translate([15,15,0]) bar_spacer();
translate([30,15,0]) bar_spacer();
translate([0,30,0]) bar_spacer();
translate([15,30,0]) bar_spacer();
translate([30,30,0]) bar_spacer();

module bar_spacer() {
	rotate([-90,0,0]) intersection() {
		translate([0,0,1.5]) cube(10, center=true);
	
		rotate([-45,45,0]) {
			%translate([0,4.5,-15]) cylinder(
				r = 8/2,
				h = 30
			);
			translate([-15, -4.5, 0]) rotate([0,90,0]) {
				%cylinder(
					r = 8/2,
					h = 30
				);
			}
		
			difference() {
				cube(30, center=true);
				translate([0,4.5,-15]) cylinder(
					r = 8/2,
					h = 30
				);
				translate([-15, -4.5, 0]) rotate([0,90,0]) {
					cylinder(
						r = 8/2,
						h = 30
					);
				}
			}
		}
	}
}