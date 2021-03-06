
// TODO: Implement all the code below from the original OpenSCAD file.
/*//////////

// Support functions and moduules follow. //

module lightSignal_cutouts(icon1,
							icon1_scale,
							icon1_x,
							icon1_y,
						   text1,
						   text1_fontSize,
						   text1_x,
						   text1_y,
					 	   text2,
						   text2_fontSize,
					   	   text2_x,
						   text2_y)
{
		lightSignal_textCutouts(text1,
								text1_fontSize,
								text1_x,
								text1_y,
								text2,
								text2_fontSize,
								text2_x,
	 						   	text2_y);

		lightSignal_iconCutouts(icon1, icon1_scale, icon1_x,
		icon1_y);
}

module lightSignal_iconCutouts(icon1,
							   icon1_scale,
							   icon1_x,
							   icon1_y)
{
	if(icon1 == "")
	{
		// do nothing
	}
	else
	{
		zScale = 3;
		translate([icon1_x, icon1_y, -1.01])
		if(icon1 == "heart")
		{
			scale([icon1_scale, icon1_scale, zScale])
			heartThumbnail();
		}
		else if(icon1 == "bat")
		{
			scale([icon1_scale, icon1_scale, zScale])
			batmanLogoThumbnail();
		}
	}
}

module lightSignal_oneTextCutout(text, fontSize, x, y)
{
	if(text == "")
	{
		// do nothing
	}
	else
	{
		extrudeHeight = 6;
		zTranslate = -3;
		fontName = "Bauhaus 93:style=Regular";

		translate([x, y, zTranslate])
		linear_extrude(height = extrudeHeight)
		text(text = text, font = fontName, size = fontSize);
	}
}

module lightSignal_textCutouts(text1,
                                text1_fontSize,
                                text1_x,
                                text1_y,
                                text2,
                                text2_fontSize,
                                text2_x,
                                text2_y)
{
	lightSignal_oneTextCutout(text1, text1_fontSize, text1_x, text1_y);

	lightSignal_oneTextCutout(text2, text2_fontSize, text2_x, text2_y);
}

//////////*/

package org.onebeartoe.modeling.javascad.light.signals;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.models.Extendable3dModel;
import eu.printingin3d.javascad.tranzitions.Colorize;
import eu.printingin3d.javascad.tranzitions.Difference;
import eu.printingin3d.javascad.tranzitions.Union;
import java.awt.Color;
import java.util.ArrayList;
import java.util.List;
import org.onebeartoe.modeling.javascad.ModuleCall;

/**
 * This is part of a recreation of the .scad file at
 * 
 *      3D-Modeling/openscad/models/src/main/openscad/signals/light-signals/light-signal.scad
 * 
 * @author Roberto Marquez
 */
public class LightSignal extends 
//                                 OpenScadFile
                                 Extendable3dModel
{
//    public Extendable3dModel model;
    
    public static final String name = "lightSignal";
    
    public List<Abstract3dModel> baseCutouts;
 
    // DO NOT CHANGE THE RADIUS; IT MACHES THE ORIGINAL MODEL
    final double stlBaseInnerRadius= 18.5;

    final double stlBaseOuterRadius = stlBaseInnerRadius + 2.5;
    
    final double baseHeight = 2;
    
    public LightSignal(List<Abstract3dModel> baseCutouts)
    {   
        this.baseCutouts = baseCutouts;
        
        Abstract3dModel lightSignalModel = modelDefinition();
                
        baseModel = lightSignalModel;
    }
    
    private Abstract3dModel bottomWideShaft(int zTopHoleTranslate)
    {
        double zTranslate = -baseHeight / 2.0;
        String moduleName = "openCylinder";
        ModuleCall bottomWideShaft = new ModuleCall(moduleName);
        bottomWideShaft.addParameter("height", String.valueOf(zTopHoleTranslate) );
        bottomWideShaft.addParameter("outerRadius", String.valueOf(stlBaseOuterRadius) );
        bottomWideShaft.addParameter("innerRadius", String.valueOf(stlBaseInnerRadius) );        
        Abstract3dModel bws = (Abstract3dModel) bottomWideShaft;
        bws = bws.move( new Coords3d(0, 0, zTranslate));
        
        return bws;
    }
    
    private Abstract3dModel dome(double cylinderRadius, int zTopHoleTranslate)
    {
        double domeRadius = 30;
        
        ModuleCall dome = new ModuleCall("dome");                                        
        dome.addParameter("radius", String.valueOf(domeRadius) );        
        dome.addParameter("domePercentage", "50");
        
        ModuleCall domeCutout = new ModuleCall("openCylinder");
        domeCutout.addParameter("innerRadius", String.valueOf(cylinderRadius));
        domeCutout.addParameter("outerRadius", String.valueOf(cylinderRadius+domeRadius));
        domeCutout.addParameter("height", String.valueOf(zTopHoleTranslate));

                // this is the top hole/cutout
// TODO: Implement all the code below from the original OpenSCAD file.
/*	
		color("blue")
		translate([0, 0, zTopHoleTranslate])
		openCylinder(height=1, outerRadius = 12, innerRadius=6);
*/
        double topHoleRadius = 6;
//        double topHoleRadius = 6;
        Abstract3dModel topHole = new Cylinder(9, topHoleRadius)
                                    .move( new Coords3d(0, 0, 31) );
        
        Difference domeDiff = new Difference(dome, domeCutout, topHole);
        
        double zTranslate = zTopHoleTranslate - 21.5;
        Abstract3dModel domeMove = domeDiff.move( new Coords3d(0, 0, zTranslate) );
        Colorize pinkDome = new Colorize(Color.pink, domeMove);

        return pinkDome;
    }

// TODO: Implement all the code below from the original OpenSCAD file.    
/*
module lightSignal(
                    icon1 = "",
                    icon1_scale = 1,
                    icon1_x = 0,
                    icon1_y = 0,
                    text1 = "",
                    text1_fontSize = 7.5,
                    text1_x = 0,
                    text1_y = 0,
                    text2 = "",
                    text2_fontSize = 7.5,
                    text2_x = 0,
                    text2_y = 0)
{
	difference()
	{
		lightSignal_shell(baseHeight, showOriginal = false);

		lightSignal_cutouts(icon1,
							icon1_scale,
							icon1_x,
							icon1_y,
							text1,
							text1_fontSize,
							text1_x,
							text1_y,
							text2,
							text2_fontSize,
							text2_x,
							text2_y);
	}
}    
*/    
    private Abstract3dModel modelDefinition()//double baseHeight)
    {
        boolean showOriginal = false;
        
        Abstract3dModel shell = shell(showOriginal);
        
        Difference diff = new Difference(shell, baseCutouts);

        return diff;
    }
      
    private Abstract3dModel shell(boolean showOriginal)
    {
        List<Abstract3dModel> shellParts = new ArrayList();
        
        int zTopHoleTranslate = 35;
        
//        Abstract3dModel topHole = topHole();
//        shellParts.add(topHole)

        // connector for the shaft and top hole
        Abstract3dModel dome = dome(stlBaseOuterRadius, zTopHoleTranslate);
        shellParts.add(dome);

        

//        shellParts.add(topHole);
        
        // this is the bottom wide shaft
        Abstract3dModel bws = bottomWideShaft(zTopHoleTranslate);
        shellParts.add(bws);

        // this thing was modeled after this original
        if(showOriginal)
        {
// TODO: Implement all the code below from the original OpenSCAD file.
/*
                signalStl = "../../../../../../../../../../../../Versioning/world/beto-land-world/3d-printing/super-heroes/batman/bat-signal/customizable_phone_bat_signal_20150130-9347-hv0ikc-0.stl";
                color("yellow")
                translate([0, 0, zTranslate])
                import(signalStl);
*/
//            shellParts.add(original);
        }

        // This is the bottom disk, that holds the text/icon cutout.
        double r = stlBaseInnerRadius + 0.1;        
        Cylinder bottomDiskCylinder = new Cylinder(baseHeight, r);
        Colorize bottomDisk = new Colorize(Color.green, bottomDiskCylinder);                
        shellParts.add(bottomDisk);
        
        Union union = new Union(shellParts);
        
        return union;
    }
}
