$fn=60;

rotate([90,0,0]) {

*translate([30,60,4])
	color([0,0,0])
		sphere(r=6);
*translate([30,90,4])
	color([0,0,0])
		sphere(r=6);

*difference() {
	cube([60, 140, 4]);
	for(x=[10,30,50]) {
		translate([
			x,
			65,
			-.1
		]) {
			cylinder(
				r = 2.625,
				h = 4.2
			);
			translate([
				-2.625,
				0,
				0
			]) {
				cube([
					2.625*2,
					90-65,
					4.2
				]);
			}
			translate([
				0,
				90-65,
				0
			]) {
				cylinder(
					r = 2.625,
					h = 4.2
				);
			}
		}
	}
}



difference() {

	union() {
		translate([0,52.5,-10])
			cube([60, 45, 10]);

		hull() {

			translate([20,52.5,-10])
				cube([20, 45, 10]);
			translate([30,52.5,-15])
				rotate([-90,180/6,0])
					cylinder(
						r=9,
						h=45
					);
		}
	}

	translate([30,0,2])
		rotate([-90,180/6,0])
			cylinder(
				d=15,
				h=100
			);


	for(x=[10,50]) {
		translate([
			x,
			65,
			-60
		]) {
			cylinder(
				d=4.2, //M5 Tap
				h = 100
			);
			translate([
				0,
				90-65,
				0
			]) {
				cylinder(
				d=4.2, //M5 Tap
					h = 100
				);
			}
		}
	}

	translate([30,0,-15])
		rotate([-90,180/6,0])
			cylinder(
				d=8.5, //M10 tap
				h=100
			);
}

}