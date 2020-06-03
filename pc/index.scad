use <util.scad>;
use <case.scad>;
use <components.scad>;

draw(-1) // Change to 1-7 to export DXFs
    case([270, 300, 400], 20, 5, 10) {    
        none();
        for(y=[-100, 170])
            translate([0,y,0])
                vent_strip(260, 10);
        for(y=[-100, 170])
            translate([0,y,0])
                vent_strip(260, 10);
        none();
        translate([0,-157,0])
            part() psu();
        translate([0, -20/2, 140])
            tabbed(270, 280, 5, 10) {
                part()
                    backside()
                        fan(200, 170);
                part()
                    translate([0, 280/2-5, 0])
                        matx(20)
                            gpu();
            }
        translate([0, -20/2, 330])
            tabbed(270, 280, 5, 10)
                part()
                    fan(200, 170);
    }

module draw(id) {
    output(id)
        if(id==2 || id==3)
            rotate([0,90,0])
                children();
        else if(id==4 || id==5)
            rotate([90,0,0])
                children();
        else
            children();
}