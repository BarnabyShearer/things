/*
 * fan
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../config.scad>;

fan();

module fan(
	size = fan40
) {
	echo("Fan ", size[0], "mm");
	color([.3,.3,.3]) {
		difference() {
			hull() {
				for(x=[0:1]) {
					for(y=[0:1]) {
						translate([
							-size[2]/2 + size[2] * x,
							-size[2]/2 + size[2] * y,
							0
						]) {
							cylinder(
								r = (size[0] - size[2])/2,
								h = size[1]
							);
						}
					}
				}
			}
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						-size[2]/2 + size[2] * x,
						-size[2]/2 + size[2] * y,
						0
					]) {
						e() cylinder(
							r = m_pilot(size[3]),
							h = size[1]
						);
					}
				}
			}
			e() cylinder(
				r = size[0]/2*.9,
				h = size[1]
			);
		}
	}

	color([.7,.7,.7]) {
		cylinder(
			r = size[0]/2*.4,
			h = size[1]
		);
		linear_extrude(
			twist=30,
			height =  size[1]
		) {
			square(center=true, [size[0]*.8,1]);
			square(center=true, [1, size[0]*.8]);
		}
	}
}
