difference() {
	translate([(154.54-170.18)/2, 10.16-170.18, -1.6])
		color([.4,1,.4])
			cube([170.18, 170.18, 1.6]);

	translate([0,0,-1.7]) {
		cylinder(d=4, h=2);
		translate([0,-154.54, 0])
			cylinder(d=4, h=2);
		translate([154.54,-154.54, 0])
			cylinder(d=4, h=2);
		translate([154.54,-22.86, 0])
			cylinder(d=4, h=2);
	}
}
PCIe=71.65+1.78+11.65+2;
translate([1.57-8.7/2, -46.94-PCIe, 0]) {
	color([.3,.3,.3])
		cube([8.7,PCIe,11]);
}

color([.3,.3,.3])
	cube([70,70,60]);