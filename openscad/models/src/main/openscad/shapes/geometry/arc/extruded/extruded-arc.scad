
use <../../../../external-resources/geometry/arc/chickenchuck040/arc.scad>

module rectangularArc(radius, radiusExtension, angle, height)
{
    linear_extrude(height = height)
    arc(radius = radius,
        thick = radiusExtension,
        angle = angle);
}

module roundedRectangularArc(angle = 111,
                             height = 10,
                             radius = 20, 
                             radiusExtension = 2,
                             minkowskiFn = 10,
                             minkowskiRadius = 1)
{
    minkowski()
    {    
        rectangularArc(angle = angle,
                    height = height,
                    radius = radius,
                    radiusExtension = radiusExtension);

        sphere(r = minkowskiRadius, $fn = minkowskiFn);
    }
}