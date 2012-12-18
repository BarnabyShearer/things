/*
 * 50m Stereo PiCam configuration
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

$fa=3;
$fs=.5;

e = 0.1;

support_thickness = 3;

ends = [
	[20, 22, 22, 20],	// Heights
	140/2,				// Radius
];

d = [
	94/2,							// Inner radius
	254 - ends[0][1] - ends[0][2],	// Inner length
	3								// Thickness
];

potting = [20, 50/2];	// Potting

camera = [
	27.1/2,		// Radius
	[20, 20],	// Distances from end
];

pi = [
	[15, -30, 42],	// Position
	[0, -90, 0],		// Orientation
];

cross = [
	18.1,
	7,
	-39
];

orings = 2; // Per end

struts = [
	3,	// Count
	6,	// M-size
];

cable = 20/2; // Raduis
