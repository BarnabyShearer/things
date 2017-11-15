//Buffer-Local Properties for jEdit, www.jedit.org
//:indentSize=4:tabSize=4:collapseFolds=true:folding=explicit:mode=c:

//
// (c) Andreas Thorn (andreas.thorn@gmail.com)
//	Thingiverse: 
//	
// Licence: Attribution - Share Alike - Creative Commons
//


//{{{ Info, Changelog
/*************************************************************************************************
Custom mount for Bulldog XL extruder. Integrated axial fan.
(Original mount comes with a pretty exotic radial fan which is very prone to
dying.)

Changelog;
101	Visual representation of screws added but disabled.
100	Initial work. The Bulldog is simplified with only the important dimensions.
**************************************************************************************************/
//}}}
//{{{ Variables and constants
shim = 0.1;								// used overlap meshes/cutouts
$fn = 60;

dim=[40,40];
//}}}

module bulldogxl() {
translate([-81/2,-56/2,-55/2]) {
//projection(cut=true) {
//translate([-81/2,-56/2,-0.5]) {

//{{{ Hotend clamp
difference() {
	// Full block with union instead of using cutaways
	*color([0.5,1.0,0.7,1.0])
	union() {
		translate([0,0,0])
		cube([21,56,4.5]);

		translate([0,(56-42)/2,4.5])
		cube([21,42,12.7-4.5]);
	}

	// Main block
	color([0.5,0.5,0.5,1.0])
	translate([0,0,0])
	cube([21,56,12.7]);

	// Bottom cutaway. We use cutaways to indicate material removal. Just for fun.
	color([1.0,1.0,0.3,1.0])
	translate([-shim,-shim,4.5])
	cube([21+(2*shim),((56-42)/2)+shim,(12.7-4.5)+shim]);

	// Top cutaway. We use cutaways to indicate material removal. Just for fun.
	color([1.0,1.0,0.3,1.0])
	translate([-shim,56-((56-42)/2),4.5])
	cube([21+(2*shim),((56-42)/2)+shim,(12.7-4.5)+shim]);

	// Bottom mount screw hole
	translate([21/2,3.5,-shim])
	cylinder(d=3,h=4.5+(2*shim));

	// Top mount screw hole
	translate([21/2,56-3.5,-shim])
	cylinder(d=3,h=4.5+(2*shim));

	color([1.0,1.0,0.3,1.0])
	hull() {
		// Small hexbolt screw hole
		translate([9,10,-shim])
		cylinder(d=6,h=4.1+(2*shim));
		
		translate([9,10+5,-shim])
		cylinder(d=6,h=4.1+(2*shim));
	}
	translate([7.5+(3/2),10,-shim])
	cylinder(d=3,h=12.7+(2*shim));

	// Big hexbolt screw hole
	color([1.0,0.7,0.3,1.0])
	translate([4.5+(9/2),56-20.5,-shim])
	cylinder(d=9,h=8+(2*shim));

	translate([6.5+(5/2),56-20.5,-shim])
	cylinder(d=5,h=12.7+(2*shim));

	color([1.0,1.0,0.3,1.0])
	hull() {
	// Hotend hole top
	translate([4.5+(9.3/2),56-36,12.7-4.1])
	cylinder(d=15.9,h=4.1+(2*shim));

	translate([-5,56-36,12.7-4.1])
	cylinder(d=15.9,h=4.1+(2*shim));
	}

	color([1.0,1.0,0.3,1.0])
	hull() {
	// Hotend hole middle
	translate([4.5+(9.3/2),56-36,12.7-4.1-4.5-shim])
	cylinder(d=12,h=4.5+(2*shim));

	translate([-5,56-36,12.7-4.1-4.5-shim])
	cylinder(d=12,h=4.5+(2*shim));
	}

	color([1.0,1.0,0.3,1.0])
	hull() {
	// Hotend hole bottom
	translate([4.5+(9.3/2),56-36,-shim])
	cylinder(d=15.9,h=4.1+(2*shim));

	translate([-5,56-36,-shim])
	cylinder(d=15.9,h=4.1+(2*shim));
	}

}
//}}}

//{{{ Drive block
translate([0,(56-42)/2,12.7])
color([0.7,0.7,0.7,1.0])
union() {
	translate([0,0,0])
	cube([22.5,42,42]);
}
//}}}
//{{{ Gearbox cover
translate([22.5,(56-42)/2,12.7])
color([0.2,0.2,0.2,1.0])
union() {
	translate([0,0,0])
	cube([20,42,42]);
}
//}}}
//{{{ Gearbox metal flange
translate([22.5+20,(56-42)/2,12.7])
color([0.7,0.7,0.7,1.0])
hull() {
	translate([0,(42-29)/2,0])
	cube([4.5,29,42]);

	translate([0,0,(42-29)/2])
	cube([4.5,42,29]);
}
//}}}
//{{{ Stepper motor
translate([22.5+20+4.5,(56-42)/2,12.7])
color([0.5,0.5,0.5,1.0])
hull() {
	translate([0,(42-29)/2,0])
	cube([34,29,42]);

	translate([0,0,(42-29)/2])
	cube([34,42,29]);
}
//}}}

//{{{ Screw holes visualization
// For making screw holes in the mount
*translate([0,0,0])
mirror([0,0,1])
union() {
	// Bottom mount screw hole
	translate([21/2,3.5,0])
	cylinder(d=3+0.3,h=40);

	// Top mount screw hole
	translate([21/2,56-3.5,0])
	cylinder(d=3+0.3,h=40);

	// Small hexbolt screw hole
	*translate([9,10,-shim])
	cylinder(d=6+0.3,h=4.1+(2*shim));

	// Big hexbolt screw hole
	*translate([4.5+(9/2),56-20.5,-shim])
	cylinder(d=9+0.3,h=40);
	
	// Hotend hole
	*translate([4.5+(9.3/2),56-36,0])
	cylinder(d=18.5+1.5,h=40);
}
//}}}
}
}

bulldogxl();

//{{{ Module polyhole
// http://hydraraptor.blogspot.se/2011/02/polyholes.html
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}
//}}}
//{{{ Module cylinda
module cylinda(diam=1,height=1,fn=60,polyhole=0)
{
	if (polyhole==1)
	{
		polyhole(h=height,d=diam);
	} else {
		cylinder(r=diam/2,h=height,$fn=fn);
	}
}
//}}}

