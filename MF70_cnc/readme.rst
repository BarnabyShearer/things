==============================
MF70 Micro-mill CNC conversion
==============================

The `MF70 Micro-mill <http://www.proxxon.com/eng/html/27110.php>` is a handy tool despite its size and cheep construction. It is also very easy to convert to CNC.

Unscrew the nylocs from the ends of the lead screws and remove them (Y-Axis is left-handed). Then use a 2mm pin punch to push out the rollpins holding the handles on.

I laser cut 8MM perspex mounts, but these could be easily be ply and hand drilled or even printed. Re-tap the existing holes for the end plate screws to 3m. This must be done *extremely carefully*. And use 30mm bolts (/longer might be better/) to secure the new mounts over the old end-plates. For the Y-axis 5 washers inside the end-plate extends it over the base.

Mount the NEMA23 stepper moters to the mounts with M5x50mm bolts, and secure the shaft couplings. Using some 4mm ID, 6mm OD "Aquarium" style silicon tube helped the couplings grip the shafts.

I then used two extra M6 nylocks on the inside of the end plates to form the bearing (origionally the handles where part of the berings). For the left-hand axis I had to use two half-nuts instead.

You can use any stepper controlers to drive this, I used a `Open Motion Controller <http://solderpad.com/folknology/open-motion-controller/>` and two `Dual Stepper Motor Module <http://solderpad.com/folknology/dual-stepper-motor-module/>`.

I also wanted to stick as close to my RepRap tool chain as posible so stuck to the `Marlin firmware <https://zi.is/p/MF70-marlin>` and `Printrun host <https://zi.is/p/printrun>`. So far I have had the best success using `PyCAM <http://pycam.sourceforge.net/>`.

BOM
---
1  MF70      Micro-mill
3  NEMA23    Stepper moters (Strong NEMA17's should work with diffrent mounts and bolts)
1  210x95mm  Ply or Perspex
2  M6        Nylocks
2  M6  		 Left-hand half-nuts
12 M5x50mm   Counter sunk bolts
12 M5        Washers
36 M5        Nuts
8  M3x30mm   Bolts
10 M3        Washers
8  M3        Penny Washers
