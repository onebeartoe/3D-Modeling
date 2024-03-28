module org.onebeartoe.desktop 
{
    requires java.base;
    requires java.logging;
    requires java.prefs;
    
    requires javafx.base;
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;
    
    requires opensacd.services;
    requires test.suite;
    
//    requires javafx.media;

//    requires org.onebeartoe.minecraft;

//    requires json.simple;


    // you can find the 'requires' for a non-Java-module JAR by issusing this command:
    //         $ jar --file=/home/roberto/.m2/repository/com/opencsv/opencsv/5.3/opencsv-5.3.jar --describe-module
    // Then you copy and paste whatever is before the '@' symbol.
    requires onebeartoe.application;
    
//    opens org.onebeartoe.desktop to javafx.fxml;
    
    opens org.onebeartoe.modeling.openscad.inliner to javafx.fxml, java.base;
//    opens org.onebeartoe.desktop to org.onebeartoe.minecraft, javafx.fxml;

    exports org.onebeartoe.modeling.openscad.inliner;
//    exports org.onebeartoe.desktop;
}
