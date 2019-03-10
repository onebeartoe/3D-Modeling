
use <../base/street-lamp-base.scad>
showPole = "no"; // [yes, no]

if(showPole == "yes")
{
	%
	translate([0, 0, 29.99])
	import("/home/roberto/Versioning/world/betoland/3d-relization/models/street-lamps/WillemvD/files/StreetLamp.stl");
}

streetLampBase();
