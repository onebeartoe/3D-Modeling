# 3D-Modeling
This is repository for models fit for 3D printing.  So far OpenSCAD is used as the programming language.

This project also has a test suite for OpenSCAD scripts.   

The test suite creates baseline snapshots of each .scad rendering.  The test suite is run again after changes are made to 'library' .scad files.  Then a comparison is made between the baseline snapshot and the snapshot after the changes. 

The test suite then reports any files that differ, allowing you to check that only the expected baseline image were updated. 

It is written in Java and run from the command line, so it runs in headless mode. 

The code for the test suite is under OpenSCAD/test-suite/

If you are interested, check it out and please let me know what you think.
