
package org.onebeartoe.modeling.javascad.coin;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.models.Extendable3dModel;
import eu.printingin3d.javascad.tranzitions.Difference;
import eu.printingin3d.javascad.tranzitions.Scale;
import org.onebeartoe.modeling.javascad.ModuleCall;

/**
 * @author Roberto Marquez
 */
public class Coin extends Extendable3dModel
{
    public Coin()
    {
        
        ModuleCall heart = new ModuleCall("heartThumbnail");
                        
        Scale s = new Scale(heart.move(Coords3d.zOnly(-0.5))
                            , new Coords3d(1, 1, 1.02) );
        
        
        
        Cylinder coin = new Cylinder(1, 20);
        
        Difference diff = new Difference(coin, 
                                            s
        );

        baseModel = diff;
    }
}
