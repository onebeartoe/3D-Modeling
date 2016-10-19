
use <../external-resources/africa/africa-outline-hi.scad>
use <../external-resources/batman/batman.scad>
use <../external-resources/oshw/oshw-logo-800-px.scad>

use <../shapes/balloon/balloon.scad>
use <../shapes/blue-moon/blue-moon.scad>
use <../shapes/clover/clover.scad>
use <../shapes/disk/disk.scad>
use <../shapes/heart/heart.scad>
use <../shapes/hourglass/hourglass.scad>
use <../shapes/horseshoe/horseshoe.scad>
use <../shapes/oval/oval.scad>
use <../shapes/religion/christianity/crucifixion-cross/crucifixion-cross.scad>
use <../shapes/religion/judaism/star-of-david/star-of-david.scad>
use <../shapes/religion/islam/crescent-star/crescent-star.scad>
use <../shapes/spurs/spurs-a.scad>
use <../shapes/star/star.scad>
use <../shapes/texas/texas.scad>
use <../shapes/throwie-cutout/throwie-cutout.scad>
use <../shapes/trees/christmas/christmas-tree.scad>

module coin(innerIcon,
            innerIconXyScale,
            innerIconOffsetY,
            outerIcon,
            outerIconCount,            
            outerIconXyScale,
            radius,
            height)
{
    difference()
    {
        // main disk
        cylinder (h = height, r=radius, center = true, $fn=100);
        
        // inner icon
        translate([0, innerIconOffsetY, -5])
        scale([innerIconXyScale, innerIconXyScale, 6.5])
        coinIcon(innerIcon, height);
        
        // outer icons
        for ( i = [0 : outerIconCount] )
        {
            rotate( i * 360 / (outerIconCount+1), [0, 0, 1])
            translate([0, 43, -5])
            scale([outerIconXyScale, outerIconXyScale, 3.0])
            coinIcon(outerIcon, height);
        }
    }        
}

module coinIcon(iconName, height)
{
    if(iconName == "Cross")
    {
        crucifixionCcross(height);
    }
    else if(iconName == "Throwie")
    {
        throwieCutout(height=height);
    }
    else if(iconName == "Star of David")
    {
        starOfDavid();
    }
    else if(iconName == "Crescent Star")
    {
        crescentStar();
    }
    else if(iconName == "Star")
    {
        star(height);
    }
    else if(iconName == "Blue Moon")
    {
        blueMoon();
    }
    else if(iconName == "Clover")
    {
        clover();
    }
    else if(iconName == "Heart")
    {
        heart();
    }
    else if(iconName == "Horseshoe")
    {
        horseshoe();
    }
    else if(iconName == "Hourglass")
    {
        hourglass();
    }
    else if(iconName == "OSHW")
    {
        oshwlogo800px();
    }
    else if(iconName == "Texas")
    {
        texas();
    }
    else if(iconName == "Africa")
    {
        africa();
    }
    else if(iconName == "Oval")
    {
        oval();
    }
    else if(iconName == "Balloon")
    {
        balloon();
    }
    else if(iconName == "Circle")
    {
        disk();
    }
    else if(iconName == "Batman")
    {
        batmanLogo();
    }
    else if(iconName == "Tree")
    {
        christmasTree(height);
    }
    else
    {
        // default is to do nothing        
    }    
}
