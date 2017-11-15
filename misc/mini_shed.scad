/*
for(z=[0:8]) {
	translate([
		0,
		-14.5,
		110*z
	]) {
		cube([1200, 14.5, 119]);
	}
	echo("cladding 1200");
}
for(z=[0:10]) {
	translate([
		0,
		900,
		110*z
	]) {
		cube([1200, 14.5, 119]);
	}
	echo("cladding 1200");
}
for(x=[0:1]) {
	for(z=[0:10]) {
		translate([
			(1200-14.5)*x,
			0,
			110*z
		]) {
			cube([14.5,900, 119]);
		}
		echo("cladding 900");
	}
}

for(x=[0:2]) {
	translate([
		14.5+ (1200-47-14.5*2)/2*x,
		47,
		0
	]) {
		cube([47, 900-47*2, 75]);
		echo("wood" , 900-47*2);
	}
}
for(y=[0:1]) {
	translate([
		47+14.5,
		(900-47)/1*y,
		0
	]) {
		cube([1200-47*2-14.5*2, 47, 75]);
		echo("wood", 1200-47*2-14.5*2);
	}
}
//Upright
for(x=[0:1]) {
	for(y=[0:1]) {
		translate([
			14.5+(1200-47-14.5*2)*x,
			(900-75)*y,
			-50
		]) {
			cube([47, 75, 1050 + 220*y]);
			echo("wood", 1050 + 220*y);
		}
	}
}
*/


difference() {
	union() {
		*cube([1220,11,1000]);
		translate([1220-11,11,0]) cube([11,810,1220]);
		translate([0,810+11,0]) cube([1220,11,1220]);
		translate([0,11,0]) cube([11,810,1220]);
		translate([11,11,0]) cube([1220-11*2,810,11]);
		for(x=[0:1]) {
			for(y=[0:1]) {
				translate([
					11+(1220-11-47)*x,
					11+(810-75)*y,
					-100
				]) {
					cube([47, 75, 375]);
					echo("wood", 375);
				}
					translate([
					11+(1220-11-47)*x,
					11+(810-75)*y,
					1000-375 + 220*y
				]) {
					cube([47, 75, 375]);
					echo("wood", 375);
				}
			}
		}
	}
	translate([-10,0,1000]) rotate([asin(210/(810+11*2)),0,0]) cube(10000);
	
}
translate([0,0,1000]) rotate([asin(210/(810+11*2)),0,0]) cube([1220,sqrt(pow(810+11*2,2)+pow(220,2)),11]);
echo("Roof", sqrt(pow(810+11,2)+pow(220,2)));


translate([
	100,
	200,
	11
]) {
	//Dryer
	color([1, 1, 1]) cube([
		600,
		600,
		860
	]);
	color([0, 0, 0]) translate([300, -10, 500]) rotate([90, 0, 0]) cylinder(r=200, h=10);
}