/***************************************************************************************
 * Tapered pocket coin-op by Brett Beauregard (br3ttb)
 *
 * Notes:  
 * -  with the non-tapered pocket coin-op I tested changing all the input variables.  I'm pretty confident in the 
 *    geometry now, so I don't think people will need to adjust very much.  I did test the coin and thickness
 *    variables though, as those may actually be modified.
 *
 * - if you adjust the coin size you may get an error when trying to export the stl.  this is likely due to an 
 *   intersection between the coin hole and the key ring slot.  you can either adjust the slot dimensions or
 *   the coin overhang to correct this
 ***************************************************************************************/

//Coin Size and position
coinRadius = 9;
coinThickness = 2;
coinOverhang = 3;

//Thickness / Taper
thickness=6;
inset =1.75;
centerthickness=2.5;

//KeyRingSlot
slotWidth = 17;
slotHeight = 4;
slotInset=3.25;


//set to false if you don't want the makerbot M to appear
UseBadge=false;

//Overall Opener Configuration 
base = 22;
length=50;
baseR1=5;
baseR2=5;
angle = 13.5;

//Hole Configuration
holeBaseWidth=22.5;
holeBaseLoc=25.5;
holeLength=19.5;
holeR1=2;
holeR2=6;

for(xxx=[0:2]) for(yyy=[0:2]) {
	rotate([0,0,90])translate([60*xxx,50*yyy,0])opener();
}

//BRSstar(10, .5);

module opener()
{

	if(UseBadge){
		translate([(holeBaseLoc+slotHeight+slotInset)/2,base/2,thickness])	{
		rotate([0,0,-90])BRSstar((holeBaseLoc-slotHeight-slotInset)/2-1.25,0.5);
		difference()	{
			cylinder(r=(holeBaseLoc-slotHeight-slotInset)*0.4, h=0.5);
			cylinder(r=(holeBaseLoc-slotHeight-slotInset)*0.4-1, h=0.5);
			}
		} 
	}
	
	difference()	{
		roundedInsetTrapezoid(length=length, r1=baseR1, r2=baseR2,mainthick=thickness,
					        baseW=base, angle=angle, inset=inset, centerthick=centerthickness);
		
		translate([holeBaseLoc,(base-holeBaseWidth)/2,0]) 
			roundedTrapezoid(thick=thickness, baseW=holeBaseWidth, angle=angle, length=holeLength, r1=holeR1, r2=holeR2);
		translate([slotHeight/2+slotInset,(base-slotWidth+slotHeight)/2,0])cylinder(r=slotHeight/2, h=thickness);
		translate([slotHeight/2+slotInset,(base+slotWidth-slotHeight)/2,0])cylinder(r=slotHeight/2, h=thickness);
		translate([slotInset,(base-slotWidth+slotHeight)/2,0])cube([slotHeight,slotWidth-slotHeight,thickness]);
		
		translate([holeBaseLoc-coinRadius+coinOverhang,base/2,(thickness-coinThickness)/2])
		{
			translate([0,-coinRadius,0])cube([coinRadius,2*coinRadius,coinThickness]);
			cylinder(r=coinRadius,h=coinThickness);
		}
	} 
}




module roundedTrapezoid(thick=5, length=19.5, r1=2, r2=9.5, angle=13.5, baseW=23)
{
	x1 = length*sin(angle);
	difference()
	{
	trapezoidSolid(thick = thick, length = length, r1=r1, r2=r2, angle = angle, baseW=baseW);
		translate([length,-1*x1,0])cube([2*r2-length,baseW+2*x1,thick]);
		rotate([0,0,-1*angle])translate([0,-1*(r1+r2),0])cube([length,r1+r2, thick]);
		translate([0,baseW,0]) rotate([0,0,angle])cube([ length,r1+r2, thick]);
	}
}


module trapezoidSolid(thick=5, length=19.5, r1=1, r2=9.5, angle=13.5, baseW=23)
{
	r1oSet = length/cos(angle)-r1*tan((90+angle)/2);// -r1-r1*tan(angle);//-r1/cos(angle);
	sideoSet = r2*tan((90-angle)/2);// r2*(1- tan(angle));
	sidelen = r1oSet-sideoSet;
	bottomoSet = (length*sin(angle))-r1*tan((90+angle)/2);
	
	rotate([0,0,-1*angle])
	{
		translate([r1oSet,r1,0])cylinder(h=thick, r=r1);
		translate([sideoSet,r2,0])cylinder(h=thick,r=r2);
		translate([sideoSet,0,0]) cube([sidelen,2*r1,thick]);
	}
	translate([0,baseW,0])rotate([0,0,angle])
	{
		translate([0,-2*r1,0])
		{
			translate([r1oSet,r1,0])cylinder(h=thick, r=r1);
			translate([sideoSet,-r2+2*r1,0])cylinder(h=thick,r=r2);
			translate([sideoSet,0,0]) cube([sidelen,2*r1,thick]);
		}
	}
	translate([0,sideoSet,0])cube([length,baseW-2*sideoSet,thick]);
	translate([r2,-bottomoSet,0])cube([length-r2,baseW+2*bottomoSet,thick]);
}


module MakerbotM(height, thickness) 
{
	radius = height/5.5;
	translate([-1.25*radius,1.5*radius,0])
	{
		difference() {
			cylinder(r=radius,h = thickness, $fn=20);
			translate([0,-1*radius,0])cube([radius,radius,thickness]);
		}
		translate([2.5*radius,0,0])difference() {
			cylinder(r=radius,h = thickness, $fn=20);
			translate([-1*radius,-1*radius,0])cube([radius,radius,thickness]);
		}
		translate([-1*radius,0,0]) {
			translate([0,-3.5*radius,0])cube([radius,3.5*radius,thickness]);
			translate([radius/2,-3.5*radius,0])cylinder(r=radius/2,h=thickness, $fn=20);
		}
		translate([0.75*radius,0,0]) {
			translate([0,-3.5*radius,0])cube([radius,4.5*radius,thickness]);
			translate([radius/2,-3.5*radius,0])cylinder(r=radius/2,h=thickness, $fn=20);
		}
		translate([2.5*radius,0,0]) {
			translate([0,-3.5*radius,0])cube([radius,3.5*radius,thickness]);
			translate([radius/2,-3.5*radius,0])cylinder(r=radius/2,h=thickness, $fn=20);
		}
		cube([2.5*radius,radius,thickness]);
	}
}

module BRSstar(height, thickness) 
{

difference() {
union() {
	translate([
		0,
		-height/6,
		0
	]) {
		rotate([
			0,
			0,
			18+180
		]) {
			cylinder(
				r=height/5,
				h=thickness,
				$fn=5
			);
		}
	}
	cube(center=true, [
		height,
		thickness,
		thickness
	]);
	translate([
		-.5*height+cos(36)*height/2,
		-sin(36)*height/2,
		0
	]) {
		rotate([
			0,
			0,
			-36
		]) {
			cube(center=true, [
				height,
				thickness,
				thickness
			]);
		}
	}
	translate([
		+.5*height-cos(36)*height/2,
		-sin(36)*height/2,
		0
	]) {
		rotate([
			0,
			0,
			36
	]) {
			cube(center=true, [
				height,
				thickness,
				thickness
			]);
		}
	}
	translate([
		-sin(18)*height/2,
		cos(18)*height/2-sin(36)*height,
		0
	]) {
		rotate([
			0,
			0,
			72
	]) {
			cube(center=true, [
				height,
				thickness,
				thickness
			]);
		}
	}
	translate([
		sin(18)*height/2,
		cos(18)*height/2-sin(36)*height,
		0
	]) {
		rotate([
			0,
			0,
			-72
	]) {
			cube(center=true, [
				height,
				thickness,
				thickness
			]);
		}
	}
}
translate([
	0,
	-height/40*8,
	-1
]) {
cylinder(
	r=thickness,
	h=thickness+3,
	$fn=60
);	
}
translate([
	0,
	-height/40*5,
	-1
]) {
cylinder(
	r=thickness,
	h=thickness*6,
	$fn=60
);	
}
translate([
	-thickness*1.25,
	-height/40*10.5,
	-1
]) {
cube([
	thickness,
	height/40*8,
	thickness+2
]);	
}
}
}


module roundedInsetTrapezoid(mainthick=6, length=19.5, r1=2, r2=9.5, angle=13.5, baseW=23, inset =1.75, centerthick=2.5) 
{
	thick = (mainthick-centerthick)/2;
	 topr1=r1-inset;
	topr2=r2-inset;
	x1 = length*sin(angle);
	r1oSet = length/cos(angle)-r1*tan((90+angle)/2);// -r1-r1*tan(angle);//-r1/cos(angle);
	sideoSet = r2*tan((90-angle)/2);// r2*(1- tan(angle));
	sidelen = r1oSet-sideoSet;
	bottomoSet = (length*sin(angle))-r1*tan((90+angle)/2);
	sideangle = atan(inset/thick);
	difference()
	{
		union(){
			translate([0,0,thick+centerthick])roundedInsetSolid(thick=thick, length=length, r1=r1, r2=r2, angle=angle, baseW=baseW, inset =inset);
			translate([0,0,thick])roundedInsetSolid(thick=centerthick, length=length, r1=r1, r2=r2, angle=angle, baseW=baseW, inset =0);
			translate([0,baseW,thick])rotate([180,0,0])
				roundedInsetSolid(thick=thick, length=length, r1=r1, r2=r2, angle=angle, baseW=baseW, inset =inset);
		}
	
		//top angles
		translate([0,0,thick+centerthick])
		{
			translate([0,baseW,0]) rotate([0,0,angle])rotate([sideangle,0,0])cube([ length,r1+r2, thick+r1]);
			rotate([0,0,-1*angle])translate([0,-1*(r1+r2),0])translate([0,(r1+r2),0])
				rotate([-1*sideangle,0,0])translate([0,-1*(r1+r2),0])cube([length,r1+r2, thick+r1]);
			rotate([0,sideangle,0])translate([-2*thick,0,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
			translate([length,-1*length*tan(angle),0])rotate([0,-1*sideangle,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
		}
		
		//side angles	
		rotate([0,0,-1*angle])translate([0,-1*(r1+r2),0])cube([length,r1+r2, mainthick]);
		translate([0,baseW,0]) rotate([0,0,angle])cube([ length,r1+r2, mainthick]);
		
		
		//bottom angles
		translate([0,baseW,thick])rotate([180,0,0])
		{
			translate([0,baseW,0]) rotate([0,0,angle])rotate([sideangle,0,0])cube([ length,r1+r2, thick+r1]);
			rotate([0,0,-1*angle])translate([0,-1*(r1+r2),0])translate([0,(r1+r2),0])rotate([-1*sideangle,0,0])
				translate([0,-1*(r1+r2),0])cube([length,r1+r2, thick+r1]);
			rotate([0,sideangle,0])translate([-2*thick,0,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
			translate([length,-1*length*tan(angle),0])rotate([0,-1*sideangle,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
		}

		//top bottom
		translate([0,-1*length*tan(angle),mainthick])cube([length,baseW+2*length*tan(angle),2*mainthick]);
		translate([0,-1*length*tan(angle),-2*mainthick])cube([length,baseW+2*length*tan(angle),2*mainthick]);
	}

}

module roundedInsetSolid(thick=2, length=19.5, r1=2, r2=9.5, angle=13.5, baseW=23, inset =1) 
{
	 topr1=r1-inset;
	topr2=r2-inset;
	x1 = length*sin(angle);
	r1oSet = length/cos(angle)-r1*tan((90+angle)/2);// -r1-r1*tan(angle);//-r1/cos(angle);
	sideoSet = r2*tan((90-angle)/2);// r2*(1- tan(angle));
	sidelen = r1oSet-sideoSet;
	bottomoSet = (length*sin(angle))-r1*tan((90+angle)/2);
	sideangle = atan(inset/thick);
	rotate([0,0,-1*angle])
	{
		translate([r1oSet,r1,0])cylinder(h=thick, r1=r1, r2=topr1,$fn=20);
		translate([sideoSet,r2,0])cylinder(h=thick,r1=r2, r2=topr2,$fn=20);
		translate([sideoSet,0,0])rotate([-1*sideangle,0,0]) cube([sidelen,2*r1,thick+r1]);
	}
	translate([0,baseW,0])rotate([0,0,angle])
	{
		translate([0,-2*r1,0])
		{
			translate([r1oSet,r1,0])cylinder(h=thick, r1=r1, r2=topr1,$fn=20);
			translate([sideoSet,-r2+2*r1,0])cylinder(h=thick,r1=r2, r2=topr2,$fn=20);
			translate([sideoSet,0,0])translate([0,2*r1,0])rotate([sideangle,0,0])translate([0,-2*r1,0]) cube([sidelen,2*r1,thick+r1]);
		}
	}
	translate([0,sideoSet,0])cube([length,baseW-2*sideoSet,thick]);
	translate([r2,-bottomoSet,0])cube([length-r2,baseW+2*bottomoSet,thick]);
}

