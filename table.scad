WIDTH=12;
SIZE=1220;
BUF=130;
DEPTH=100;
LEG=[96, 96, 750];

echo(
    SIZE + BUF * 2 - WIDTH * 2 +
    (DEPTH - WIDTH) * 2 + //END
    BUF * 2 + //BUF
    DEPTH * 4 //Sides
);   

translate([0, WIDTH, 0])
    color([.8,.8,.5])
        cube([SIZE, SIZE + BUF * 2 - WIDTH * 2, WIDTH]);
echo("2 × Base:", (SIZE + BUF *2 - WIDTH *2)/2);

//End
translate([0, 0, 0])
    cube([SIZE, WIDTH, DEPTH - WIDTH]);
translate([0, SIZE + BUF *2 - WIDTH, 0])
    cube([SIZE, WIDTH, DEPTH - WIDTH ]);
echo("2 × End:", DEPTH-WIDTH);
//Buf
translate([0, 0, DEPTH - WIDTH])
    difference() {
        cube([SIZE, BUF, WIDTH]);
        translate([BUF*.4+LEG[0], BUF/2, -WIDTH-1])
            cylinder(d=BUF * .8, h=100);
        translate([SIZE - (BUF*.4+LEG[0]), BUF/2, -WIDTH-1])
            cylinder(d=BUF * .8, h=100);
    }

echo("2 × Top:", BUF);

//Buf2
translate([0, SIZE + BUF, DEPTH - WIDTH ])
    difference() {
        cube([SIZE, BUF, WIDTH]);
        translate([BUF*.4+LEG[0], BUF/2, -WIDTH-1])
            cylinder(d=BUF * .8, h=100);
        translate([SIZE - (BUF*.4+LEG[0]), BUF/2, -WIDTH-1])
            cylinder(d=BUF * .8, h=100);
    }


//Plug
translate([SIZE/2-86/2, (BUF-86)/2, DEPTH])
    color([1, 1, 1])
        cube([86, 86, 10]);

translate([SIZE/2-86/2, SIZE + BUF + (BUF-86)/2, DEPTH])
    color([1, 1, 1])
        cube([86, 86, 10]);


//Leg
translate([0, WIDTH, -LEG[2] + DEPTH - WIDTH])
    color([.8,.8,.8])
        cube(LEG);
        
translate([SIZE-LEG[0], WIDTH, -LEG[2] + DEPTH - WIDTH])
    color([.8,.8,.8])
        cube(LEG);
        
translate([0, SIZE + BUF * 2 - WIDTH - LEG[1], -LEG[2] + DEPTH - WIDTH])
    color([.8,.8,.8])
        cube(LEG);
        
translate([SIZE-LEG[0], SIZE + BUF * 2 - WIDTH - LEG[1], -LEG[2] + DEPTH - WIDTH])
    color([.8,.8,.8])
        cube(LEG);
        
 //Side
translate([-WIDTH, 0, 0])
    cube([WIDTH, SIZE/2 + BUF , DEPTH]);
translate([-WIDTH, SIZE/2 + BUF, 0])
    cube([WIDTH, SIZE/2 + BUF , DEPTH]);
    
translate([SIZE, 0, 0])
    cube([WIDTH, SIZE/2 + BUF, DEPTH]);
translate([SIZE, SIZE/2 + BUF, 0])
    cube([WIDTH, SIZE/2 + BUF, DEPTH]);
    
echo("4 × Side:", DEPTH, "×", SIZE/2 + BUF);