/*
 * TVRRUG electronics mount
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
	20,
	0
]) {
	mount2(
		rod_gap=164-2*m8,
		pitch = 44.5
	);
}
translate(	[
	0,
	60,
	0
]) {
	mount2(
		rod_gap=164-2*m8,
		pitch = 44.5
	);
}

//http://solderpad.com/folknology/open-motion-controller/
translate(	[
	0,
	-20,
	0
]) {
	mount1(
		rod_gap=164-2*m8,
		pitch = 70
	);
}
translate(	[
	0,
	-60,
	0
]) {
	mount1(
		rod_gap=164-2*m8,
		pitch = 70
	);
}

module mount1(
	width = 10,
	thickness = 2.2,
	rod_gap = 156,
	rod = m8,
	post = m3,
	pitch = 70,
	offset = 20
) {
	mount(
		width = width,
		thickness = thickness,
		rod_gap = rod_gap,
		rod = rod,
		post = post,
		posts= space1(rod_gap, pitch),
		offset = offset
	);
}

module mount2(
	width = 10,
	thickness = 2.2,
	rod_gap = 156,
	rod=m8,
	post = m3,
	pitch = 44.5,
	offset = 20
) {
	mount(
		width = width,
		thickness = thickness,
		rod_gap = rod_gap,
		rod = rod,
		post = post,
		posts= space2(rod_gap, pitch, pitch),
		offset = offset
	);
}

module mount(
	width = 10,
	thickness = 2.2,
	rod_gap = 60,
	rod = m8,
	post = m3,
	posts = [],
	offset = m8
) {

	support(
		rod_gap = rod_gap,
		rod = rod,
		width=post*4,
		offset = offset,
		thickness = 2.2
	
	);

	for(i=posts) {
		translate([
			i,
			thickness,
			0
		]) {
			post(
				size = post,
				height = thickness * 4
			);
		}
	}
	
}

module post(
	size = m3,
	height = m3*4
) {
	translate([
		-size*2,
		0,
		0
	]) {
		cube([
			size*4,
			height/2,
			size*4
		]);
	}
	translate([
		0,
		height,
		size
	]) {
		rotate([
			90,
			0,
			0
		]) {
			rotate([
				0,
				0,
				22.5
			]) {
				cylinder(
					r = size,
					h = height,
					$fn=8
				);
			}
		}
	}
}

module support(
	rod_gap = 165-2*m8,
	rod = m8,
	width = m3*4,
	offset = 10,
	thickness = 2.2
) {
	difference() {
		union() {
			cube([
				rod_gap,
				thickness,
				width,
			]);
			translate([
				-thickness*2-rod*2,
				0,
				0
			]) {
				cube([
					thickness*2+rod*2,
					thickness+offset,
					width,
				]);
			}
			translate([
				-thickness-rod,
				thickness+offset,
				0
			]) {
				cylinder(
					r=rod+thickness,
					h=width
				);
			}
			translate([
				rod_gap,
				0,
				0
			]) {
				cube([
					thickness*2+rod*2,
					thickness+offset,
					width,
				]);
			}
			translate([
				rod_gap+thickness+rod,
				thickness+offset,
				0
			]) {
				cylinder(
					r=rod+thickness,
					h=width
				);
			}
		}
			translate([
				-thickness*3.5-rod*2,
				-thickness,
				-1
			]) {
				cube([
					thickness*2+rod*2,
					thickness+offset,
					width+2,
				]);
			}
		
			translate([
				-thickness-rod,
				thickness+offset,
				-1
			]) {
				cylinder(
					r=rod,
					h=width+2
				);
			}
			translate([
				rod_gap+thickness*1.5,
				-thickness,
				-1
			]) {
				cube([
					thickness*2+rod*2,
					thickness+offset,
					width+2,
				]);
			}
			translate([
				rod_gap+thickness+rod,
				thickness+offset,
				-1
			]) {
				cylinder(
					r=rod,
					h=width+2
				);
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
