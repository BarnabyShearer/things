/*
 * bowden extruder mount
 **
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

}

module mount(
	bolt = m3,
	pitch = 50,
	bowden = 5.6/2,
	bowden_nut = m6_nyloc,
	t = 3
) {
	size = [
		pitch + bolt*2 + t*2,
		bowden_nut[1]*2+t,
		bowden_nut[1] + t*2
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

		//bowden nut	
		translate([
			0,
			0,
			t
		]) {
			cylinder(
				r = bowden_nut[0],
				h = bowden_nut[1],
				$fn = 6
			);
		}
	
		translate([
			0,
			0,
			-1
		]) {

			//bowden
			cylinder(
				r = bowden,
				h = size[2]+2
			);

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
				-size[0]/4 + size[0]/2*x,
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

