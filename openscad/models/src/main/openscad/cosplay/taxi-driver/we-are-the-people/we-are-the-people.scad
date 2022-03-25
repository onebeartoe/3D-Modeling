

use <../../../basics/text/text-extrude/text-extrude.scad>

module weAreThePeople(sidesOnly = false,
                      cornerRadius=5,
                      height = 1)
{
    union()
    {
        button(sidesOnly,
            cornerRadius,
            height);

        buttonText();
    }
}

module bottomCutoff(height)
{
    color("green")
    translate([0,0, height / -2])
    cube(size=[150, 150, height], center=true);
}

module button(sidesOnly,
            cornerRadius,
            height)
{
    color("white")
    difference()
    {
        fullDisk(sidesOnly, cornerRadius, height);

        bottomCutoff(height = 50);
    };
}

module buttonText()
{
    textSize = 11;

    textHeight = 9;

    color("red")
    translate([0, 10, 0])
    textExtrude(height = textHeight,
                textSize = textSize,
                text="\"We Are",
                font = "Liberation Sans:style=Bold");

    // this is the under score
    color("red")
    translate([4,0,0])
    cube(size=[25,3,textHeight]);

    color("red")
    translate([0, -10, 0])
    textExtrude(height = textHeight,
                textSize = textSize,
                text="The People\"",
                font = "Liberation Sans:style=Bold");
}

module fullDisk(sidesOnly,
                cornerRadius,
                height)
{
    minkowski()
    {
        cylinder(r = 45, h = height, $fn = 90);

        if(sidesOnly)
        {
            cylinder(r=cornerRadius);
        }
        else
        {
            sphere(r=cornerRadius);
        }
    };
}