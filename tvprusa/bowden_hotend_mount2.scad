/*
 * bowden hotend mount
 *
 * Replace the extruder on the x-carriage with a bowden cable.
 *
 * Serendipitously you can just run an M6 nyloc nut onto the end of the PTFE
 * tube for a perfect grip
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */
$fn = 60;

m3 = 3.2 /2;
m6_nyloc = [
	11.28 /2,
	6
];

rotate([
	-90,
	0,
	0
]) {
	mount();
	translate([
		0,
		0,
		20
	]) {
		mount();
	}
}

module mount(
	bolt = m3,
	pitch = 50,
	bowden = 5.6/2,
	bowden_nut = m6_nyloc,
	hotend = [16/2, 3.5],
	hotend_pitch = 20,
	t = 3
) {
	size = [
		pitch + bolt*2 + t*2,
		hotend[0]*2 + t*2,
		hotend[1] + bowden_nut[1] + t*2
	];

	difference() {
		translate([
			-size[0]/2,
			0,
			0
		]) {
			cube([
				size[0],
				size[1]/2,
				size[2]
			]);
		}
for(x=[0:1]) {
		//bowden nut	
		translate([
			-hotend_pitch/2 + hotend_pitch*x,
			0,
			hotend[1] + t
		]) {
			cylinder(
				r = bowden_nut[0],
				h = bowden_nut[1],
				$fn = 6
			);
		}
	
		translate([
			-hotend_pitch/2 + hotend_pitch*x,
			0,
			-1
		]) {
			//hotend
			cylinder(
				r = hotend[0],
				h = hotend[1]+1
			);
			//bowden
			cylinder(
				r = bowden,
				h = size[2]+2
			);
		}
		translate([
		   0,
			0,
			-1
		]) {

			//x-carrage bolts
			for(x=[0:1]) {
				translate([
					-pitch/2 + x*pitch,
					0,
					0
				]) {
					cylinder(
						r = bolt,
						h = size[2]+2
					);
				}
			}
		}

		//bolts
		for(x=[0:1]){
			translate([
				-size[0]/3 + size[0]/3*x*2,
				-1,
				size[2]/2
			]) {
				rotate([
					-90,
					0,
					0
				]) {
					cylinder(
						r = bolt,
						h = size[1]
					);
				}
			}
		}
	}
}
}	

