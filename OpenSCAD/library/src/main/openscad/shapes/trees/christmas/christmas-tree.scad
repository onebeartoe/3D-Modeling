
christmasTree();

module christmasTree(height = 3)
{
    union()
    {
        // top triangle
        translate([0, 30, 0])
        triangle(10, height);
        
        // middle triangle
        translate([0, 15, 0])
        color("green")
        triangle(15, height);
        
        // bottom triangle
        triangle(20, height);
        
        // trunk
        color("brown")
        translate([-2.5, -15, 0])
        cube([5,6, height]);
    }
}

module triangle(size, height)
{
    rotate([0, 0, 90])
    cylinder(r=size, 
             $fn=3,
             h=height);
}