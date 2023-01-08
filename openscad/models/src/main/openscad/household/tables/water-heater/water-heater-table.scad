
baseHeight = 6;
baseRadius = 12;

stemHeight = 60;
stemRadius = baseRadius*0.3;

table();

module table()
{
    union()
    {
        top();

        mountingArea();

        stem();

        base();
    }
}

module top()
{
    yTranslate = stemHeight - 0.001 + 9;
    topRadius = baseRadius * 1.3;
    topHeight = baseHeight * 0.2;

    union()
    {
        difference()
        {
            color("brown")
            translate([0, 0, yTranslate])
            cylinder(r = topRadius, h = topHeight);

            // stem hole
            translate([0, 0, yTranslate-2])
            cylinder(r = stemRadius, h = topHeight +5);            

            translate([-7, 0, yTranslate-2])
            cylinder(r = 2, h = topHeight +5);

            translate([7, 0, yTranslate-2])
            cylinder(r = 2, h = topHeight +5);

            // ornament hole
            translate([0, -7, yTranslate-2])
            cylinder(r = 2, h = topHeight +5);
        }

        // ornament
        color("blue")
        translate([0, -7, yTranslate+8])
        cylinder(r = 2, h = 24);

        color("blue")
        translate([0, -9, yTranslate+8 +23])
        rotate([-90,0,0])
        cylinder(r = 2, h = 12);

        translate([0, 2, yTranslate+8 +20])
        sphere(r=2);

        // fastener 1
        color("gray")
        translate([-6, -0, yTranslate+8])
        cylinder(r = 2, h = 4);
        color("gray")
        translate([-6, -0, yTranslate+10])
        cylinder(r = 3, h = 2);

        // fastener 1
        color("gray")
        translate([7, -0, yTranslate+8])
        cylinder(r = 2, h = 4);
        color("gray")
        translate([7, -0, yTranslate+10])
        cylinder(r = 3, h = 2);
    }    
}


module mountingArea()
{
    yTranslate = stemHeight - 0.001 - 4;
    topRadius = baseRadius * 1.2;
    topHeight = baseHeight * 0.2;

    union()
    {
        {
            side = topRadius + 9;
            color("orange")
            translate([0, -2, yTranslate])
            cube([side, side-8, topHeight], center = true);

            // symetric post 1
            translate([-7, 0, yTranslate-2])
            cylinder(r = 2, h = topHeight +5);

            // symetric post 2
            translate([7, 0, yTranslate-2])
            cylinder(r = 2, h = topHeight +5);

            // ornament post
            color("blue")
            translate([0, -7, yTranslate-2])
            cylinder(r = 2, h = topHeight + 3);
        }
    }
}

module stem()
{
    cylinder(r=stemRadius, h = stemHeight);
}

module base()
{
    color("red")
    cylinder(r=baseRadius, h = baseHeight);
}