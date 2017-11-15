m8 = 7.80 / 2;
m3 = 2.8 /2;
m3_nut = 6.1 /2;

prusa_belt_height = 11.5;
prusa_belt_offset = 17.5;

t5_thickness = 2.5;
t5_width = 5;

t5_16=14;

608bearing = 22/2;
608bearing_width = 7;

m8washer = 15.8/2;
m8washer_width=1.5;


xrodgap = 50;	
zrodgap=30;

	rod = m8;
	thickness = 1.1;
	belt_width=t5_width;
	belt_thickness=t5_thickness;
	belt_height = prusa_belt_height;
	belt_offset = prusa_belt_offset;
	pully = t5_16;
	pully_length=20;
	bearing = 608bearing;
	bearing_width = 608bearing_width;
	washer = m8washer;
	washer_width = m8washer_width;

		//Placeholders

		%for(r=[0:1]) {
			//Z-Rods
			translate([
				zrodgap*r,
				0,
				-50
			]) {
				cylinder(
					r=rod,
					h=100
				);
			}

			//X-Rods
			translate([
				0,
				-xrodgap/2+xrodgap*r,
				0
			]) {
				rotate([
					0,
					90,
					0,
				]) {
					cylinder(
						r = rod,
						h =100
					);
				}
			}

		}

difference(){

rotate([0,110.85,0])
difference() {
hull() {
translate([12,10, 25]) rotate([90,0,0])  cylinder(r=10/2, h=43);


for(x=[0:1]) {
translate([
	0,
	-25+50*x,
	0
])
	rotate([
		0,
		90,
		0
	]) {

			cylinder(
				r = 10/2,
				h = 25
			);
		
	}
}


	translate([
		0,
		0,
		1
	]) 
		cylinder(
			r=18/2,
			h=28
		);
}

	translate([
		-100,
		-60,
		1-.1
	]) cube(100);
	
	translate([
		0,
		0,
		3
	]) {
		cylinder(
			r=7.6,
			h=26+.1
		);
	}
translate([0,0,-.1]) cylinder(r=8/2, h=4);
for(x=[0:1]) {
translate([
	0,
	-25+50*x,
	0
])
	rotate([
		0,
		90,
		0
	]) {
			translate([0,0,-.1]) cylinder(
				r = 8/2,
				h = 26
			);
			translate([-1,-15,-20]) cube(100);
		}
	}

translate([12,20, 25]) rotate([90,0,0])  cylinder(r=8/2, h=63);
translate([-.1,10,16.4])
cube(50);

translate([-.1,-12,5]) cube([100,2,5]);
translate([-.1,10,5]) cube([100,2,5]);
translate([-.1,-12,16.4]) cube([100,2,5]);
translate([-.1,10,16.4]) cube([100,2,5]);

translate([2, -25, 0])
rotate([0,90,0]) 
difference() {
	cylinder(
		r=8,
		h=5
	);
	translate([0,0,-.1]) cylinder(
		r=6,
		h=5.2
	);
}


translate([18, -25, 0])
rotate([0,90,0]) 
difference() {
	cylinder(
		r=8,
		h=5
	);
	translate([0,0,-.1]) cylinder(
		r=6,
		h=5.2
	);
}

translate([2, 25, 0])
rotate([0,90,0]) 
difference() {
	cylinder(
		r=8,
		h=5
	);
	translate([0,0,-.1]) cylinder(
		r=6,
		h=5.2
	);
}


translate([18, 25, 0])
rotate([0,90,0]) 
difference() {
	cylinder(
		r=8,
		h=5
	);
	translate([0,0,-.1]) cylinder(
		r=6,
		h=5.2
	);
}

}

rotate([0,0,90])
		translate([-25-15.8/2+5/2+1, -6, 28-3-4.7+12.5-8]) rotate([0,90,0]) 
		%cylinder(h=5+2,r=8/2,$fn=9,center=true);


translate([-500,-500,-1024.9]) cube(1000);}