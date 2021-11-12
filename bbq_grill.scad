// Simple Grill BBQ from 25mm Angle iron

A=[25, 3];
SHELFS=5;
GRILL=[340, 540, 8];
GN=527;

S=[355, GRILL[1]*2+GN/3, 900];


// Grill
echo(str("2 grill ", GRILL[0], "x", GRILL[1], "x", GRILL[2], "mm"));
for(i=[-GRILL[1]-GN/6, GN/6])
    translate([-GRILL[0]/2, i, S[2]-A[0]+A[1]])
        cast() cube(GRILL);

echo(str("2 gastronorm 1/1 perferated 40mm"));
echo(str("2 gastronorm 1/1 65mm"));
echo(str("3 gastronorm 1/3 100mm"));
ss() {

    for(i=[-1:1])
        translate([0, i*(GRILL[1]+GN/3+A[1]*2), S[2]-100-A[0]+A[1]])
            rotate([90,0,90])
                scale([.33, 1, 1])
                    import("gastronorm.stl");

    for(i=[-1,1])
        translate([0, i*(GN/6+GRILL[1]/2), S[2]-65-SHELFS*A[0]+A[1]])
            rotate([90,0,90])
                scale([1, .65, 1])
                    import("gastronorm.stl");
}

s() {

    echo(str("4 cross-brace ", S[0]+A[0]*2, "mm"));
    for(i=[
        [S[1]/2-A[0], 300],
        [-S[1]/2, 300],
        [S[1]/2-A[0], 600],
        [-S[1]/2, 600],
    ])
        translate([-S[0]/2+-A[0], i[0], i[1]])
            rotate([0,90,-90])
                angle(S[0]+A[0]*2);

    mirror([1,0,0]) half();
    half();

}

echo(str("4 legs ", S[2], "mm"));
echo(str("2 shelfs ", S[1]+GN/3*2, "mm"));
echo(str((SHELFS-1) * 2, " shelfs ", S[1], "mm"));

module half() {
    // Legs
    for(i=[
        -GN/6-GRILL[1],
        GN/6+GRILL[1]-A[0],
    ])
        translate([-S[0]/2, i, 0]) rotate([90, 0, 180]) angle(S[2]);

    // Top Shelf
    translate([-S[0]/2, -S[1]/2-GN/3, S[2]-A[0]])
        angle(S[1]+GN/3*2);

    // Selfs
    for(i=[2:SHELFS])
        translate([-S[0]/2, -S[1]/2, S[2]-i*A[0]])
            angle(S[1]);
}

module s() {
    color([.5, .5, .5])
        children();
}

module ss() {
    color([.9, .9, .9])
        children();
}

module cast() {
   color([.1, .1, .1])
        children();
}

module angle(length) {
    cube([A[0], length, A[1]]);
    cube([A[1], length, A[0]]);
}

