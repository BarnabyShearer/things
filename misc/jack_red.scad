/*
 * Mult-material test
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 *
 */
for(xxx=[0:2]) for(yyy=[0:2]) {
	translate([50*xxx,60*yyy,0])
scale(.75) {
difference() {
	intersection() {
		cube(center=true,[
			30,
			15,
			.2
		]);
		union() {
			rotate([
				0,
				0,
				90-26.565
			]) {
				translate([
					-1,
					0,
					0
				]) {
					cube([
						1,
						400,
						.2
					]);
				}
			}
			rotate([
				0,
				0,
				90+26.565
			]) {
				translate([
					-1,
					0,
					0
				]) {
					cube([
						1,
						400,
						.2
					]);
				}
			}
			rotate([
				0,
				0,
				270-26.565
			]) {
				translate([
					-1,
					0,
					0
				]) {
					cube([
						1,
						400,
						.2
					]);
				}
			}
			rotate([
				0,
				0,
				270+26.565
			]) {
				translate([
					-1,
					0,
					0
				]) {
					cube([
						1,
						400,
						.2
					]);
				}
			}
	
		}
	}		

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
	

}
	cube(center=true, [
		3,
		15,
		.2
	]);
	cube(center=true, [
		30,
		3,
		.2
	]);

}}
