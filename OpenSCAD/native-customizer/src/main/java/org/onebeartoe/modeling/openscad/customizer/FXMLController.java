
package org.onebeartoe.modeling.openscad.customizer;

import java.io.IOException;
import java.net.URL;
import java.nio.file.Path;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCameraDirections;
import org.onebeartoe.modeling.openscad.test.suite.PngGenerator;

public class FXMLController implements Initializable 
{
    private PngGenerator pg;
    
    @FXML
    private Label label;
    
    @FXML
    private void handleButtonAction(ActionEvent event) 
    {
        System.out.println("You clicked me!");
        label.setText("Hello World!");
        
        Path oscadInputFile = null;
        try 
        {
            pg.generateOneDirectionalPng(oscadInputFile, true, OpenScadCameraDirections.TOP);
            
        } 
        catch (IOException | InterruptedException ex) 
        {
            Logger.getLogger(FXMLController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) 
    {
        pg = new PngGenerator();
    }    
}
