
function xHoleDeltaBottomRight() = 11.43;

function yHoleDelta() = 21.59;

module trinketMiniStandoffs()
{
    radius = 3;
    height = 4;
    sides = 20;
    
    // this is the 'bottom left' standoff; it is on the reset button end of the Trinket Mini
    cylinder(r=radius, h = height, $fn=sides);
    
    // this is the 'bottom right' standoff; it is on the reset button end    
    translate([xHoleDeltaBottomRight(),0,0])
    cylinder(r=radius, h = height, $fn=sides);
    
    // this is the 'top left standoff; it is on the power/USB end of the Trinket Mini    
    translate([0, yHoleDelta(),0])
    cylinder(r=radius, h = height, $fn=sides);
    
    // this is the 'top right standoff; it is on the power/USB end of the Trinket Mini
    translate([xHoleDeltaBottomRight(), yHoleDelta() ,0])
    cylinder(r=radius, h = height, $fn=sides);
}