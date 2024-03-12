
use <../../external-resources/bezier/JustinSDK/BezierCurve.scad>

module bezierVase(t_step = 0.05)
{
    echo("lib echo");
    radius = 6;

    p0 = [0, 0];
    p1 = [40, 60];
    p2 = [-50, 90];
    p3 = [0, 200];

    points = bezier_curve(t_step, 
        p0, p1, p2, p3
    );

    count = 29;

    for(a = [0 : count])
    {
        zRotate = a * 360 / (count+1);

        color("blue")
        rotate([90, 0, zRotate])
        translate([40,0,0])
        bezierVaseRib(points, radius);
    }
}

module bezierVaseRib(points, radius = 6)
{
    length = len(points);

    for(i = [0 : length])
    {
        translate([
            points[i][0],
            points[i][1],
            0
            ])
        sphere(r=radius, $fn=20);
    }
}
