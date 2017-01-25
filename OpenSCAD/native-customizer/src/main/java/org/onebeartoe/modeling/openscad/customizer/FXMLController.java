
package org.onebeartoe.modeling.openscad.customizer;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.prefs.BackingStoreException;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.image.ImageView;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import org.onebeartoe.application.DesktopApplication;
import org.onebeartoe.application.JavaPreferencesService;
import org.onebeartoe.application.PreferencesService;
import org.onebeartoe.application.ui.GraphicalUserInterfaceServices;
import org.onebeartoe.application.ui.JavaFxGuiServices;
import org.onebeartoe.modeling.openscad.test.suite.PngGenerator;

public class FXMLController implements Initializable, DesktopApplication 
{
    private Logger logger;
    
    private PreferencesService preferencesService;
    
    private GraphicalUserInterfaceServices uiServices;
    
    private ThingiverseCustomizerService customizerService;
    
    private PngGenerator pg;
    
    private String openScadFile;
    
    @FXML
    private ImageView openscadPreviewImage;
    
    private void generateCutomizerFile()
    {
        try 
        {
            File infile = new File(openScadFile);
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
            
            String message = "Error: " + ex.getMessage();
            String title = "An Error Occurred";
            uiServices.infoMessage(message, title);
        }
    }
    
    @FXML
    private void handleButtonAction(ActionEvent event)
    {
        System.out.println("You clicked me!");
//        label.setText("Hello World!");
        
//        String inpath = "C:\\home\\owner\\versioning\\github\\3D-Modeling\\OpenSCAD\\src\\main\\openscad\\office\\keyboard\\keycaps\\cherry-mx\\letter-key-test.scad";
//        inpath = "C:\\home\\owner\\versioning\\github\\3D-Modeling\\OpenSCAD\\src\\main\\openscad\\toys\\fidget-spinner\\fidget-spinner.scad";
//        File infile = new File(inpath);

        if(openScadFile == null)
        {
            String message = "No OpenSCAD file is selected.  Please select an OpenSCAD file to generate a Customizer version.";
            String title = "Select an OpenSCAD File";
            uiServices.infoMessage(message, title);
        }
        else
        {
            generateCutomizerFile();
        }
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) 
    {
        logger = Logger.getLogger(getClass().getName() );
        pg = new PngGenerator();
        
        preferencesService = new JavaPreferencesService(this);
        String defaultValue = null;
        openScadFile = preferencesService.get(OpenScadPreferences.OPENSCAD_FILE, defaultValue);
        String message = "OpenSCAD file: " + openScadFile;
        logger.log(Level.INFO, message);
        
        uiServices = new JavaFxGuiServices();
        
        customizerService = new ThingiverseCustomizerService();
    }
    
    private void savePreference(OpenScadPreferences key, String value)
    {
        String preferenceName = key.name();
        try 
        {       
            preferencesService.saveProperty(preferenceName, value);
        } 
        catch (BackingStoreException ex) 
        {
            String message = ex.getMessage();
            
            logger.log(Level.SEVERE, message, ex);
            
            String title = "Error Saving Preference";
            uiServices.infoMessage(message, title);
        }
    }

    @FXML 
    void selectOpenScadFile(ActionEvent event)
    {
        // show the file chooser dialog
        FileChooser fc = new FileChooser();
        final Stage dialog = new Stage();
        File file = fc.showOpenDialog(dialog);
        if (file != null)
        {
            // save the current file to preferences
            savePreference(OpenScadPreferences.OPENSCAD_FILE, file.getAbsolutePath() );
        }
    }
}
