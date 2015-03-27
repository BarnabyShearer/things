/*
USB 2/3 power:
    'AC' USB 2 charging
    +5
    +3.3

USB hub:
    Connect disconnect
    Decent Isolation

(Composite device or off hub)
    Micro SD reader (×2?)
    USB<>TTL Serial

Phone stand:
    (USB or Bluetooth whilst charging)?
    Phone screen -> USB touchpad? (with app)
    
*/

size = 19;
gap = 3;

translate([60,30,10])
    rotate([45,0,0])
        import("Nexus5.stl");

translate([-5,-80,0])
    cube([278,100,10]);

key("⎋", font="DejaVu Sans Mono") // `
key("1") //F1
key("2") //F2
key("3") //F3 
key("4") //F4
key("5") //F5
key("6") //F6
key("7") //F7
key("8") //F8
key("9") //F9
key("0") //F10
key("-") //F11
key("=") //F12
key("⌫", font="DejaVu Sans Mono") //1.5 //Del
;

translate([0, -size, 0])
key("↹", 1.5, font="DejaVu Sans Mono")
key("Q")
key("W")
key("E")
key("R")
key("T")
key("Y")
key("U")
key("I") //Insert
key("O")
key("P") //PrtScr
key("[") //Scroll Lock
key("]") //Pause
;

translate([0, -size * 2, 0])
key("Fn", 1.75)
key("A")
key("S")
key("D")
key("F", home=1)
key("G")
key("H")
key("J", home=1)
key("K")
key("L")
key(";")
key("'")
key("↵", font="DejaVu Sans Mono") //1.25 //KP_ENT
;

translate([0, -size * 3, 0])
key("⇧", 1.25, font="DejaVu Sans Mono") //Caps lock
key("\\")
key("Z")
key("X")
key("C")
key("V")
key("B")
key("N")
key("M")
key(",")
key(".")
key("/")
key("↑", font="DejaVu Sans Mono") //PgUp
key("#") //bit lost but US don't even have it
;

translate([0, -size * 4, 0])
key("⎈", 2, font="DejaVu Sans Mono")  //R CTRL
key("\uE000", font="Linux Libertine Mono O:style=Bold") //R Tux
key("⎇", font="DejaVu Sans") //Alt Gr
key(" ", 1.75) //Fn Lock
key(" ", 3)
key("≣", 2.5, font="DejaVu Sans Mono")
key("←", font="DejaVu Sans Mono") //Home
key("↓", font="DejaVu Sans Mono") //PgDn
key("→", font="DejaVu Sans Mono") //End
;

module key(id, width=1, font="Droid Sans Mono Slashed:style=Bold") {
    
    translate([(width-1)*size, 0, 0]) {
        color([.1,.1,.1]) 
            translate([(size -gap) / 2, size / 4, size+1])
                text(
                    id,
                    font = font,
                    halign="center",
                    size = 6 / (1 + (len(id) - 1)*.6)
                );
        color([.9,.9,.9])
            cube([size - gap, size - gap, size]);
    }
	translate([width*size, 0, 0])
		children();
}