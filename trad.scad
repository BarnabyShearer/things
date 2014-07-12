//PSU
translate([0,-83,0])
	color([0, 0, 0])
		cube([146, 83, 64]);

//Motherboard
color([.3,.6,.3])
	cube([170,170,1.6]);

//Cooler
translate([50,40,1.6])
	color([.9,.9,.9])
		cube([80,80,40]);

//SSD
translate([10,170,0])
	color([.9,.9,.9])
		cube([100,9.5,70]);

//Keyboard
translate([150,-95,40])
	color([0, 0, 0])
		cube([100, 280, 30]);

//screen
translate([0,-110,75])
	color([1, 0, 0])
		cube([230, 310, 20]);