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
        stage('provision server') {
            environment {
                AWS_ACCESS_KEY_ID = credentialsId('jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentialsId('jenkins_aws_secret_access_key')
                TF_VAR_env_prefix = 'test'
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP = sh (
                            script: "terraform output server-public-ip",
                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "waiting for EC2 server to initialize"
                    sleep(time: 90, unit: "SECONDS")

                    echo "Deplopying docker image to EC2..."
                    echo "${EC2_PUBLIC_IP}"

                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
                    def ec2 = "ec2-user@${EC2_PUBLIC_IP}"

                    sshagent(['ec2-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2}:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2}:/home/ec2-user"    
                        sh "ssh -o StrictHostKeyChecking=no ${ec2} ${shellCmd}"
                    }
                }
            }
        }
        stage("commit version update") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId:'a6f9c62c-b4b6-41fb-8aa8-dbd141e72a57', usernameVariable: 'USER', passwordVariable: 'PASS')]) {


                    sh "git remote set-url origin https://${USER}:${PASS}@github.com/MoYVR/Java-maven-app.git"
                    sh 'git add .'
                    sh 'git commit -m "ci: version bump"'
                    sh 'git push origin HEAD:jenkins-jobs'
                        
                    }
                }
            }
        }
    }
}
