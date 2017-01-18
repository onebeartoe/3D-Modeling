
package org.onebeartoe.modeling.openscad.customizer;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import org.onebeartoe.modeling.openscad.test.suite.PngGenerator;

public class FXMLController implements Initializable 
{
    Logger logger;
    
    private PngGenerator pg;
    
    @FXML
    private Label label;
    
    @FXML
    private void handleButtonAction(ActionEvent event) 
    {
        System.out.println("You clicked me!");
        label.setText("Hello World!");
        
        String inpath = "C:\\home\\owner\\versioning\\github\\3D-Modeling\\OpenSCAD\\src\\main\\openscad\\office\\keyboard\\keycaps\\cherry-mx\\letter-key-test.scad";
        inpath = "C:\\home\\owner\\versioning\\github\\3D-Modeling\\OpenSCAD\\src\\main\\openscad\\toys\\fidget-spinner\\fidget-spinner.scad";
        
        File infile = new File(inpath);
        ThingiverseCustomizerService customizerService = new ThingiverseCustomizerService();

        try 
        {
            String interpolatedContent = customizerService.interpolateOpenScad(infile);
            String path = infile.getParent() + File.separator + infile.getName() + "-CUSTOMIZER.scad";
            File outfile = new File(path);
            Path outpath = outfile.toPath();
            Files.write(outpath, interpolatedContent.getBytes() );
            logger.log(Level.INFO, "The OpenScad file for Thingiverse Customizer has been output to: " + outpath.toAbsolutePath() );
        } 
        catch (IOException  ex)
        {
            logger.log(Level.SEVERE, ex.getMessage(), ex);
        }
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) 
    {
        logger = Logger.getLogger(getClass().getName() );
        pg = new PngGenerator();
    }    
}
