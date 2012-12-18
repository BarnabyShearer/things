/*
 * 50m Stereo PiCam laser cutter sheet 2
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

picam_sheet2();

module picam_sheet2(
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
	for(i=[0:1]) {
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
	for(i=[0:1]) {
		translate([
			(d[0]*2.05)*(i+1)-70,
			180,
			0
		]) {
			center_ring(
				i = i,
				laser = laser
			);	
		}
	}
}
