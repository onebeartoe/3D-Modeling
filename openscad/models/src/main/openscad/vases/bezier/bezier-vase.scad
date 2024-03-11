
use <../../external-resources/bezier/JustinSDK/BezierCurve.scad>

module bezierVase(t_step = 0.05)
{
    echo("lib echo");

    width = 2;

    p0 = [0, 0];
    p1 = [40, 60];
    p2 = [-50, 90];
    p3 = [0, 200];

    points = bezier_curve(t_step, 
        p0, p1, p2, p3
    );

    color("blue")
    rotate([90,0,0])
    bezierVaseRib(points);
//    polyline(points, width);    
}

module bezierVaseRib(points)
{
    length = len(points);

    for(i = [0 : length])
    {
        translate([
            points[i][0],
            points[i][1],
            0
            ])
        sphere(r=6, $fn=20);
    }
}
