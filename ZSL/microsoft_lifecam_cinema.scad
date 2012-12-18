/*
 * Microsoft LifeCam Cinema
 *
 * Copyright 2012 b@Zi.iS
 *
 * License CC BY 3.0
 */
$fn=60;

camera();

module camera() {
	color([.75,.75,.75]) {
		difference() {
			cylinder(
				r = 27.1/2,
				h = 10
			);
			translate([
				0,
				0,
				-1
			]) {
				cylinder(
					r = 26.6/2,
					h = 45.9 + 2
				);
			}
		}
	}
	translate([
		0,
		0,
		10
	]) {
		color([0,0,0]) {
			cylinder(
				r = 27.1/2,
				h =45.9
			);
		}
	}

	//Cable
	translate([
		0,
		0,
		55.9
	]) {
		color([0,0,0]) {
			cylinder(
				r = 5/2,
				h = 15
			);
		}
	}

	//Mount
	color([0,0,0]) {
		translate([
			26.5/2,
			0,
			36
		]) {
			rotate([
				0,
				90,
				0
			]) {
				cylinder(
					r = 20/2,
					h =10
				);
			}
		}
	}

    //Mic
    color([.75,.75,.75]) {
        translate([
            -26.5/2 - 2,
            -2.5,
            14+15
        ]) {
            rotate([
                0,
                90,
                0
            ]) {
                cube([
                    15,
                    5,
                    3
                ]);
            }
        }
    }
}
	
