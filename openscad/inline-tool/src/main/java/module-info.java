module org.onebeartoe.desktop 
{
    requires java.base;
    requires java.logging;
    requires java.prefs;
    
    requires javafx.base;
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;

    // the following two are onebeartoe dependencies
    requires opensacd.services;
    requires test.suite;

    // you can find the 'requires' for a non-Java-module JAR by issusing this command:
    //         $ jar --file=/home/roberto/.m2/repository/com/opencsv/opencsv/5.3/opencsv-5.3.jar --describe-module
    // Then you copy and paste whatever is before the '@' symbol.
    requires onebeartoe.application;
    
    opens org.onebeartoe.modeling.openscad.inliner to javafx.fxml, java.base;

    exports org.onebeartoe.modeling.openscad.inliner;
}
