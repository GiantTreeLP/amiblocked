pipeline {
  agent {
    docker {
      label 'docker'
      image 'cirrusci/flutter:beta'
    }
  }
  options {
     buildDiscarder logRotator(numToKeepStr: '25')
  }
  stages {
    stage('Install') {
      steps {
        sh 'flutter pub get'
      }
    }
    stage('Build') {
      steps {
        sh 'flutter build web'
      }
    }
    stage('Archive') {
      steps {
        zip archive: true, dir: 'build/web', glob: '', zipFile: 'dist.zip'
      }
    }
  }
}
