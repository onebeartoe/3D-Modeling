
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

module star(h=1)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[9.080000,-22.000000],[10.922500,-17.093750],[12.213125,-14.728281],[13.890000,-13.020000],[15.773906,-12.298125],[18.041250,-12.022500],[22.500000,-11.910000],[34.390000,-10.968750],[40.862812,-10.133906],[45.500000,-9.000000],[28.500000,4.610000],[21.270000,12.170000],[22.870000,22.000000],[27.500000,43.000000],[8.500000,31.580000],[-0.500000,27.200000],[-10.500000,32.320000],[-28.500000,43.000000],[-22.870000,21.000000],[-21.690000,11.090000],[-28.500000,4.130000],[-45.500000,-11.000000],[-11.500000,-13.000000],[-0.500000,-43.000000],[2.289219,-38.828594],[4.908750,-33.096250],[9.080000,-22.000000]]);
  }
}

module starThumbnail(height = 1)
{
	xyScale = 0.9544;
	scale([xyScale, xyScale, height])
	star();	
}