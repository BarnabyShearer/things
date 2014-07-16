include <scadhelper/main.scad>;

sapphire_mini_hdmi_250();

module sapphire_mini_hdmi_250(id) {
	part(id, "Sapphire Mini HDMI 250") {

translate([0, 1.27+10.16, 0]) rotate([0,0,-90]){
//plate
translate([0, -18.4+1.27+1.6/2, -1.6])
	color([.8,.8,.8])
			cube([1.27, 18.4, 80.38-1.27-4]);

translate([0, -18.4+1.27+1.6/2 + (18.4-10.18)/2, -4-1.6])
	color([.8,.8,.8])
			cube([1.27, 10.18, 4+1.6]);

translate([-11.8, -18.4+1.27+1.6/2-3.4, 80.38-1.27-1.6-4])
	color([.8,.8,.8]) {
		difference() {
			cube([11.8, 18.6, 1.27]);
			translate([5.5,14.1-18.4/2,0])
				e() cylinder(d=4.4, h=1.27);
			translate([5.5-4.4/2,14.1-18.4/2-10,0])
				e() cube([4.4, 10, 1.27]);
		}
	}

translate([0, 1.6/2, 14.38+.27])
rotate([90, 0, 0]) {
translate([0, 59.91-56, 0])
	color([.4,1,.4])
			cube([169.52, 56, 1.6]);

translate([0, 59.91-56, -3.5])
	color([.4,1,.4,.5])
			cube([169.52, 56, 1.6+3.5*2]);


translate([46.9, 59.91-64.41, 0])
			cube([89, 64.41-56, 1.6]);

translate([150-97, 59.91-56, 1.6]) {
	color([0,0,0])
		cube([97, 56, 14]);
}

translate([150-97, 59.91-56, 1.6]) {
	color([0,0,0])
		cube([97, 56, 14]);
	color([.4,.4,.4])
		translate([68, 30, 1])
			cylinder(d=50, h=14);
}
}
}
}
}
