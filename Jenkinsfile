
pipeline 
{
  agent any

  environment{
//    OPENSCAD_PATH = "/snap/bin/openscad"
    OPENSCAD_PATH = "/opt/openscad/OpenSCAD-2021.01-x86_64.AppImage"
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
                whoami
                java -version
                $OPENSCAD_PATH --help
                mvn verify
           '''
      }
    }
  }
}
