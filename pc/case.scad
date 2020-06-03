use <util.scad>;

module case(size, inset, thickness, tab) {
    incremental() {
        part(1) _top(size, inset, thickness, tab)
            children(0);
        
        part(2) _left(size, inset, thickness, tab)
            children(1);
        
        part(3) _right(size, inset, thickness, tab)
            children(2);

        part(4) _front(size, inset, thickness, tab)
            children(3);

        part(5) _back(size, inset, thickness, tab)
            children(4);
        
        if(5<$children) part(6) children(5);
        if(6<$children) part(7) children(6);
        if(7<$children) part(8) children(7);
        if(8<$children) part(9) children(8);
    }
}

module _top(size, inset, thickness, tab) {
    translate([0, 0, size[2]])
        rotate([180, 0, 0])
            tabbed(size[0], size[1], thickness, tab, [false, false, false, false])
                children();
}

module _left(size, inset, thickness, tab) {
    translate([-size[0]/2, 0, size[2]/2])
        rotate([90, 0, 90])
            tabbed(size[1], size[2], thickness, tab, [false, false, true, false])
                children();
}

module _right(size, inset, thickness, tab) {
    translate([size[0]/2, 0, size[2]/2])
        rotate([90, 0, -90])
            tabbed(size[1], size[2], thickness, tab, [false, false, true, false])
                children();
}

module _front(size, inset, thickness, tab) {
    translate([0, -size[1]/2, size[2]/2])
        rotate([90, 0, 180])
            tabbed(size[0], size[2], thickness, tab, [false, true, true, true])
                children();
}

module _back(size, inset, thickness, tab) {
    translate([0, size[1]/2-inset, size[2]/2])
        rotate([90, 0, 0])
            tabbed(size[0], size[2], thickness, tab, [false, true, true, true])
                children();
}

module vent_strip(l, hex) {
    if($cut)
        translate([0,0, -$thickness])
            hex_strip(l, hex, $thickness) {
                hex_strip(l-hex*3, hex, $thickness);
                hex_strip(l-hex*3, hex, $thickness);
            }
}