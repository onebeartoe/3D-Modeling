
use <../../basics/primitives/cone/cone.scad>
use <../../external-resources/mounting-hardware/peg-board/blank-panel-mount/pegboard_2_position_blank.scad>

module pegboardAccessories()
{
    union()
    {
        pegboardAccessories_blank();

        pegboardAccessories_cordedToolHolder();
    }
}

module pegboardAccessories_blank()
{
    color("green")
    translate([15.5, 0, 0])
    pegboardBlankPanel();
}

module pegboardAccessories_cordedToolHolder()
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

        pegboardAccessories_cordedToolHolder_holder_cutout(height, yTranslate);
    }
}

module pegboardAccessories_cordedToolHolder_holder(height, yTranslate)
{
    xTranslate = yTranslate + (yTranslate * 0.10);
    translate([xTranslate, yTranslate, 0])
    cone(height = height, bottomRadius = 9, topRadius = 13);
}

module pegboardAccessories_cordedToolHolder_holder_cutout(height, yTranslate)
{
    xTranslate = yTranslate + (yTranslate * 0.10);
    translate([xTranslate, yTranslate, -0.01])
    cone(height = height+0.02, bottomRadius = 7, topRadius = 11);
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
