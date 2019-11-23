
use <../../../../external-resources/geometry/arc/chickenchuck040/arc.scad>

module rectangularArc(radius, radiusExtension, angle, height)
{
    linear_extrude(height = height)
    arc(radius = radius,
        thick = radiusExtension,
        angle = angle);
}
