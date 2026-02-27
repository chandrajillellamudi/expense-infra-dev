pipeline {
    agent {
        label 'AGENT-1'
    }
     options {
               
                timeout(time: 1, unit: 'HOURS')
                disableConcurrentBuilds() 
                ansiColor('xterm')
            }
     parameters {
          choice(name: 'action', choices: ['Apply', 'Destroy'], description: 'Pick something')
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
            when {
                expression {
                    params.action == 'Apply'
                }
            }
            steps {
                sh """
                cd 1.vpc
                terraform plan
                """
        }
    }
    stage('deploy') {
        //  when {
        //         expression {
        //             params.action == 'Apply'
        //         }
        //     }
        // input {
        //         message "Should we continue?"
        //         ok "Yes, we should."
        //     }
            steps {
                sh 'echo this is deploy'
                // sh """
                //  cd 1.vpc
                //  terraform apply -auto-approve
                // """
            }
        }

    //  stage('destroy') {
    //         when {
    //             expression {
    //                 params.action == 'Destroy'
    //             }
    //         }
    //         steps {
    //             sh """
    //             cd 1.vpc
    //             terraform destroy -auto-approve
    //             """
    //     }
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