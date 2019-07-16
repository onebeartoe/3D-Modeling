
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

    union()
    {
        pegboardAccessories_cordedToolHolder_mount(height = height);

        pegboardAccessories_cordedToolHolder_holder(height = height);
    }
}

module pegboardAccessories_cordedToolHolder_holder(height)
{

}

module pegboardAccessories_cordedToolHolder_mount(height)
{
    yTranslate = -12;
    radius = 13;

    difference()
    {
        translate([0, yTranslate, 0])
        cylinder(r = radius, h = height);

        translate([0, yTranslate*2-5, -0.01])
        cube([radius+0.01, radius*2+10, height+0.02]);
    }
}
