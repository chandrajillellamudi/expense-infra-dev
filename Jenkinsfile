pipeline {
    agent {
        label 'AGENT-1'
    }
     options {
               
                timeout(time: 1, unit: 'HOURS')
                disableConcurrentBuilds() 
                ansiColor('xterm')
            }
    stages {
        stage('init') {
            steps {
                sh """
                cd 1.vpc
                terraform init -reconfigure
                """
            }
        }
        stage('plan') {
            steps {
                sh 'echo this is apply stage'
        }
    }
    stage('apply') {
            steps {
                sh 'echo this is DEPLOY'
                sh ' echo deployment stage'
            }
        }
    }
     post { 
        always { 
              deleteDir()
           // cleanWs()
            echo 'I will always say Hello again!'
        }
        success { 
            echo 'I will always say Hello when pipeline success'
        }
        failure { 
            echo 'I will always say Hello when pipeline fails'
        }
    }

}