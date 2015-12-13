
use <chain-loop.scad>;

coin();

module coin(centerIcon = "../../../shapes/spurs/spurs-a.stl",
            outerIconCount = 10,            
            outerIconXyScale = 0.125,
            radius = 55,
            height = 7)
{
    union()
    {
        coinItself(centerIcon,
               outerIconCount,            
               outerIconXyScale,
               radius,
               height);
        
//        yTranslate = radius*1.07;
//        zScale = 7;
//        zTranslate = (zScale / 2.0) - (height / 2.0);
//        zTranslate = 0;
//        translate([0, yTranslate, zTranslate])
//        chainLoop(zScale = zScale);
    }
}

module coinItself(centerIcon,
            outerIconCount,            
            outerIconXyScale,
            radius,
            height)
{
    difference()
    {
        // main disk
        cylinder (h = height, r=radius, center = true, $fn=100);
        
        // centered spur
        translate([0,0,-5])
        scale([0.35, 0.35, 3.0])
        import(centerIcon);
        
        // outer spurs
        for ( i = [0 : outerIconCount] )
        {
            rotate( i * 360 / (outerIconCount+1), [0, 0, 1])
            translate([0, 43, -5])
            scale([outerIconXyScale, outerIconXyScale, 3.0])
            import(centerIcon);
        }
    }    
}