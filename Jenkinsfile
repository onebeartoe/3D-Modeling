
pipeline 
{
  agent any

  environment
  {
//    OPENSCAD_PATH = "/snap/bin/openscad"
//    OPENSCAD_PATH = "/opt/openscad/OpenSCAD-2021.01-x86_64.AppImage"
    OPENSCAD_PATH = "/opt/openscad/OpenSCAD-2025.11.10.ai28923-x86_64.AppImage"

    OPENSCAD_SUBPATH = "coins-pendants-ornaments/ornaments/star"

//TODO: where was this from again?
//    LIBGL_ALWAYS_SOFTWARE=1
  }

  stages {
    stage('clean') {
      steps {
        echo 'Cleaning...'
        sh '''
                mvn clean
           '''
      }
    }

    stage('install') {
      steps {
        echo 'Verifying...'
        sh '''
                Xvfb :5 -screen 0 800x600x24 &
                export DISPLAY=:5
                whoami
		$OPENSCAD_PATH --version
                java -version
                mvn verify
           '''
      }
    }
  }
}
