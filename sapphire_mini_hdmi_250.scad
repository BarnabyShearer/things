translate([0, 59.91-79.2, 0])
	color([.8,.8,.8])
			cube([1.27, 79.2, 18.4]);

translate([-11.8, 59.91, 3.4])
	color([.8,.8,.8]) {
		difference() {
			cube([11.8, 1.27, 18.6]);
			translate([5.5,-.1,14.1])
				rotate([-90,0,0,])
					cylinder(d=4.4, h=2);
			translate([5.5-4.4/2,-.1,14.1])
				cube([4.4,2,10]);
		}
	}
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