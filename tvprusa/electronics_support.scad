/*
 * TVRRUG Electronics mount
 *
 * Copyright 2012 <b@Zi.iS>
 * License CC BY 3.0
 */

$fn = 60;
m8 = 7.80 / 2;
m3 = 2.8 /2;

	
//http://solderpad.com/folknology/dual-stepper-motor-module/
translate(	[
	0,
	10,
	0
]) {
	mount2(
		length=165-2*m8,
		pitch = 44.5
	);
}
translate(	[
	0,
	30,
	0
]) {
	mount2(
		length=165-2*m8,
		pitch = 44.5
	);
}

//http://solderpad.com/folknology/open-motion-controller/
translate(	[
	0,
	-10,
	0
]) {
	mount1(
		length=165-2*m8,
		pitch = 70
	);
}
translate(	[
	0,
	-30,
	0
]) {
	mount1(
		length=165-2*m8,
		pitch = 70
	);
}

module mount1(length =156, width=10, thickness=3, post=m3, mount=m8, ends=2, pitch = 70) {
	support(
		length = length,
		width = width,
		thickness = thickness,
		post = post,
		mount = mount,
		ends = ends,
		posts= space1(length, pitch)
	);
}

module mount2(length =156, width=10, thickness=3, post=m3, mount=m8, ends=2, pitch = 44.5) {
	support(
		length = length,
		width = width,
		thickness = thickness,
		post = post,
		mount = mount,
		ends = ends,
		posts= space2(length, pitch, pitch)
	);
}

module support(length=60, width=10, thickness=3, post=m3, mount=m8, ends=2, posts=[], drop=20) {	
	cube([
		length,
		width,
		thickness
	]);
	for(i=posts) {
		translate([
			i,
			width/2
		]) {
			post(
				size = post,
				height = thickness * 3
			);
		}
	}
	translate(	[
		0,
		width
	]) {
		rotate([
			90,
			0,
			0
		]) {
			mount(
				rod = m8,
				length=width,
				thickness = thickness,
				height = drop
			);
		}
	}
	if(ends ==2) {
		translate(	[
			length,
			0
		]) {
			rotate([
				90,
				0,
				180
			]) {
				mount(
					rod = m8,
					length=width,
					thickness = thickness,
					height = drop
				);
			}
		}
	}
}

module post(size = m3, height = 9) {
	cylinder(
		r = size * 2,
		height / 3 * 2
	);
	cylinder(
		r = size ,
		height
	);
}
module mount(rod = m8, length = 10, height=10, thickness = 3) {
	shell = rod +thickness;

	translate(	[
		-shell-rod,
		0,
		0
	]) {
		difference() {
			cube([
				shell*2,
				height,
				length
			]);
			translate(	[
				thickness,
				-1,
				-1
			]) {
				cube([
					rod*2,
					height-shell+1,
					length+2
				]);
			}
			translate(	[
				shell,
				height-2*rod-thickness,
				-1
			]) {
				rotate([
					0,
					0,
					45
				]) {
					cube([
						rod*1.4142,
						rod*1.4142,
						length+2
					]);
				}
			}
		}
		
	}
}

function space1(length, pitch) = [
	(length-pitch)/2, 
	(length-pitch)/2 + pitch
];
function space2(length, pitch1, pitch2) = [
	(length-pitch1-pitch2)/3, 
	(length-pitch1-pitch2)/3 + pitch1,
	(length-pitch1-pitch2)/3 + pitch1 +  (length-pitch1-pitch2)/3,
	(length-pitch1-pitch2)/3 + pitch1 +  (length-pitch1-pitch2)/3 + pitch2

];