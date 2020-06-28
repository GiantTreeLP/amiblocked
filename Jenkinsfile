pipeline {
  agent {
    docker {
      label 'docker'
      image 'cirrusci/flutter:beta'
      args '-u root:root'
    }
  }
  options {
     buildDiscarder logRotator(numToKeepStr: '10')
  }
  stages {
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
