
use <../../../../external-resources/geometry/arc/chickenchuck040/arc.scad>

module rectangularArc(radius, radiusExtension, angle, height)
{
    linear_extrude(height = height)
    arc(radius = radius,
        thick = radiusExtension,
        angle = angle);
}

module roundedRectangularArc(angle,
                             height,
                             radius, 
                             radiusExtension,
                             minkowskiFn,
                             minkowskiRadius)
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