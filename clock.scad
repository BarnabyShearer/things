use <MCAD/involute_gears.scad>;

Ts=7;
Tr=11*Ts;
Tp=5*Ts;
D=200;
P=D*180/Tr;

//RIM
rimgear(D, Tr);

//SUN
gear(
    number_of_teeth = Ts,
    circular_pitch = P,
    gear_thickness = 6,
    rim_thickness = 6,
    hub_thickness = 6,
    bore_diameter = 5
);

//Planet
translate([P*Ts/360 + P*Tp/360, 0, 0])
gear(
    number_of_teeth = Tp,
    circular_pitch = P,
    gear_thickness = 6,
    rim_thickness = 6,
    hub_thickness = 6,
    bore_diameter = 5
);


module rimgear(d, t, h=6) {
    difference() {
        cylinder(d=d+10, h=h);
        translate([0,0,-1])
            gear(
                number_of_teeth = t,
                circular_pitch = P,
                gear_thickness = h+2,
                rim_thickness = h+2,
                hub_thickness = h+2,
                bore_diameter = 0
            );
    }
}