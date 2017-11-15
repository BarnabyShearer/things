include <scadhelper/main.scad>;
include <scadhelper/vitamins/nema.scad>;
use <kraken.scad>;

motor=17;
size=[500, 500];
extrusion = 20;
pully = (36 * 2) / PI;

x = size[0]/2+cos(360*$t)*150;
y = size[1]/2+5+sin(360*$t)*180;

translate([30, -10, -400])
	cylinder(d=12, h=500);
translate([size[0]-30,-10, -400])
	cylinder(d=12, h=500);
translate([size[0]/2, size[1], -400])
	cylinder(d=12, h=500);

//X-cariage
translate([72/2, y, -16])
	rotate([-90,0,-90]) {
		lfs81(size[0]-72);
		translate([0, 0, x-72/2]) {
			lfs81_bearing();
			rotate([-90,-90,0])
				translate([0,55,-21])
					kraken() {
						water_tube();
						water_tube();
						bowden();
						bowden();
						bowden();
						bowden();
					}
		}
		
	}
//Y-cariage
translate([0, nema_sizes[motor][0]/2, -13.5])
	rotate([-90,0,0]) {
		lfs81(size[1]-nema_sizes[motor][0]/2-extrusion/2);
		translate([0, 0, y-nema_sizes[motor][0]/2]) lfs81_bearing();
	}
translate([size[0], nema_sizes[motor][0]/2, -13.5])
	rotate([-90,0,0]) {
		lfs81(size[1]-nema_sizes[motor][0]/2-extrusion/2);
		translate([0, 0, y-nema_sizes[motor][0]/2]) lfs81_bearing();
	}

//Cross struts
translate([-extrusion/2, size[1]-extrusion/2, 0])
	rotate([0,90,0])
		ext(size[0]+extrusion);

translate([nema_sizes[motor][0]/2, -20, 0])
	rotate([0,90,0])
		ext(size[0]-nema_sizes[motor][0]);

//Motors
translate([0,0,-23])
	rotate([0,180,0])
		nema()
			translate([0,0,-10])
				cylinder(d=pully, h=10);
translate([size[0],0,-35])
	rotate([0,180,0])
		nema()
			translate([0,0,-10])
				color([0,1,0])
					cylinder(d=pully, h=10);

translate([0,0,-43]) {
	translate([0,size[1],0])
		cylinder(d=pully, h=10);
	translate([size[0],size[1],0])
		cylinder(d=pully, h=10);
	translate([size[0],y+pully/2,0])
		cylinder(d=pully, h=10);
	translate([pully,y-pully/2,0])
		cylinder(d=pully, h=10);

	//blts
	color([1,0,0]) {
		translate([15,0,2])
			cube([2.5, y-15, 6]);
		translate([-15,0,2])
			cube([2.5, size[1], 6]);
		translate([0,size[1]+15,2])
			cube([size[0], 2.5, 6]);
		translate([size[0]+15,y+15,2])
			cube([2.5, size[1]-y-15, 6]);
		translate([x+10,y,2])
			cube([size[0]-x-10, 2.5, 6]);
		translate([pully,y,2])
			cube([x-10-pully, 2.5, 6]);
	}
}

//blts
translate([0,0,-55]) {
	color([0,0,1]) {
		translate([size[0]-pully/2,0,2])
			cube([2.5, y-15, 6]);
		translate([size[0]+pully/2,0,2])
			cube([2.5, size[1], 6]);
		translate([0,size[1]+pully/2,2])
			cube([size[0], 2.5, 6]);
		translate([-pully/2,y+pully/2,2])
			cube([2.5, size[1]-y-pully/2, 6]);
		translate([x+10,y,2])
			cube([size[0]-x-10-pully, 2.5, 6]);
		translate([0,y,2])
			cube([x-10, 2.5, 6]);
	}

	color([0,1,0]) {
		translate([size[0],size[1],0])
			cylinder(d=pully, h=10);
		translate([0,size[1],0])
			cylinder(d=pully, h=10);
		translate([0,y+pully/2,0])
			cylinder(d=pully, h=10);
		translate([size[0]-pully,y-pully/2,0])
			cylinder(d=pully, h=10);
	}
}



module ext(length, size = extrusion, id) {
	part(id, str(length, "mm of ", size, "x", size, "mm extrusion"))
		color([.7,.7,.7])
			cube([size, size, length]);
	translate([0, 0, length])
		children();
}