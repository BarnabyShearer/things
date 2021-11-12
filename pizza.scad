// Pizza
translate([0, 300, 0]) cylinder(d=350,h=10);

// Frame
for(r=[0:4]) rotate(90*r) {
    translate([450-75, 450-63, -1200]) cube([75, 63, 1200]);
    translate([-450-22, -450, -145]) cube([22, 922, 145]);
}

// Base
for(x=[0:3]) translate([-450+63+200*x, -450-22, -145-12]) cube([150, 944, 22]);
translate([-450, -450, -145-22-145]) cube([922, 22, 150]);

// Bricks
color([.7,.4,.4]){
for(x=[-1.5:1]) for(y=[-2:1.5]) translate([231*x, 115*y, -76]) cube([230, 114, 76]);
for(x=[-1:.5]) for(y=[-3,2]) translate([231*x, 115*y, -76]) cube([230, 114, 76]);
}

// Dome
color([.5,.5,.5,]) {
    translate([-450,-450,-151]) cube([900,900,150]);
    difference() {
        union() {
            translate([0,0, 50]) sphere(d=850);
            rotate([-90,0,0]) cylinder(d=230*2+1+200, h=450);
            translate([0,300,0]) cylinder(d=250, h=500);
        }
        translate([0,0, 50]) sphere(d=650);
        rotate([-90,0,0]) cylinder(d=230*2+1, h=115*4.5);
        translate([0,300,0]) cylinder(d=150, h=1000);
        translate([-1000,-1000,-2000]) cube(2000);
    }
    
}