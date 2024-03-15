
//# These Bezier curve examples are from JustinSDK.

//#   https://openhome.cc/eGossip/OpenSCAD/BezierCurve.html




function bezier_coordinate(t1 = 0, n0 = 0, n1 = 0, n2 = 0, n3 = 0) = 
    n0 * pow((1 - t1), 3) + 3 * n1 * t1 * pow((1 - t1), 2) + 
        3 * n2 * pow(t1, 2) * (1 - t1) + n3 * pow(t1, 3);


function bezier_point(t, p0, p1, p2, p3) = 
    [
        bezier_coordinate(t, p0[0], p1[0], p2[0], p3[0]),
        bezier_coordinate(t, p0[1], p1[1], p2[1], p3[1]),
        bezier_coordinate(t, p0[2], p1[2], p2[2], p3[2])
    ];


function bezier_curve(t_step, p0, p1, p2, p3) = 
    [for(t = [0: t_step: 1 + t_step]) bezier_point(t, p0, p1, p2, p3)];


module line(point1, point2, width = 1, cap_round = true) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    if(cap_round) {
        translate(point1) circle(d = width, $fn = 24);
        translate(point2) circle(d = width, $fn = 24);
    }

    polygon(points=[
        point1 + offset1, point2 + offset1,  
        point2 + offset2, point1 + offset2
    ]);
}

module polyline(points, width = 1) {
    module polyline_inner(points, index) {
        if(index < len(points)) {
            line(points[index - 1], points[index], width);
            polyline_inner(points, index + 1);
        }
    }

    polyline_inner(points, 1);
}

