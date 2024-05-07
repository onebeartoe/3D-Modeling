

use <../../bezier-vase.scad>

echo("is ready");

p0x = 0;    // [-20 : 20]
p0y = 0;    // [-20 : 20]

p1x = 40;    // [20 : 60]
p1y = 60;    // [40 : 80]

p2x = -50;    // [-30 : -70]
p2y = 90;    // [70 : 110]
         
p3x = 0;    // [-20 : 20]
p3y = 200;    // [180 : 220]

p0 = [p0x, p0y];
p1 = [p1x, p1y];
p2 = [p2x, p2y];
p3 = [p3x, p3y];

//color("red")
//bezierVase(t_step = 0.05);
//bezierVase(t_step = 0.031);
bezierVase(
    p0 = p0,
            p1 = p1,
            p2 = p2,
            p3 = p3,
            t_step = 0.02);



