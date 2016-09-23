translate([-200,200,0]) {
	color([0, 0, 0])
		cube([265, 360, 25]);
	
	translate([265-10, 0, 25+10])
		rotate([0, -180+110*$t,0]) {
			translate([-10, 0, -10])
				color([0, 0, 0])
					cube([265, 360, 20]);
			translate([5, 20, -9])
				color([.75, .75, .75])
					cube([240, 320, 20]);
		}
}

//PSU
translate([5,-10,0])
	color([0, 0, 0])
		cube([64, 146, 83]);

//Motherboard
translate([0,-140,83-45]) {
	color([.3,.6,.3])
		cube([1.6,170,170]);

	//Ports
	translate([1.6,0,0])
		color([.9,.9,.9])
			cube([38,26,170]);

	//Cooler
	translate([1.6,40,40])
		color([.9,.9,.9])
			cube([40,80,80]);
}

//SSD
translate([0,30,90])
	color([.9,.9,.9])
		cube([70,100,9.5]);

//Keyboard
if($t<.25)
	translate([45,-280/2,110 + 500*$t])
		color([0, 1, 0])
			cube([30, 280, 100]);

if($t>=.25)
	translate([-150,-280/2,0])
		color([0, 1, 0])
			cube([100, 280, 30]);


//Mouse
translate([-90,-80,20])
	rotate([0,0,90-90*$t])
		translate([0,-120,0])
			color([0, 0, 1])
				cube([120, 70, 40], center=true);

//screen
translate([10,-230/2,200])
	rotate([0,-180+180*$t,0]) {
		translate([15,0,15])
			color([1, 0, 0])
				cube([20, 230, 170]);
		translate([14,15,25])
			color([.9, .9, .9])
				cube([1, 196.61, 147.44]);
	}