
use <../../basics/primitives/cone/cone.scad>
use <../../external-resources/mounting-hardware/peg-board/blank-panel-mount/pegboard_2_position_blank.scad>

module pegboardAccessories(cordCutout = "No")
{
    union()
    {
        pegboardAccessories_blank();

        pegboardAccessories_cordedToolHolder(cordCutout = cordCutout);
    }
}

module pegboardAccessories_blank()
{
    color("green")
    translate([15.5, 0, 0])
    pegboardBlankPanel();
}

module pegboardAccessories_cordedToolHolder(cordCutout)
{
    height = 28;
    yTranslate = -12;

    difference()
    {
        union()
        {
            pegboardAccessories_cordedToolHolder_mount(height = height, yTranslate = yTranslate);

            pegboardAccessories_cordedToolHolder_holder(height = height, yTranslate = yTranslate);
        }

        pegboardAccessories_cordedToolHolder_holder_cutouts(height = height, yTranslate = yTranslate, cordCutout = cordCutout);
    }
}

module pegboardAccessories_cordedToolHolder_holder(height, yTranslate)
{
    xTranslate = yTranslate + (yTranslate * 0.10);
    translate([xTranslate, yTranslate, 0])
    cone(height = height, bottomRadius = 9, topRadius = 13);
}

module pegboardAccessories_cordedToolHolder_holder_cutouts(height, yTranslate, cordCutout)
{
    xTranslate = yTranslate + (yTranslate * 0.10);
    topRadius = 11;

    translate([xTranslate, yTranslate, -0.01])
    cone(height = height+0.02, bottomRadius = 7, topRadius = topRadius);

    if(cordCutout == "Yes")
    {
        pegboardAccessories_cordedToolHolder_holder_cutouts_cordGap(initialTranslate_x = xTranslate,
                                                                    initialTranslate_y = yTranslate,
                                                                    topRadius = topRadius,
                                                                    yLength = 7);
    }
}

module pegboardAccessories_cordedToolHolder_holder_cutouts_cordGap(initialTranslate_x, initialTranslate_y, topRadius, yLength)
{
    xTranslate = initialTranslate_x - topRadius - 5;
    yTranslate = initialTranslate_y - (yLength / 2.0);

    translate([xTranslate, yTranslate, -0.01])
    cube([10, yLength, 100]);
}

module pegboardAccessories_cordedToolHolder_mount(height, yTranslate)
{
    radius = 13;

    difference()
    {
        translate([0, yTranslate, 0])
        cylinder(r = radius, h = height);

        translate([0, yTranslate*2-5, -0.01])
        cube([radius+0.01, radius*2+10, height+0.02]);
    }
}
