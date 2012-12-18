/*
 * 50m Stereo PiCam laser cutter sheet 1
 *
 * Copyright 2012 Reading Makerspace Ltd
 * Authors:
 *  Gary Fletcher
 *  Ryan White
 *  Barnaby Shearer
 *  Richard Ibbotson
 *  Paul Hegarty
 *
 * License CC BY 3.0
 */

include <50m_stereo_picam_configuration.scad>
use <50m_stereo_picam_supports.scad>

picam_sheet1();

module picam_sheet1(
	laser = .2
) {

	for(i=[0:1]) {
		translate([
			(d[0]*2)*(i+1)-68,
			0,
			0
		]) {
			camera_ring(
				i = i,
				laser = laser
			);	
		}
	}
	for(i=[0:2]) {
		translate([
			0,
			d[0]*.95*i+d[0]+25,
			0
		]) {
			strut(
				i = i,
				laser = laser
			);	

		}
	}
	translate([
		0,
		d[0]*.95*3+d[0]+30,
		0
	]) {
		strut(
			i = 2,
			laser = laser
		);	
	}
}
