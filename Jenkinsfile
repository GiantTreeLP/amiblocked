pipeline {
  agent {
    docker {
      label 'docker'
      image 'cirrusci/flutter:beta'
    }
  }
  options {
     buildDiscarder logRotator(numToKeepStr: '10')
  }
  stages {
    stage('Prepare') {
      steps {
        sh 'sudo chown 1003:1003 -R /home/cirrus'
      }
    }
    stage('Install') {
      steps {
        sh 'id'
        sh 'flutter channel beta'
        sh 'flutter upgrade'
        sh 'flutter config --enable-web'
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
