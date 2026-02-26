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
                sh """
                cd 1.vpc
                terraform plan
                """
        }
    }
    stage('apply') {
        input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            steps {
                sh """
                cd 1.vpc
                terraform plan
                """
            }
        }
    }
     post { 
        always { 
              deleteDir() //no need of plugin
           // cleanWs() needs plugin
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