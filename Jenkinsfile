pipeline {
    agent any
    stages {
        stage("Web") {
            steps {
                build 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "web")
                ]
            }
        }
        stage("DB") {
            steps {
                build 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "db")
                ]
            }
        }
        stage("DataService") {
            steps {
                build 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "dataservice")
                ]
            }
        }
        stage("LoadBalancer") {
            steps {
                build 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "loadbalancer")
                ]
            }
        }
        stage("LogService") {
            steps {
                build 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "logservice")
                ]
            }
        }
    }
}
