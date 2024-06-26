
use <../../external-resources/bezier/JustinSDK/BezierCurve.scad>

module bezierVase(count = 29,
                  p0 = [0, 0],
                  p1 = [40, 60],
                  p2 = [-50, 90],
                  p3 = [0, 200],
                  pointLegends = false,
                  radius = 6,
                  t_step = 0.05,
                  zMountingAdustment = 30)
{
    union()
    {
        shell(count,
              p0,
              p1,
              p2,
              p3,
              pointLegends,
              radius,
              t_step);

        topMounting(count, radius, zMountingAdustment);
    }
}

module topMounting(count, radius, zMountingAdustment)
{
    outerRadius = 45;

//TODO: make this a function and reuse in bezier-vase.scad    
    innerRadius = 40; // the E27 fitting has a 40mm inner radius

//   zTranslate = 120;
//    zTranslate = 0;
    zTranslate = count * radius + zMountingAdustment;

    height = 10;

    $fn = 50;

    difference()
    {
        translate([0, 0, zTranslate])
        cylinder(center = true,
                h = height, 
                r = outerRadius);

        cylinder(center = true,
                h = height * 50, 
                r = innerRadius);
    }
}  

module shell(count,
             p0,
             p1,
             p2,
             p3,
             pointLegends,
             radius,
             t_step)
{
    points = bezier_curve(t_step, 
        p0, p1, p2, p3
    );

    for(a = [0 : count])
    {
        zRotate = a * 360 / (count+1);

        color("blue")
        rotate([90, 0, zRotate])
        translate([44,0,0])
        bezierVaseRib(points, radius);
    }

    if(pointLegends)
    {
        pointLegend(0,p0);
        pointLegend(1,p1);
        pointLegend(2,p2);
        pointLegend(3,p3);
    }
}

module pointLegend(index, point)
{
    echo("points: ", point[0], ", " , point[1], ", ", point[2] );

    legend = str("P", index);

    xTranslate = point[0] + 40;

    color("orange")
    rotate([90, 0, 0])
    translate( [xTranslate, point[1], 0] )
    union()
    {
        text(text = legend, size = 45);
    
        sphere(r=14);
    }
}

module bezierVaseRib(points, radius)
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

