
difference()
{
	cylinder (h = 2, r=55, center = true, $fn=100);
    
    for(x = [-30 : 20 : 30],
        y = [-30 : 20 : 30])
    {
        translate([x, y, -5])
        scale([0.1, 0.1, 13.9])
        import("../../../shapes/spurs/spurs-a.stl");
    }
}