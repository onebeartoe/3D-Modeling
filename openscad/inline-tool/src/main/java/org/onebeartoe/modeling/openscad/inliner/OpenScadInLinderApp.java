
package org.onebeartoe.modeling.openscad.inliner;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.application.Application;
import static javafx.application.Application.launch;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;

import org.onebeartoe.application.ui.JavafxApplication;

public class OpenScadInLinderApp extends Application
{    
    private JavafxApplication guiConiguration;
    
    private final String applicationId;

    public OpenScadInLinderApp()
    {
        applicationId = getClass().getName();
    }
    
    @Override
    public void init()
    {
        loadDefaultGuiConfig();
    }
    
    @Override
    public void start(Stage stage) throws Exception 
    {
        URL sceneUrl = getClass().getResource("/fxml/Scene.fxml");
        ResourceBundle resourceBundle = ResourceBundle.getBundle("gui");
        Parent root = FXMLLoader.load(sceneUrl, resourceBundle);
        
        Scene scene = new Scene(root);
        scene.getStylesheets().add("/styles/Styles.css");
        
        stage.setTitle("OpenSCAD Inliner");
        stage.setScene(scene);
        
        guiConiguration.restoreWindowProperties(stage);
        
        stage.setOnCloseRequest(new EventHandler<WindowEvent>() 
        {
            @Override
            public void handle(WindowEvent event) 
            {
                System.out.println("bye");

                guiConiguration.setCurrentConfiguration(stage);
                guiConiguration.setApplicationId(applicationId);
                
                try
                {
                    guiConiguration.persistWindowProperties();
                } 
                catch (IOException ex) 
                {
                    ex.printStackTrace();
                }
            }
        });
        stage.show();
    }
    
    public void loadDefaultGuiConfig()
    {
        guiConiguration = new JavafxApplication(applicationId) 
        {
            @Override
            public int defaultX() 
            {
                return 50;    
            }
            
            @Override
            public int defaultY() 
            {
                return 100;
            }
            
            @Override
            public int defaultWidth() 
            {
                return 573;
            }
            
            @Override
            public int defaultHeight() 
            {
                return 114;
            }
        };
    }

    /**
     * The main() method is ignored in correctly deployed JavaFX application.
     * main() serves only as fallback in case the application can not be
     * launched through deployment artifacts, e.g., in IDEs with limited FX
     * support. NetBeans ignores main().
     *
     * @param args the command line arguments
     */
    public static void main(String[] args) 
    {
        launch(args);
    }
}