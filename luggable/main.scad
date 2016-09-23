include <scadhelper/main.scad>;
use <scadhelper/vitamins/2d.scad>;
use <lp097qx1.scad>;
use <abusemark_lcd.scad>;
use <asrock_fm2A88x-itx.scad>;
use <sapphire_mini_hdmi_250.scad>;
use <bequiet_tfx.scad>;

case = [
	2.8,
	"Acrylic",
	color_acrylic
];
LCD_HEIGHT=14+1.27-.12;
DEPTH=77+case[0];
CASTLE=[
	220/9,
	DEPTH/5,
	(167.12 + LCD_HEIGHT + case[0])/7
];

translate([-55, 5, -10.16+1.6+1.6/2+170.18+5])
	rotate([90,90,180])
		asrock_fm2A88x_itx(1)
			sapphire_mini_hdmi_250(2);

translate([-208.88/2, -case[0]-2.5, LCD_HEIGHT])
	lp097qx1(3);

part(4, "LCD Cable") {
	//Cable
	translate([-208.88/2-20+60, 0, 167.12+LCD_HEIGHT-10])
		cube([20, .1, 10]);
	translate([-208.88/2-20+60, 0, 167.12+LCD_HEIGHT-10])
		cube([.1, 72, 10]);
	//20mm loose?
	translate([-208.88/2-20+60, 72, 167.12+LCD_HEIGHT-10])
		cube([26, .1, 10]);
	translate([-208.88/2-20+60+26, 72, 167.12-16+LCD_HEIGHT-10])
		cube([21, .1, 26]);
}

translate([40, DEPTH-15, 167.12+LCD_HEIGHT-40-25] * preview)
	rotate([90,0,180] * preview)
		abusemark_lcd(5)
			part(6, "DisplayPort lead") color([1, 1, 1]) {
				cube([37, 20, 12]);
				translate([37, 10, 6] * preview)
					rotate([0, 90, 0])
						cylinder(
							d1=12,
							d2=6,
							h=20
						);
			}		


translate([-80, 0, -85]* preview)
	bequiet_tfx(7);

//front
translate([0,0,(167.12 + LCD_HEIGHT + case[0])/2] * preview) rotate([90,0, 0] * preview)
	2d(
		[220, 167.12 + LCD_HEIGHT + case[0]],
		case,
		castle=[CASTLE[0],0,CASTLE[0],CASTLE[2]],
		castle_alt=[1,1],
		id=8
	) {
		//PCIe Key
		translate([-208.88/2+37.5, (167.12 + LCD_HEIGHT + case[0])/2-10-case[0]-3.9, 0])
			kerf_cube([1.47, 10.2, 100]);
		//LCD Cable hole
		translate([-208.88/2+31+10, (167.12 + LCD_HEIGHT + case[0])/2-10-case[0]-1, 0])
			kerf_cube([6,12, 100]);

		translate([-208.88/2, -(167.12 + LCD_HEIGHT + case[0])/2+LCD_HEIGHT, 0])
			lp097qx1_drill();

		translate([208.88/2-170.18+10.7, (167.12 + LCD_HEIGHT + case[0])/2-14.9-case[0] ,-500])
			mirror() rotate([0,0,270])
				asrock_fm2A88x_itx_drill();
	}

//top
translate([0,(DEPTH-case[0])/2,167.12 + LCD_HEIGHT] * preview)
	2d(
		[220, DEPTH+case[0]],
		case,
		castle=[CASTLE[0],0,CASTLE[0],CASTLE[1]],
		id=9
	) {
		translate([54.5+4, 13.5-4, 0])
			e() kerf_cylinder(r=25, h=case[0]);		
	}

//bottom
translate([0,(DEPTH-case[0])/2,0] * preview)
	2d(
		[220, DEPTH+case[0]],
		case,
		castle=[CASTLE[0],0,CASTLE[0],CASTLE[1]],
		id=10
	);

//side
translate([220/2-case[0],(DEPTH-case[0])/2,(167.12 + LCD_HEIGHT + case[0])/2] * preview) rotate([0,90, 0] * preview)
	2d(
		[167.12 + LCD_HEIGHT + case[0], DEPTH+case[0]],
		case,
		castle=[CASTLE[2],CASTLE[1],CASTLE[2],CASTLE[1]],
		castle_alt=[0, 0],
		id=11
	);

//back
translate([0, DEPTH, (167.12 + LCD_HEIGHT + case[0])/2] * preview) rotate([90,0, 0] * preview)
	2d(
		[220, 167.12 + LCD_HEIGHT + case[0]],
		case,
		castle=[CASTLE[0],0,CASTLE[0],CASTLE[2]],
		castle_alt=[1,1],
		id=12
	) {
		translate([40, -(167.12 + LCD_HEIGHT + case[0])/2 +167.12+LCD_HEIGHT-40-25,0])
			mirror()
				abusemark_lcd_drill();
		translate([26, -8, 0])
			e() kerf_cylinder(r=35, h=case[0]);
}