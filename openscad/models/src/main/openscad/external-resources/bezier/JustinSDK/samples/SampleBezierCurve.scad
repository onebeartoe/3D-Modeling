use <../BezierCurve.scad>

t_step = 0.05;
width = 2;

p0 = [0, 0];
p1 = [40, 60];
p2 = [-50, 90];
p3 = [0, 200];

points = bezier_curve(t_step, 
    p0, p1, p2, p3
);

echo(points);

color("blue")
polyline(points, width);


