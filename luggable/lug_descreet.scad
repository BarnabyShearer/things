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
translate([-24,0,0])
	color([0, 0, 0])
		cube([64, 146, 83]);

//Motherboard
translate([15,-140,85]) {
	color([.3,.6,.3])
		cube([1.6,170,170]);

	//Ports
	translate([1.6,0,0])
		color([.9,.9,.9])
			cube([38,26,170]);

	//Cooler
	translate([1.6,40,40])
		color([.9,.9,.9])
			cube([23,80,80]);
}

//SSD
translate([30,-120,0])
	color([.9,.9,.9])
		cube([9.5, 100, 70]);

//Keyboard
translate([-25,280/2,100])
	rotate([0,-90+90*$t,180])
		color([0, 1, 0])
			cube([100, 280, 25]);


//Mouse
translate([-115,-80,40])
	rotate([0,0,90-90*$t])
		translate([0,-120,0])
			rotate([90-90*$t,0,0])
				color([0, 0, 1])
					cube([120, 70, 40], center=true);

//graphics card
translate([20,70,86])
	cube([18, 67, 170]);

//screen
translate([4,-230/2,90]) {
			color([1, 0, 0])
				cube([10, 230, 170]);
		translate([-1,15,10])
			color([.9, .9, .9])
				cube([1, 196.61, 147.44]);
	}