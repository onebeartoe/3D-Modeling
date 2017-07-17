
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
import org.onebeartoe.application.DesktopApplication;
import org.onebeartoe.application.ui.WindowProperties;

public class MainApp extends Application implements DesktopApplication
{
    private WindowProperties wp;
    
    @Override
    public void init()
    {
        String applicationId = getClass().getName();
        try 
        {
            wp = restoreWindowProperties(applicationId);
        } 
        catch (IOException | ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        }
        
        if(wp == null)
        {
            wp = new WindowProperties();
            
            wp.id = getClass().getName();
            wp.applicationName = getClass().getSimpleName();
            
            // use the default values
            wp.width = 573;
            wp.height = 114;
            
            wp.locationX = 50;
            wp.locationY = 100;
        }
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
        
        stage.setWidth(wp.width);
        stage.setHeight(wp.height);
                
        stage.setX(wp.locationX);
        stage.setY(wp.locationY);
        
        stage.setOnCloseRequest( new EventHandler<WindowEvent>() 
        {
            @Override
            public void handle(WindowEvent event) 
            {
                System.out.println("bye");
                wp.locationX = (int) stage.getX();
                wp.locationY = (int) stage.getY();

                wp.width = (int) stage.getWidth();
                wp.height = (int) stage.getHeight();

                try
                {
                    MainApp.this.persistWindowProperties(wp);
                } 
                catch (IOException ex) 
                {
                    ex.printStackTrace();
                }
            }
        });
        stage.show();
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