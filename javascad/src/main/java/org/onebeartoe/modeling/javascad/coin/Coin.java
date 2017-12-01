
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
        ModuleCall mc = new ModuleCall("heartThumbnail");
        Coords3d scaleFactor = new Coords3d(1, 1, 1.02);
        
        Scale heart = new Scale(mc.move(Coords3d.zOnly(-0.5)), scaleFactor);

        Cylinder coin = new Cylinder(1, 20);
        
        Difference diff = new Difference(coin, heart);

        baseModel = diff;
    }
}
