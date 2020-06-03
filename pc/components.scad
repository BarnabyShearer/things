use <util.scad>;

module fan(d, mount, guard=false){
    if($cut)
        translate([0, 0, -$thickness]) {
            if(guard)
                circle_of_hex(d, 22, $thickness);
            else
                cylinder(d=d, $thickness);
            corners(mount, mount)
                cylinder(d=5, $thickness);
        }
    else
        color([.7, .3, .1])
            cylinder(d=d, h=30);       
}

module matx(standoff=10) {
    translate([-243.84/2+34.29,-13.3, 0]) {
        // Datum B
        if($cut) {
            for(f=[
                [0, 0],
                [45.72, 0],
                [203.2, -22.86],
                [-20.32, -154.94],
                //[0, -154.94],
                [45.72, -154.94],
                [203.2, -154.94],
                [45.72, -227.33],
                [203.2, -227.33]
            ])
                translate([f[0], f[1], -$thickness])
                    cylinder(d=3, h=$thickness);
            // IO
            translate([53.24, 12.27, -2.24 + standoff])
                color([.5, .5, .5])
                    cube([158.75, 1000, 44.45]);
        } else {
            // Board
            translate([-34.29, -243.84+10.16, standoff])
                color([0, .5, 0])
                    cube([243.84, 243.84, 1.6]);
            // IO
            translate([53.24, 12.27, -2.24 + standoff])
                color([.5, .5, .5])
                    cube([158.75, 1, 44.45]);
            // CPU
            translate([70, -150, 1.6 + standoff])
                color([.3, .3, .3])
                    cube([127, 111.7, 96.3]);
        }
        // PCIe
        translate([47.29, -46.94, 1.6 + standoff])
            children();
    }
}

module gpu() {
    // PCIe datum
    color([.9,.9,.9])
        translate([-1.57/2+2.84, 64.13, 100.36]) {
            io_bracket();
            translate([-47.29+26.97, 0, 0])
                io_bracket();
        }
    if(!$cut)
        translate([-38, -281+64.13+5.08, 16.15])
            color([0,0,0])
                cube([44, 281-11.43, 145-16.15-120.02+100.36]);
}

module io_bracket() {
    // Screw datum
    difference() {
        translate([-18.42+2.54, -5.08, 0])
            cube([21.59-2.54, 11.43, 2]);
        translate([0,0,-1])
            cylinder(d=4.42, h=6);
    }
    translate([-18.42, -5.08, -112.75])
        cube([18.42,1,112.75]);
    translate([-14.3, -5.08, -120.02])
        cube([14.3-4.11,1.2,120.02]);
    if($cut)
        translate([-18.42, -5.08, -106])
            cube([18.42,100,100]);
}

module psu(depth=140) {
    if($cut) {
        difference() {
            translate([-150/2, -86/2, -$thickness])
                cube([150, 86, $thickness]);
            for(f=[
                [-150/2+6, -86/2+16],
                [-150/2+6, -86/2+16+64],
                //[-150/2+6+114, -86/2+6],
                [-150/2+6+138, -86/2+6+74]
            ])
                translate([f[0], f[1], -$thickness])
                    difference()  {
                        cylinder(d=20, h=$thickness);
                        cylinder(d=3, h=$thickness);
                    }
        }
    } else
        color([0,0,0])
            translate([-150/2, -86/2, 0])
                cube([150, 86, depth]);
        
}