
// This OpenSCAD code originally came from:
//      https://github.com/onebeartoe/imaging/blob/master/graphics/samples/creeper-face/creeper-face.scad

// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

module creeperface(height)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=height)
      polygon([[-100.000000,-300.000000],[-100.000000,-100.000000],[100.000000,-100.000000],[100.000000,-300.000000],[300.000000,-300.000000],[300.000000,-100.000000],[100.000000,-100.000000],[100.000000,0.000000],[200.000000,0.000000],[200.000000,300.000000],[100.000000,300.000000],[100.000000,200.000000],[-100.000000,200.000000],[-100.000000,300.000000],[-200.000000,300.000000],[-200.000000,0.000000],[-100.000000,0.000000],[-100.000000,-100.000000],[-300.000000,-100.000000],[-300.000000,-300.000000],[-100.000000,-300.000000]]);
  }
}

module creeperFaceThumbnail(height = 1)
{
    xyScale = 0.116;
    
    scale([xyScale, xyScale, 1])
    creeperface(height);
}
