pipeline {
    agent any
    stages {
        stage("Web") {
            environment {
                FILENAME = 'web'
            }
            steps {
                build 'ECRpipeline'
            }
        }
        stage("DB") {
            environment {
                FILENAME = 'db'
            }
            steps {
                build 'ECRpipeline'
            }
        }
        stage("DataService") {
            environment {
                FILENAME = 'dataservice'
            }
            steps {
                build 'ECRpipeline'
            }
        }
        stage("LoadBalancer") {
            environment {
                FILENAME = 'loadbalancer'
            }
            steps {
                build 'ECRpipeline'
            }
        }
        stage("LogService") {
            environment {
                FILENAME = 'logservice'
            }
            steps {
                build 'ECRpipeline'
            }
        }
    }
}
