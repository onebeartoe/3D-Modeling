
use <../shapes/spurs/spurs-a.scad>
use <../shapes/trees/christmas/christmas-tree.scad>

module coin(outterIcon,
//            outterIcon,
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
        coinIcon(centerIcon, height);
        
        // outer spurs
        for ( i = [0 : outerIconCount] )
        {
            rotate( i * 360 / (outerIconCount+1), [0, 0, 1])
            translate([0, 43, -5])
            scale([outerIconXyScale, outerIconXyScale, 3.0])
            coinIcon(outterIcon, height);
        }
    }    
}

module coinIcon(iconName, height)
{
    if(iconName == "Spur")
    {
        spurs(height);
    }
    else
    {
        // defalut
        christmasTree(height);
    }
//  import(centerIcon);    
}