include <scadhelper/main.scad>;
use <scadhelper/vitamins/rod.scad>;
use <scadhelper/vitamins/hardware.scad>;
use <MCAD/involute_gears.scad>



//MKS Micro Servo DS460
rotate([180,0,0])
translate([0,15,-20]) {
	color([0,0,0]) {
		cube([10,22.5,20]);
		translate([0, -(31-22.5)/2,15.10])
			cube([10,29.4,1.2]);
		translate([0, 0,0])
			cube([10,22.5-16.8+(31-22.50)/2,23.5]);

	}
	color([.9,.9,.9])
		translate([10/2,27-7-(27-22.50)/2,0])
			cylinder(r=2, h=24.5);
}


tt=$t<.5?2*$t:1-2*($t-0.5);

//Pager motor
color([0,0,0])
	cube([4.7,8,4.7]);
color([.9,.9,.9])
	translate([4.7/2,0,4.7/2])
	rotate([90,0,0]) {
		cylinder(r=2, h=1);
		cylinder(r=.25, h=3);
	}
color([1,1,1])
	translate([4.7/2,-1,4.7/2])
	rotate([90,-51.39*360*tt,0]) {
            gear(
                number_of_teeth = 9,
                circular_pitch = .75 * 360/(2*PI),
                gear_thickness = 2,
                rim_thickness = 2,
                hub_thickness = 2,
                hub_diameter = .5,
                bore_diameter = .5
            );
		}

translate([-7.5,-1,-1.6-1.6])
	color([.2,.5,.2])
		cube([13,10,1.6]);
translate([-7.5,-1,-1.6])
	color([.2,.5,.2])
		cube([13,10,1.6]);

translate([-7.5,-1,0])
	cube([13,1,5]);

translate([-7.5,7,0])
	cube([13,2,5]);


translate([-3,0,2*.8])
rotate([-90,0,0]){
	translate([0,0,-m_nut_width(2)-1]) {
		threaded_rod(
			r=2/2,
			h=10+m_nut_width(2),
			pitch=0.4
		);
	}
	translate([0,0,-2-1]) {
		m_nut(2);
			color([1,1,1])
					rotate([0,0,12.5*360*tt])
            gear(
                number_of_teeth = 37,
                circular_pitch = .75 * 360/(2*PI),
                gear_thickness = 2,
                rim_thickness = 2,
                hub_thickness = 2,
                hub_diameter = .5,
                bore_diameter = .5
            );
	}
	translate([0,0,5*tt]) m_nut(2);
	translate([0,0, 8-m_washer_width(2)]) {
		m_washer(2);
	}
}