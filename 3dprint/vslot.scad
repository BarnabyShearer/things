include <scadhelper/main.scad>;
use <scadhelper/vitamins/nema.scad>;
use <scadhelper/vitamins/isel_lfs81.scad>;
use <scadhelper/vitamins/vslot.scad>;
use <scadhelper/vitamins/2d.scad>;
use <scadhelper/vitamins/coupling.scad>;
use <scadhelper/vitamins/rod.scad>;
use <scadhelper/vitamins/v_wheel.scad>;
use <scadhelper/vitamins/hardware.scad>;
use <kraken.scad>;

extruder_height=29;
plate=3;
space=1;

motor=17;
motor_length=59.9;
outsize=[460, 540, 500];
size=[/*outsize[0]-10*/580, outsize[1]-40-3, outsize[2]-30];
extrusion = 20;
pully = (36 * 2) / PI;

x = 0;//cos(360*$t)*(size[0]-150)/2;
y = sin(360*$t)*(size[1]-150)/2;
z = 400;

for(i=[
	-outsize[0]/2+40+10,
	-outsize[0]/2+40-50,
	+outsize[0]/2-40-10,
	+outsize[0]/2-40+50,
]) 
	for(j=[-1,1])
		translate([i, j*(outsize[1]/2-20-1.5), z+53])
			rotate([-90*j,0,0])
				m_washer(5)
					v_wheel_mount();

translate([0, 0, z]) {
	//Motors
	translate([
		-size[0]/2+20,
		-size[1]/2+20,
		extruder_height-20-plate-space*2 + 40
	])
		rotate([0,180,0])
			nema(nema_sizes[motor], motor_length)
				translate([0,0,-15])
					color([.7,.7,.7])
						cylinder(d=pully, h=10);
	
	translate([
		size[0]/2-20,
		-size[1]/2+20,
		extruder_height-20-plate-space*2 + 40
	])
		rotate([0,180,0])
			nema(nema_sizes[motor], motor_length)
				translate([0,0,-25])
					color([.7,.7,.7])
						cylinder(d=pully, h=10);
	
	//Pullys
	color([.7,.7,.7]) {
		translate([-size[0]/2+20,size[1]/2-20,extruder_height-10])
			cylinder(d=pully, h=10);
		translate([size[0]/2-20,size[1]/2-20,extruder_height-10])
			cylinder(d=pully, h=10);
		translate([size[0]/2-20,y+pully/2,extruder_height-10])
			cylinder(d=pully, h=10);
		translate([-size[0]/2+20+pully,y-pully/2,extruder_height-10])
			cylinder(d=pully, h=10);
		translate([size[0]/2-20,size[1]/2-20,extruder_height])
			cylinder(d=pully, h=10);
		translate([-size[0]/2+20,size[1]/2-20,extruder_height])
			cylinder(d=pully, h=10);
		translate([-size[0]/2+20,y+pully/2,extruder_height])
			cylinder(d=pully, h=10);
		translate([size[0]/2-20-pully,y-pully/2,extruder_height])
			cylinder(d=pully, h=10);
	}
	
	//Belts
	color([.9,.9,.9]) {
		translate([-size[0]/2+20+pully/2,-size[1]/2+20,extruder_height-8])
			cube([2.5, y+size[1]/2-20-pully/2, 6]);
		translate([-size[0]/2+20-pully/2,-size[1]/2+20,extruder_height-8])
			cube([2.5, size[1]-40, 6]);
		translate([-size[0]/2+20,size[1]/2-20+pully/2,extruder_height-8])
			cube([size[0]-40, 2.5, 6]);
		translate([size[0]/2-20+pully/2,y+pully/2,extruder_height-8])
			cube([2.5, size[1]/2-y-pully/2-20, 6]);
		translate([x+30,y,extruder_height-8])
			cube([size[0]/2-x-pully-30, 2.5, 6]);
		translate([-size[0]/2+20+pully,y,extruder_height-8])
			cube([size[0]/2+x-30-pully-20, 2.5, 6]);
	
		translate([size[0]/2-20-pully/2,-size[1]/2+20,extruder_height+2])
			cube([2.5, size[1]/2+y-20-pully/2, 6]);
		translate([size[0]/2-20+pully/2,-size[1]/2+20,extruder_height+2])
			cube([2.5, size[1]-40, 6]);
		translate([-size[0]/2+20,size[1]/2-20+pully/2,extruder_height+2])
			cube([size[0]-40, 2.5, 6]);
		translate([-size[0]/2+20-pully/2,y+pully/2,extruder_height+2])
			cube([2.5, size[1]/2-y-pully/2-20, 6]);
		translate([x+30,y,extruder_height+2])
			cube([size[0]/2-x-50-pully, 2.5, 6]);
		translate([-size[0]/2+20,y,extruder_height+2])
			cube([size[0]/2+x-50, 2.5, 6]);
	}
	
	//X-cariage
	translate([0, y, 0]) {
		translate([-size[0]/2+40, +30, extruder_height-space])
			rotate([0,90,0])
				vslot(size[0]-80);
		translate([-size[0]/2+40, -30, extruder_height-space])
			rotate([0,90,0])
				vslot(size[0]-80);	
		translate([x,0,0])
			kraken() {
				water_tube();
				water_tube();
				bowden();
				bowden();
				bowden();
				bowden();
			}
	}
	
	//Z-cariage
	translate([
		-size[0]/2+20,
		-size[1]/2 + nema_sizes[motor][0],
		extruder_height+20+plate+space
	])
		rotate([-90,0,0])
			vslot(size[1] - nema_sizes[motor][0], 2)
				vslot_r([0,1,0],2)
					vslot(size[0]-80, 2)
						vslot_rr([0,1,0],2)
							vslot(size[1] - nema_sizes[motor][0], 2)
									vslot_rr([0,1,0],2)
										translate([0,0,nema_sizes[motor][0]])
											vslot(size[0]-nema_sizes[motor][0]*2, 2);
}

for(x=[-outsize[0]/2+20, outsize[0]/2-20])
	translate([
		x,
		-outsize[1]/2+10,
		0
	])
		vslot(outsize[2], 2) {
			if(x<0)
				vslot_r([0,1,0],2)
					vslot(outsize[0]-80, 2);
			vslot_r([-1,0,0],2)
				vslot(outsize[1]-40, 2) 
					vslot_rr([-1,0,0],2) {
						if(x<0)
							vslot_r([0,1,0],2)
								translate([-40,0,0])
									vslot(outsize[0]-80, 2);
						vslot(outsize[2], 2);
					}
		}

//Z-leadscrews
translate([
	-outsize[0]/2+40+nema_sizes[motor][0]/2,
	-outsize[1]/2+20+nema_sizes[motor][0]/2,
	outsize[2] + plate
])
	rotate([0,180,0])
		nema(nema_sizes[motor], motor_length)
			coupling(d1=5, d2=8, h=25)
				threaded_rod(h=size[2]);

translate([
	outsize[0]/2-40-nema_sizes[motor][0]/2,
	-outsize[1]/2+20+nema_sizes[motor][0]/2,
	outsize[2] + plate
])
	rotate([0,180,0])
		nema(nema_sizes[motor], motor_length)
			coupling(d1=5, d2=8, h=25)
				threaded_rod(h=size[2]);

translate([
	0,
	+outsize[1]/2-20-nema_sizes[motor][0]/2,
	outsize[2] + plate
])
	rotate([0,180,0])
		nema(nema_sizes[motor], motor_length)
			coupling(d1=5, d2=8, h=25)
				threaded_rod(h=size[2]);	
//Bed
translate([-(size[0]-170)/2, -(size[1]-170)/2, -3])
	cube([size[0]-170,size[1]-170,3]);

echo(str("Print area: ", size[0]-180, "×", size[1]-180, "×", size[2]-50, "mm"));