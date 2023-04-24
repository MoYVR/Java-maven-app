#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/MoYVR/jenkins-shared-library.git',
    credentialsId: 'a6f9c62c-b4b6-41fb-8aa8-dbd141e72a57'
    ]
)

pipeline {
    agent any
    tools {
        maven 'maven-3.9'
    }
     environment {
        IMAGE_NAME = 'moyvr/my-repo:java-maven-2.0'
     }

    stages {
        stage("build app") {
            steps {
                script {
                   echo "building app jar..."
                   buildJar()
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building docker image..."
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                    }
                }
            }
        stage("provision server") {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
                TF_VAR_env_prefix = 'test'
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform destroy --auto-approve"
//                         sh "terraform apply --auto-approve"
//                         EC2_PUBLIC_IP = sh (
//                             script: "terraform output server-public-ip",
//                             returnStdout: true
//                         ).trim()
                     
                    }
                }
            }
        }
        stage("deploy") {
            environment {
                DOCKER_CREDS = credentials('docker-hub-repo')
            }
            steps {
                script {
                    echo "waiting for EC2 server to initialize"
//                     sleep(time: 90, unit: "SECONDS")

//                     echo "Deplopying docker image to EC2..."
//                     echo "${EC2_PUBLIC_IP}"

//                     def shellCmd = "bash server-cmds.sh ${IMAGE_NAME} ${DOCKER_CREDS_USR} ${DOCKER_CREDS_PSW}"
//                     def ec2 = "ec2-user@${EC2_PUBLIC_IP}"

//                     sshagent(['mozw']) {
//                         sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2}:/home/ec2-user"
//                         sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2}:/home/ec2-user"    
//                         sh "ssh -o StrictHostKeyChecking=no ${ec2} ${shellCmd}"
//                     }
                }
            }
        }
    }
}
