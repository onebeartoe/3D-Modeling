
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.context.IScadGenerationContext;
import eu.printingin3d.javascad.coords.Boundaries3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.SCAD;
import eu.printingin3d.javascad.vrl.CSG;
import eu.printingin3d.javascad.vrl.FacetGenerationContext;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author Roberto Marquez
 */
public class ModuleCall extends Abstract3dModel
//                                Complex3dModel
{
    private final String moduleName;
    
    private Map<String, String> paramters;
    
    public ModuleCall(String moduleName)
    {
        this.moduleName = moduleName;
        
        paramters = new HashMap();
    }
    
    public void addParameter(String name, String value)
    {
        paramters.put(name, value);
    }
    
    @Override
    protected SCAD innerToScad(IColorGenerationContext context) 
    {
        SCAD result = new SCAD(moduleName);
        
        result = result.append("(");
        
        StringBuilder sb = new StringBuilder();
        
        Set<String> keys = paramters.keySet();
        List<String> keyList = new ArrayList(keys);        
        Collections.sort(keyList);        
        StringBuilder paramList = new StringBuilder();
        for(String k : keyList)
        {
            String value = paramters.get(k);
            
            paramList.append(k + "=" + value + ", ");                        
        }
        if(paramList.length() > 0)
        {
            // Remove the last comma since it breaks syntax.
            int lastCommaIndex = paramList.toString().lastIndexOf(",");
            String s = paramList.toString().substring(0, lastCommaIndex);
            
            paramList = new StringBuilder(s);
        }
        sb.append(paramList.toString() );
        
        result = result.append(sb.toString() );
        
        result = result.append(")");
        
        return result.append(";");
    }

    @Override
    protected Abstract3dModel innerCloneModel()
    {
        ModuleCall mc = new ModuleCall(moduleName);
        Set<String> keySet = paramters.keySet();
        for(String k : keySet)
        {
            mc.paramters.put(k, paramters.get(k));
        }
        
        return mc;
    }

    @Override
    protected Boundaries3d getModelBoundaries()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected CSG toInnerCSG(FacetGenerationContext context)
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected Abstract3dModel innerSubModel(IScadGenerationContext context)
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected boolean isPrimitive() {
        return false;
    }
}
