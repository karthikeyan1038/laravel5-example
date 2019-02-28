pipeline {
  agent { label 'puppetmaster' }
  stages {
    stage ('checkout') {
      steps {
        checkout scm
      }
    }
    stage ('move'){
      steps {
        sh 'rm -rf /etc/puppetlabs/code/environments/production/modules/php/files/laravel5-example/*'
        sh 'mv /home/zippyops/jenkins/workspace/laravel5-example/* /etc/puppetlabs/code/environments/production/modules/php/files/laravel5-example/'
      }
  }
 }
}

 
