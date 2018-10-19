
package org.onebeartoe.modeling.javascad.light.signals.heart.of.hearts;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.tranzitions.Scale;
import java.util.ArrayList;
import java.util.List;
import org.onebeartoe.modeling.javascad.ModuleCall;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.TransformProfile;
import org.onebeartoe.modeling.javascad.light.signals.LightSignal;

/**
 * @author Roberto Marquez
 */
public class HeartOfHeartsLightSignal extends OpenScadFile
{
    public HeartOfHeartsLightSignal()
    {
        this(false);
    }
    
    public HeartOfHeartsLightSignal(boolean showBigHeart)
    {
        double zTranslate = -0.51;
        double zScale = 2.5;
        Abstract3dModel heartCall = new ModuleCall("heartThumbnail");
        heartCall = heartCall.move( new Coords3d(0, 0, zTranslate) );
        Scale bigHeartScale = new Scale(heartCall, new Coords3d(1, 1, zScale));

        TransformProfile littleProfile = new TransformProfile();
        double xyScale = 0.1;
        littleProfile.xScale = xyScale;
        littleProfile.yScale = xyScale;
        littleProfile.zScale = zScale;
        littleProfile.xTranslate = 0.0;
        littleProfile.yTranslate = -11;
        littleProfile.zTranslate = zTranslate - 0.7;
        Abstract3dModel littleHeart0 = littleHeart(littleProfile);

        littleProfile.xTranslate = 5;
        littleProfile.yTranslate = -7;
        Abstract3dModel leftHeart1 = littleHeart(littleProfile);                
        littleProfile.xTranslate = -littleProfile.xTranslate;
        Abstract3dModel rightHeart1 = littleHeart(littleProfile);
        
        littleProfile.xTranslate -= 4;
        littleProfile.yTranslate += 4;
        Abstract3dModel leftHeart2 = littleHeart(littleProfile);
        littleProfile.xTranslate *= -1;
        Abstract3dModel rightHeart2 = littleHeart(littleProfile);
        
        littleProfile.xTranslate += 3;
        littleProfile.yTranslate += 4;
        Abstract3dModel leftHeart3 = littleHeart(littleProfile);
        littleProfile.xTranslate *= -1;
        Abstract3dModel rightHeart3 = littleHeart(littleProfile);
        
        littleProfile.xTranslate += 0.3;
        littleProfile.yTranslate += 5;
        Abstract3dModel leftHeart4 = littleHeart(littleProfile);
        littleProfile.xTranslate *= -1;        
        Abstract3dModel rightHeart4 = littleHeart(littleProfile);
        
        littleProfile.xTranslate -= 3;
        littleProfile.yTranslate += 3.5;
        Abstract3dModel leftHeart5 = littleHeart(littleProfile);
        littleProfile.xTranslate *= -1;
        Abstract3dModel rightHeart5 = littleHeart(littleProfile);
        
        littleProfile.xTranslate +=4.5;
        littleProfile.yTranslate += 1;
        Abstract3dModel leftHeart6 = littleHeart(littleProfile);
        littleProfile.xTranslate *= -1;
        Abstract3dModel rightHeart6 = littleHeart(littleProfile);
        
        littleProfile.xTranslate = 0;
        littleProfile.yTranslate -= 2;
        Abstract3dModel littleHeart7 = littleHeart(littleProfile);
        
        List<Abstract3dModel> baseCutouts = new ArrayList();
    
        if(showBigHeart)
        {                    
            baseCutouts.add(bigHeartScale);
        }
        
        baseCutouts.add(littleHeart7);
        baseCutouts.add(leftHeart6);
        baseCutouts.add(rightHeart6);
        baseCutouts.add(leftHeart5);
        baseCutouts.add(rightHeart5);
        baseCutouts.add(leftHeart4);
        baseCutouts.add(rightHeart4);
        baseCutouts.add(leftHeart3);
        baseCutouts.add(rightHeart3);
        baseCutouts.add(leftHeart2);
        baseCutouts.add(rightHeart2);
        baseCutouts.add(leftHeart1);
        baseCutouts.add(rightHeart1);        
        baseCutouts.add(littleHeart0);                
                
        LightSignal signal = new LightSignal(baseCutouts);
        
        models.add(signal);
    }
    
    private Abstract3dModel littleHeart(TransformProfile profile)
    {
        Abstract3dModel littleHeart = new ModuleCall("heartThumbnail");
        Coords3d scale = new Coords3d(profile.xScale, profile.yScale, profile.zScale);
        Coords3d translate = new Coords3d(profile.xTranslate, profile.yTranslate,  profile.zTranslate);
        Abstract3dModel scaledHeart = new Scale(littleHeart, scale)
                                            .move(translate);

        return scaledHeart;
    }
}
