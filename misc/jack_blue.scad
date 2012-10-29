/*
 * Mult-material test
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 *
 */
for(xxx=[0:2]) for(yyy=[0:2]) {
	translate([60*xxx,50*yyy,0])
scale(.75) {
difference() {
	cube(center=true, [
		30,
		15,
		.2,
	]);
	cube(center=true, [
		5,
		400,
		1
	]);
	cube(center=true, [
		400,
		5,
		1
	]);
	
	
	rotate([
		0,
		0,
		26.565
	]) {
		cube(center=true, [
			400,
			3,
			1
		]);
	}
	
	rotate([
		0,
		0,
		-26.565
	]) {
		cube(center=true, [
			400,
			3,
			1,
		]);
	}

}}
}
