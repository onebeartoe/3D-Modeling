
//lightBulb2D();

module lightBulb(height=8)
{
    linear_extrude(height=height)
    {
        lightBulb2D();
    }
}

module lightBulb2D()
{
    union()
    {        
        lightBulbTop();

        lightBulbBottom();
    }
}

module lightBulbBottom()
{
    width = 7;
    height = 1;
    threadSpacing = 2.5;
    
    xTranslate = -width/2.0;
    yTranslate = -13;
    
    translate([xTranslate, yTranslate, 0])
    square(size=[width, height]);
        
    translate([xTranslate, yTranslate - (threadSpacing * 1), 0])
    square(size=[width, height]);

    p = 0.79;
//    color("blue")
    translate([xTranslate*p, yTranslate - (threadSpacing * 2), 0])
    square(size=[width*p, height]);
}

module lightBulbTop()
{
    width = 10;

//        linear_extrude(height=4)    
        {
    rotate([0, 0, 225])
    union()
    {
//        linear_extrude(height=4)
        {
//            cylinder(r = width);
            circle(r = width);
        }
        
//        linear_extrude(height=4)
        difference()
        {
            
//            linear_extrude(height=4)
            square(size=[width, width]);

//            linear_extrude(height=4)
            translate([width, width/2, 0])
            rotate([0, 0, 45])            
            square(size=20);    
        }
    }    
        }
}

module lightBulbThumbnail()
{
    xyScale = 0.8;
        
    scale([xyScale, xyScale, 0.2])
    lightBulb();
}