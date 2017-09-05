/**
 *	source code originially from this thing: 
 * 
 * 		http://www.thingiverse.com/thing:277727
 */

//============================================================
// OpenSCAD
// Licence : LICENCE PUBLIQUE RIEN À BRANLER
// Licence : do What The Fuck you want to Public License
//============================================================
/*

	Usage:
	use <Hexagones.scad>;
	Pour créer des jeux, des têtes de vis...

*/


//------------------------------------------------------------
// Demo
//------------------------------------------------------------
$fn = 150 ;			// OpenSCAD Resolution

// hexagone de 1 pouce (1 inch) soit 25.4 mm
Hexagone(cle=15,h=13);

color("green")
translate([20,0,0])
hexagon(cle=10, h=5);

/**
 * this is the English version of the module :)
 */
module hexagon(cle, h)
{
	Hexagone(cle,h);
}

//------------------------------------------------------------
// Hexagone
// cle	écart, ex: clé de 12 alors cle=12
// h		hauteur
//------------------------------------------------------------
module Hexagone(cle,h)
{
	angle = 360/6;		// 6 pans
	cote = cle * cot(angle);
	echo(angle, cot(angle), cote);
	echo(acos(.6));

	union()
	{
		rotate([0,0,0])
			cube([cle,cote,h],center=true);
		rotate([0,0,angle])
			cube([cle,cote,h],center=true);
		rotate([0,0,2*angle])
			cube([cle,cote,h],center=true);
	}

// Vérification par un cercle de taille cle
//	#cylinder(r=cle/2,h=2*h,center=true);
//	%circle(r=cote,center=true);
//	#cube([cote,cote,1]);
}

//------------------------------------------------------------
// Fonction cotangente
// Permet d'avoir les bones dimensions
// utiliser $fn n'est pas bon
//------------------------------------------------------------
function cot(x)=1/tan(x);

//==EOF=======================================================