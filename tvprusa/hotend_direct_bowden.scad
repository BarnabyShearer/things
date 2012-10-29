;/*
 * hotend mount
 *
 * NOTE: This is cut on a lathe.
 * It is tested with 2024 Aluminum.
 *
 * Mounts bowden cable directly to hotend.
 *
 * N.b. Unfortinatly the bowden gets too hot and pulls out.
 *
 * Copyright 2012 <b@Zi.iS> and Bob Shearer
 * License CC BY 3.0
 */
$fn = 60;

hotend();

module hotend(
	nut = 6,
	mount = 6,
	boiler = [
		3.175, //ID
		5, //length
		1, //wall thickness
		.5 //nicrome retaining height
	],
	nozzle = [
		.4, //ID
		 .4 //length
	],
	thermistor = [
		2.3 + .1, //OD
		4.1 +.5, //length
		.5 //wire clearance
	],
	fins = [
		4, //number
		1.5 //spacing
	],
	nicrome = [
		300, //length
		.36, //OD
		.5 //wire clearance
	]
) {
	nicrome_height = nozzle[1] + boiler[1] - ((boiler[0]/2 + boiler[2] + boiler[3]) * sin(30) + boiler[3]);
	nicrome_c = 2 * pi * (boiler[0]/2 + boiler[2]);
	nicrome_layers = (nicrome[0]/nicrome_c) / (nicrome_height/nicrome[1]);

	echo("BRS",((boiler[0]/2 + boiler[2] + boiler[3]) * sin(30) + boiler[3]));
	echo(
		"Stock:",
		M[nut+2][Nut_outer],
		M[nut+2][Nut_thickness]*2 + // Top nut
		M[nut+2][Nut_thickness] + boiler[1] + nozzle[1] // Bottom nut
	);
	echo(
		"top:",
		M[nut+2][Nut_thickness]*2 
	);
	echo(
		"bogttom:",
		M[nut+2][Nut_thickness] + boiler[1] + nozzle[1] // Bottom nut
	);

	echo(
		"Nicrome loops:",
		nicrome[0]/nicrome_c
	);
	
	echo(
		"Nicrome layers:",
		nicrome_layers
	);

	difference() {
		union() {

			//Top nut
			translate([
				0,
				0,
				mount+boiler[1]+nozzle[1]+M[nut][Nut_thickness]
			]) {
				cylinder(
					h = M[nut+2][Nut_thickness]*2,
					r = M[nut+2][Nut_outer]/2,
					$fn=6
				);
			}
			
			//Bottom nut
			translate([
				0,
				0,
				boiler[1]+nozzle[1]
			]) {
				 cylinder(
					h = M[nut+2][Nut_thickness],
					r = M[nut+2][Nut_outer]/2,
					$fn=6
				);
			}

			//Boiler
			drillcut(
				h = boiler[1] + nozzle[1],
				r = boiler[0]/2 + boiler[2]
			);
			//Nicrome retainer
			drillcut(
				h = (boiler[0]/2 + boiler[2] + boiler[3]) * sin(30) + boiler[3],
				r = boiler[0]/2 + boiler[2] + boiler[3]
			);

		}

		//Fins
		for(x=[1:fins[0]+1]) {
			translate([
				0,
				0,
				mount+boiler[1]+nozzle[1]+M[nut][Nut_thickness] + x * M[nut+2][Nut_thickness]*2 / fins[0]
			]) {
				difference() {
					cylinder(
						r = M[nut+2][Nut_outer]/2 + 1,
						h = fins[1]
					);
					cylinder(
						r = M[nut][Nut_major]/2 + 1,
						h = fins[1]
					);
				}					
			}
		}

		//Bowden
		translate([
			0,
			0,
			boiler[1] + nozzle[1] + M[nut+2][Nut_thickness] - M[nut][Nut_thickness]
		]) {
			drillcut(
				h = 100,
				r = M[nut][Nut_minor]/2
			);
		}

		//Thermistor
		translate([
			(M[nut][Nut_minor] + M[nut+2][Nut_outer])/4,
			0,
			boiler[1] + nozzle[1] + M[nut+2][Nut_thickness] - thermistor[1]
		]) {
			cylinder(
				r = thermistor[0]/2,
				h = thermistor[1] + 1
			);
		}
		translate([
			(M[nut][Nut_minor] + M[nut+2][Nut_outer])/4,
			-thermistor[0]/2,
			boiler[1] + nozzle[1] + M[nut+2][Nut_thickness] - thermistor[2]
		]) {
			cube([
				10,
				thermistor[0],
				1
			]);
		}

		//Nicrome Hole
		translate([
			-(M[nut][Nut_minor] + M[nut+2][Nut_outer])/4,
			0,
			boiler[1] + nozzle[1] - 1
		]) {
			cylinder(
				r = nicrome[2],
				h = M[nut+2][Nut_thickness]+2
			);
		}
		translate([
			-(M[nut][Nut_minor] + M[nut+2][Nut_outer])/4 - 10,
			-nicrome[2],
			boiler[1] + nozzle[1] + M[nut+2][Nut_thickness] - thermistor[2]
		]) {
			cube([
				10,
				nicrome[2]*2,
				1
			]);
		}
		
		//Nicrome
		%translate([
			0,
			0,
			(boiler[0]/2 + boiler[2] + boiler[3]) * sin(30) + boiler[3]
		]) {
			cylinder(
				r = boiler[0]/2 + boiler[2] + nicrome_layers * nicrome[1],
				h = nicrome_height
			);
		}

		//Boiler
		translate([
			0,
			0,
			nozzle[1]
		]) {
			drillcut(
				r = boiler[0]/2,
				h = 100
			);
		}

		//Nozzle
		translate([
			0,
			0,
			-1
		]) {
			cylinder(
				r = nozzle[0]/2,
				h = nozzle[1]+2
			);
		}
	}	

}

module drillcut(h, r, angle=30) {
	cylinder(
		r1 = 0,
		r2 = r,
		h = r*sin(angle)
	);
	translate([
		0,
		0,
		r*sin(angle)
	]) {
		cylinder(
			r = r,
			h = h - r*sin(angle)
		);
	}
}

//ISO thread sizes
Nut_major = 0;
Nut_minor = 1;
Nut_thread = 2;
Nut_thickness = 3;
Nut_outer = 4;
Bolt_major = 5;
Bolt_minor = 6;

M=[
	[	0,	0,		0,		0,		0,		0,		0		],
	[	0,	0,		0,		0,		0,		0,		0		],
	[	0,	0,		0,		0,		0,		0,		0		],
	[	3,	2.529,	0.5,	2.4,	6.4,	2.927,	2.3555	],
	[	4,	3.332,	0.7,	3.2,	8.1,	3.908,	3.111	],
	[	5,	4.234,	0.8,	4,		9.2,	4.901,	3.9895	],
	[	6,	5.035,	1,		5,		11.5,	5.884,	4.7435	],
	[	0,	0,		0,		0,		0,		0,		0		],
	[	8,	6.7795,	1.25,	6.5,	15,		7.866,	6.4455	],
	[	0,	0,		0,		0,		0,		0,		0		],
	[	10,	8.526,	1.5,	7,		19.6,	9.85,	8.141	],
];

pi = 3.14;
