/*
 * A desendent of Theo Jansen's Strandbeests
 *
 * Copyright 2013 Barnaby Shearer <b@Zi.iS>
 * License CC BY 3.0
 */
$fa = 1;
$fs = 1;
preview = 0;

beast();

module beast(
	scale = .1
) {
	a = 380*scale;
	l=78*scale;

	if(preview==1) {
	
		for(x=[0:3]) {
			translate([
				0,
				0,
				x*28
			]) {
				leg(phase=x%2 * 180) {
					rotate([
						0,
						180,
						0
					]) {
						leg(phase=x%2 * 180, dir=-1);
					}
				}
				if(x<3) {
					translate([
						a,
						l,
						4
					]) {
						rotate([
							0,
							0,
							$t*360 + x%2 * 180
						]) {
							cam();
						}
					}
					rib();
					spine();
					translate([
						a*2,
						0,
						0,
					]) {
						spine();
					}
				}
				if(x>0) {
					rotate([
						180,
						0,
						180,
					]) {
						translate([
							-2*a,
							0,
							0,
						]) {
							rib();
						}
					}
				}
			}
		}
	} else {
		leg();
		rotate([
			180,
			0,
			0
		]) {
			translate([
				0,
				15,
				-8
			]) {
				rib();
			}
		}
		translate([
			-10,
			-15,
			-8
		]) {
			spine();
		}
		translate([
			55,
			40,
			3
		]) {
			rotate([
				0,
				90,
				0
			]) {
				//cam();
			}
		}
	}
}

function tri2ang(a, b, c)  = acos((pow(a, 2) + pow(b, 2)-pow(c, 2))/(2 * a * b));
function h(a, b) = pow(pow(a, 2) + pow(b, 2), 0.5);

module e() {
	if(preview==1) {
		translate([
			0,
			0,
			-.1
		]) {
			scale([
				1,
				1,
				1.1
			]) {
				child();
			}
		}
	} else {
		child();
	}
}

module spine(
	r1 = 3/2,
	r2 = 6/2,
	gap = 28,
	t=2
) {
	difference() {
		translate([
			0,
			0,
			t *4
		]) {
			cylinder(
				r = r2,
				h = gap-t*10
			);
		}
		translate([
			0,
			0,
			t *4
		]) {
			e() cylinder(
				r = r1,
				h = gap-t*10
			);
		}
	}
}

module rib(
	scale = .1,
	r1 = 3/2,
	r2 = 6/2,
	gap = 28,
	t = 2,
) {
	a = 380*scale;
	l=78*scale;
	difference() {
		union() {
			translate([
				a,
				l,
				t *2
			]) {
				cylinder(
					r = r2+1+t,
					h = t*2
				);
			}
			*translate([
				a- r2-t,
				l- r2-t- r2-t,
				t *3
			]) {
				cube([
					 r2+t+r2+t,
					 r2+t+ r2+t,
					t
				]);
			}
			cylinder(
				r = r2,
				h = t*4
			);
			translate([
				a*2,
				0,
				0
			]) {
				cylinder(
					r = r2,
					h =t*4
				);
			}
		
			translate([
				0,
				-r2,
				t *3
			]) {
				cube([
					a*2,
					r2*2,
					t,
				]);
			}
		}
		translate([
			a,
			l,
			t*2
		]) {
			e() cylinder(
				r = r2+1,
				h = t*2
			);

		}
		e() cylinder(
			r = r1,
			h = (gap-t)/2
		);
		translate([
			a*2,
			0,
			0
		]) {
			e() cylinder(
				r = r1,
				h = (gap-t)/2
			);
		}
	}
}

module cam(
	scale = .1,
	r1 = 3/2,
	r2 = 6/2,
	gap = 20,
	t = 2,
	phase=180,
) {
	m=150*scale;
	difference() {
		union() {
			intersection() {
				rotate([
					0,
					90,
					0
				]) {
					intersection() {
						translate([
							-3,
							-gap/2,
							-r2
						]) {
							cylinder(
								r=gap,
								h=r2*2
							);
						}
						translate([
							-gap+3,
							gap/2,
							-r2
						]) {
							cylinder(
								r=gap,
								h=r2*2
							);
						}
					}
				}
				cylinder(
					r = r2+1,
					h = gap
				);
			}
			hull() {
				translate([
					-r2,
					1,
					0
				]) {
					cube([
						r2*2,
						1,
						t
					]);
				}
				translate([
					0,
					m,
					0
				]) {
					cylinder(
						r = r2,
						h = t
					);
				}			
			}
		}
		translate([
			0,
			m,
			0
		]) {
			e() cylinder(
				r = r1,
				h = t
			);
		}	
	}
	translate([
		0,
		0,
		gap-t
	]) {
		rotate([
			0,
			0,
			phase
		]) {
			difference() {
				hull() {
					translate([
						-r2,
						1,
						0
					]) {
						cube([
							r2*2,
							1,
							t
						]);
					}
					translate([
						0,
						m,
						0
					]) {
						cylinder(
							r = r2,
							h = t
						);
					}			
				}
				translate([
					0,
					m,
					0
				]) {
					e() cylinder(
						r = r1,
						h = t
					);
				}	
			}
		}
	}
}

module tri(a, b, c, r1, r2, t, holes=3) {
	y = tri2ang(a, b, c);
	difference() {
		hull() {
			cylinder(
				r = r2,
				h = t
			);
			translate([
				0,
				a,
				0
			]) {
				cylinder(
					r = r2,
					h = t
				);
			}
			translate([
				sin(y)*b,
				cos(y)*b,
				0
			]) {
				cylinder(
					r = (holes>2) ? r2 : .1,
					h = t
				);
			}
		}
		e() cylinder(
			r = r1,
			h = t
		);
		translate([
			0,
			a,
			0
		]) {
			e() cylinder(
				r = r1,
				h = t
			);
		}
		if(holes>2) {
			translate([
				sin(y)*b,
				cos(y)*b,
				0
			]) {
				e() cylinder(
					r = r1,
					h = t
				);
			}
		}
	}
}

module strut(length, r1, r2, t) {
	difference() {
		union() {
			cylinder(
				r = r2,
				h = t
			);
			translate([
				0,
				-r2,
				0
			]) {
				cube([
					length,
					r2*2,
					t
				]);
			}
			translate([
				length,
				0,
				0
			]) {
				cylinder(
					r = r2,
					h = t
				);
			}
		}
		e() cylinder(
			r = r1,
			h = t
		);
		translate([
			length,
			0,
			0
		]) {
			e() cylinder(
				r = r1,
				h = t
			);
		}
	}
}

module leg(
	scale = .1,	
	r1 = 3/2,
	r2 = 6/2,
	t = 2,
	phase= 0,
	dir = 1
) {
	a = 380*scale;
	b = 415*scale;
	c = 393*scale;
	d = 401*scale;
	e = 558*scale;
	f = 394*scale;
	g = 367*scale;
	h = 657*scale;
	i = 490*scale;
	j = 500*scale;
	k = 619*scale;
	l=78*scale;
	m=150*scale;

	p1 = [
		a - sin(($t*360+phase)*dir)*m,
		l + cos(($t*360+phase)*dir)*m,
		0
	];
	cgk_x = cos(atan(p1[1]/p1[0]) - tri2ang(h(p1[0],p1[1]), c, k)) * c;
	cgk_y =sin(atan(p1[1]/p1[0]) - tri2ang(h(p1[0],p1[1]), c, k)) * c;
	def_x = cos(atan(p1[1]/p1[0]) + tri2ang(h(p1[0],p1[1]), b, j) + tri2ang(b, d, e)) * d;
	def_y = sin(atan(p1[1]/p1[0]) + tri2ang(h(p1[0],p1[1]), b, j)+ tri2ang(b, d, e)) * d;
	
	if(preview==1) {
		
		rotate([
			0,
			0,
			-90 + atan(p1[1]/p1[0]) + tri2ang(h(p1[0],p1[1]), b, j)
		]) {
			tri(b, -d, e, r1, r2, t);
		}
		
		translate([
			def_x,
			def_y,
			-t
		]) {
			rotate([
				0,
				0,
				atan((cgk_y-def_y)/(cgk_x-def_x)) - 
				tri2ang(h(cgk_y-def_y,cgk_x-def_x), f,g)
			]) {
				strut(f, r1, r2, t);
			}
		}
		
		rotate([
			0,
			0,
			atan(p1[1]/p1[0]) - tri2ang(h(p1[0],p1[1]), c, k)
		]) {
			translate([
				0,
				0,
				-t
			]) {
				strut(c, r1, r2, t);
			}
			translate([
				c,
				0,
				0
			]) {
				rotate([
					0,
					0,
					180 - tri2ang(c, k, h(p1[0],p1[1]))
				]) {
					translate([
						0,
						0,
						t
					]) {
						strut(k, r1, r2, t);
					}
				}
				rotate([
					0,
					0,
					90 - 
					(atan(p1[1]/p1[0]) - tri2ang(h(p1[0],p1[1]), c, k)) +
					atan((cgk_y-def_y)/(cgk_x-def_x)) +
					tri2ang(h(cgk_y-def_y,cgk_x-def_x), g, f)
				]) {
					tri(g,-i,h, r1, r2, t, 2);
				}
			}
		}
		translate(p1) {
			rotate([
				0,
				0,
				180 + atan(p1[1]/p1[0]) - tri2ang(h(p1[0],p1[1]), j, b)
			]) {
				strut(j, r1, r2, t);
			}
		}
	} else{
		translate([-10,0,0]) tri(b, -d, e, r1, r2, t);
		translate([100,0,0]) tri(g,-i,h, r1, r2, t,2);
		translate([0,0,0])	strut(f, r1, r2, t);
		translate([0,10,0])	strut(c, r1, r2, t);
		translate([0,20,0])	strut(k, r1, r2, t);
		translate([0,30,0])	strut(j, r1, r2, t);
	}
	translate([
		a*2,
		0,
		0
	]) {
		child(0);
	}
}