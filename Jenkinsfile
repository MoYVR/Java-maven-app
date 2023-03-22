#!/usr/bin/env groovy

pipeline {
    agent any
    stages {
        stage("test") {
            steps {
                script {
                   echo "testing the app..."
                }
            }
        }
        stage("build") {
            steps {
                script {
                    echo "building the app..."
                    }
                }
            }
        stage("deploy") {
            steps {
                script {
                     def dockerCmd = 'docker run -p 3080:3080 -d moyvr/my-repo:1.1.1-56'
                    echo "deploying docker image to EC2..." 
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.234.54.219 ${dockerCmd}"
                    echo "Deplopying the app..."
                }
            }
        }
    }
}
}
