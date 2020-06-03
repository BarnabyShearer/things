module none() {
    cube(.001);
}

module cut() {
    $cut=true;
    children();
}

module incremental() {
    for(i=[0:$children-1]) {
        difference() {
            children(i);
            none();
            if(i+1 < $children-1)
                for(j=[i+1:$children-1])
                    skip_part_filter()
                        cut()
                            children(j);
        }
    }
}

module tabbed(x, y, thickness, tab, edge=[true, true, true, true]) {
    $thickness=thickness;
    translate([0,0, thickness/2])
        difference() {
            cube([x, y, thickness], true);
            for(tx_from_mid=[0:tab*2:x/2])
                for(tx=[-tx_from_mid, tx_from_mid]) {
                    if(edge[0])
                        translate([tx, -y/2, 0]) 
                            cube([tab, thickness*2, thickness+2], true);
                    if(edge[2])
                        translate([tx, y/2, 0]) 
                            cube([tab, thickness*2, thickness+2], true);
                }
            for(ty_from_mid=[0:tab*2:y/2])
                for(ty=[-ty_from_mid, ty_from_mid]) {
                    if(edge[1])
                        translate([-x/2, ty, 0]) 
                            cube([thickness*2,tab, thickness+2], true);
                    if(edge[3])
                        translate([ x/2, ty, 0]) 
                            cube([thickness*2,tab, thickness+2], true);
                }
            translate([0,0, thickness/2])
                cut()
                    children();
            
        }
    translate([0,0, thickness])
        children();
}

module in_circle(x, y, r) {
    if(sqrt(x*x+y*y)<=r)
        translate([x, y, 0])
            children();
}

module circle_of_hex(d, hex, l=1000) {
    for(x=[round(-d/hex/3):d/hex/3])
        for(y=[round(-d/hex/3):d/hex/3])
            for(h=[[0, 0], [.5, .5]])
                in_circle((x+h[0])*hex*2*sqrt(3), (y+h[1])*hex*2, d/2)
                    cylinder(r=hex, $fn=6, l);
}

module hex_strip(l, hex, h=1000) {
    for(i=[ceil(-l/hex/3)/2: floor(l/hex/3)/2])
        translate([i*hex*3, 0, 0])
            cylinder(r=hex*.8, $fn=6, h);
    if($children>0)
        translate([0, hex*sqrt(3)/2, 0])
            children(0);
    if($children>1)
        translate([0, -hex*sqrt(3)/2, 0])
            children(1);
}

module corners(x, y) {
    for(xx=[-x/2, x/2])
        for(yy=[-y/2, y/2])
            translate([xx, yy, 0])
                children();
}

module skip_part_filter() {
    $skip_part_filter=true;
    children();
}

module part(id=0) {
    if($cut || $skip_part_filter || $part==-1 || id==$part)
        children();
    else
        none();
}

module output(id=-1) {
    $part=id;
    if($part==-1)
        children();
    else
        offset(.1)
            projection()
                children();
}

module backside() {
    translate([0, 00, -$thickness])
        rotate([0, 180, 0])
            children();
}