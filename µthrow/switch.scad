//SS-10GL2 Hinge roller lever
include <scadhelper/main.scad>;

switch();

module switch(pressed=0, id) {
	part(id, "SS-10GL2 Hinge roller lever microswitch") {
	color([.95,0,0,])
		difference() {
			union() {
				cube([19.8,6.4,9.5]);
				cube([10,6.4,10.2]);
			}
			translate([5.1,-1,2.9])
				rotate([-90,0,0])
					cylinder(r=2.35/2, h=10);
			translate([5.1+9.5,-1,2.9])
				rotate([-90,0,0])
					cylinder(r=2.35/2, h=10);
		}
	color([1,1,1])
			translate([5.1+9.5-7.5,(6.4-3.2)/2,10.3+(1-pressed)*.3])
				rotate([-90,0,0])
					cylinder(r=2.35/2, h=3.2);
	
	color([1,1,0])
		translate([1.6,(6.4-3.2)/2,-6.4+2.9])
			cube([0.5, 3.2, 6.4-2.9]);
	
	color([1,1,0])
		translate([1.6+8.8,(6.4-3.2)/2,-6.4+2.9])
			cube([0.5, 3.2, 6.4-2.9]);
	
	color([1,1,0])
		translate([1.6+8.8+7.3,(6.4-3.2)/2,-6.4+2.9])
			cube([0.5, 3.2, 6.4-2.9]);
	

	rotate([0,-2.5*(1-pressed),0]) {
	
		color([0,0,0])
				translate([5.1+14.5,(6.4-3.2)/2,2.9+14.5-4.8/2])
					rotate([-90,0,0])
						cylinder(r=4.8/2, h=3.2);
		
		color([.9,.9,.9])
				translate([5.1+14.5,(6.4-5.4)/2,2.9+14.5-4.8/2])
					rotate([-90,0,0])
						cylinder(r=3/2, h=5.4);
		
		color([.9,.9,.9]) 
			translate([2.9,(6.4-4.4)/2,11.5])
				cube([18.6,4.4,.5]);
		
		color([.9,.9,.9]) 
			translate([2.9,(6.4-4.4)/2,8.5])
				cube([.5,4.4,3]);
	
		color([.9,.9,.9]) 
			translate([3.5+18-3.65,(6.4-4.4)/2,11.5])
				cube([3.65,4.4,5.5]);
	}
	}
}