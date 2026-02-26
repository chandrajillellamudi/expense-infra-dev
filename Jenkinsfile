pipeline {
    agent {
        label 'AGENT-1'
    }
     options {
               
                timeout(time: 1, unit: 'HOURS')
                disableConcurrentBuilds() 
            }
    stages {
        stage('init') {
            steps {
                sh """
                ls -ltr
                """
            }
        }
        stage('plan') {
            steps {
                sh 'echo this is TEST'
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