$fn=60;

rotate([0,180,0]){
difference() {
union() {
difference() {


	intersection() {
		union() {
			hull(){
translate([
	65-30/2,
	20,
	50-35/2
])
rotate([90,0,0])
scale([6/7.4,1,1])
cylinder(
	r=35/2,
	h=24
);
translate([
	30/2 - 1,
	20,
	50-35/2
])
rotate([90,0,0])
scale([6/7.4,1,1])
cylinder(
	r=35/2,
	h=24
);
			}
translate([0,-10,0])
cube([
	64,
	30,
	50-35/2
]);
		}

		hull(){
cube([64, 8.5+1.1+1.1, 50]);
translate([(64-35)/2,0,0])
cube([35, 17.3, 43]);
		}
	}



translate([0,0,-.1])
	intersection() {
		union() {
			hull(){
translate([
	63-28/2,
	20,
	48-33/2
])
rotate([90,0,0])
scale([6/7.4,1,1])
cylinder(
	r=33/2,
	h=24
);
translate([
	28/2 - 1 +2,
	20,
	48-33/2
])
rotate([90,0,0])
scale([6/7.4,1,1])
cylinder(
	r=33/2,
	h=24
);
			}
translate([0,-10,0])
cube([
	62,
	28,
	48-33/2
]);



		}

translate([2,2,0])
		hull(){
cube([60, 7.5, 48]);
translate([(61-33)/2,0,0])
cube([33, 17.3-4, 41]);
		}


	}
}
translate([
	65-30/2,
	0,
	50-35/2
])
rotate([90,0,0])
scale([6/7.4,1,1])
cylinder(
	r=35/2,
	h=24
);

}


translate([
	64-28/2,
	3,
	49-33/2
])
rotate([90,0,0])
scale([6/7.4,1,1])
cylinder(
	r=31/2,
	h=240
);
translate([
	35,
	-30,
	0
])
cylinder(
	r=30,
	h=100
);

minkowski() {
cylinder(r=1,h=1,$fn=16);
translate([2,2,-.1])
		hull(){
cube([60, 7.5, 10]);
translate([(60-34)/2,0,0])
cube([34, 17.3-4, 10]);
}

}}
}