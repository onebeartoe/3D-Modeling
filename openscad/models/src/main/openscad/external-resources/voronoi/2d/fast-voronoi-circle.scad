
use <fastvoronoi.scad>

use </home/roberto/Versioning/owner/github/3D-Modeling/openscad/models/src/main/openscad/shapes/open-cylinder/open-cylinder.scad>

cellsize = 10;

union()
{
    color("yellow")
    linear_extrude(height = 4)
    random_voronoi(cellsize = cellsize,
                thickness = 2,
                        xmin=-100, xmax=100, 
                        ymin=-100, ymax=100 );

    innerRadius = 137 / 2.0; // this was measured
    outerRadius = innerRadius + 4;
    openCylinder(height = 4,
                    outerRadius = outerRadius,
                    innerRadius = innerRadius);

    color("blue")
    openCylinder(height = 8,
                    outerRadius = outerRadius + 4,
                    innerRadius = outerRadius);
}

// %
// import("head_full_voro_simplified.stl");