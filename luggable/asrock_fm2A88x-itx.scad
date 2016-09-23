include <scadhelper/main.scad>;
use <scadhelper/vitamins/hardware.scad>;

asrock_fm2A88x_itx();
*asrock_fm2A88x_itx_drill();

module asrock_fm2A88x_itx(id=0) {
	PCIe=71.65+1.78+11.65+2;
	part(id, "Asrock FM2A88X-ITX") {

	difference() {
		translate([(154.54-170.18)/2, 10.16-170.18, -1.6])
			color([.4,1,.4])
				cube([170.18, 170.18, 1.6]);
	
		translate([0,0,-1.7]) {
			cylinder(d=4, h=2);
			translate([0,-155.08, 0])
				cylinder(d=4, h=2);
			translate([157.48,-155.08, 0])
				cylinder(d=4, h=2);
			translate([157.48,-155.08+132.22, 0])
				cylinder(d=4, h=2);
		}
	
	}
	

	translate([1.57-8.7/2, 11.65-46.94-PCIe, 0]) {
		color([.3,.3,.3])
			cube([8.7,PCIe,11]);
	}
	
	translate([-9+170.18-70 -45,-70+11.65-57,0])
		color([.3,.3,.3])
			cube([70,70,60]);
	
	translate([1.57, 0, 0])
		children();
}
}

module asrock_fm2A88x_itx_drill() {

	
		translate([0,0,-1.7]) {
			m_tap(3, h=1000);
			translate([0,-155.08, 0])
				m_tap(3, h=1000);
			translate([157.48,-155.08, 0])
				m_tap(3, h=1000);
			translate([157.48,-155.08+132.22, 0])
				m_tap(3, h=1000);
		}
	
	
}




