
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.

//plbogen_deceopticonStamp();

module plbogen_deceopticonStamp(fudge = 0.1, h=1)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-349.187500,-332.640645],[-300.781200,-33.671895],[0.000001,331.984345],[300.781301,-33.671895],[349.187501,-332.640645],[271.968801,-228.265645],[121.000001,-184.109395],[103.718801,-115.484395],[252.375001,-159.640695],[246.625001,-143.671895],[96.812501,-99.484395],[85.281301,-55.296895],[248.937501,-105.140695],[247.781301,-90.078195],[80.687501,-39.328195],[0.000001,28.359305],[-80.656199,-39.328195],[-247.781199,-90.078195],[-248.937499,-105.140695],[-85.281199,-55.296895],[-96.812499,-99.484395],[-246.624999,-143.671895],[-251.218699,-159.640695],[-103.718699,-115.484395],[-120.999999,-184.109395],[-271.968699,-228.265645],[-349.187500,-332.640645]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-229.343700,-20.515695],[-25.343700,43.390605],[-65.687500,119.546805],[-229.343700,-20.515695]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[229.343800,-20.515695],[65.687500,119.546805],[25.343800,43.390605],[229.343800,-20.515695]]);
    }
    difference()
    {
       linear_extrude(height=h)
         polygon([[-121.000000,-328.390645],[-63.375000,-50.140695],[0.000000,5.328105],[63.375000,-50.140695],[121.000000,-328.390645],[29.968800,-205.234395],[0.000000,-205.234395],[-29.968700,-205.234395],[-121.000000,-328.390645]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-23.062500,-150.734395],[0.000000,-150.734395],[23.062500,-150.734395],[0.000000,-81.171895],[-23.062500,-150.734395]]);
    }
    linear_extrude(height=h)
      polygon([[-292.500001,0.890605],[-255.187500,230.921805],[-18.562500,332.640645],[-292.500000,0.890605]]);
    linear_extrude(height=h)
      polygon([[292.500000,0.890605],[18.562500,332.640645],[255.187500,230.921805],[292.500000,0.890605]]);
  }
}
