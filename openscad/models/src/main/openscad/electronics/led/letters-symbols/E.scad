
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;

module poly_Selection(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-55.000000,-70.000000],[55.000000,-70.000000],[55.000000,-60.000000],[-43.000000,-60.000000],[-43.000000,-9.000000],[38.000000,-9.000000],[37.985000,-4.623750],[37.696250,-2.316094],[36.980000,-0.600000],[35.692461,0.200879],[33.523438,0.725781],[27.612500,1.156250],[17.000000,1.000000],[-43.000000,1.000000],[-43.000000,52.000000],[-42.823379,54.683281],[-42.389531,56.686875],[-41.673730,58.110156],[-40.651250,59.052500],[-39.297363,59.613281],[-37.587344,59.891875],[-33.000000,60.000000],[55.000000,60.000000],[55.000000,70.000000],[-55.000000,70.000000],[-55.000000,-70.000000]]);
  }
}

module E(height = 1)
{
    scaleFactor = 0.6456;
    scale([scaleFactor, scaleFactor + 0.107, 1])
    poly_Selection(height);

    if(showBackground)
    {
        color("green")
        cube([20.2, 30, height], center = true);
    }    
}

//E(1);
