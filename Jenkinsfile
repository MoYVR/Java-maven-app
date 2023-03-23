#!/usr/bin/env groovy
// pipeline {
//     agent any
//     tools {
//         maven 'maven-3.9'
//     }
//     stages {
//         stage("increment version") {
//             steps {
//                 script {
//                     echo "incrementing app version..."
//                     // sh 'mvn build-helper:parse-version versions:set \
//                     // -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
//                     // versions:commit'
//                     // def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
//                     // def version = matcher[0][1]
//                     // env.IMAGE_NAME = "$version-$BUILD_NUMBER"
//                 }
//             }
//         }
//         stage("build app") {
//             steps {
//                 script {
//                     echo "building the application..."
//                     // sh 'mvn clean package'
//                     }
//                 }
//             }
//         stage("build image") {
//             steps {
//                 script {
//                     echo "building the docker image..."
//                     // withCredentials([usernamePassword(credentialsId:'docker-hub-repo', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
//                     // sh "docker build -t moyvr/my-repo:${IMAGE_NAME} ."
//                     // sh "echo $PASS | docker login -u $USER --password-stdin"
//                     // sh "docker push moyvr/my-repo:${IMAGE_NAME}"
//                     // }
//                 }
//             }
//         }
//         stage("deploy") {
//             steps {
//                 script {
//                     def dockerCmd = 'docker run -p 3080:3080 -d moyvr/my-repo:1.1.1-56'
//                     echo "deploying docker image to EC2..." 
//                     sshagent(['ec2-server-key']) {
//                         sh "ssh -o StrictHostKeyChecking=no ec2-user@44.197.188.63 ${dockerCmd}"
//                     }
//                 }
//             }
//         }
//     stage("commit version update") {
//             steps {
//                 script {
//                     withCredentials([usernamePassword(credentialsId:'a6f9c62c-b4b6-41fb-8aa8-dbd141e72a57', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
//                         sh 'git config --global user.email "jenkins@example.com"'
//                         // sh 'git config --global user.name "jenkins"'
                        
                        
//                         // sh 'git status'
//                         // sh 'git branch'
//                         // sh 'git config --list'


//                         // sh "git remote set-url origin https://${USER}:${PASS}@github.com/MoYVR/Java-maven-app.git"
//                         // sh 'git add .'
//                         // sh 'git commit -m "ci: version bump"'
//                         //sh 'git push origin HEAD:jenkins-jobs'd
                        
//                     }
//                 }
//             }
//         }
//     }
// }





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
        IMAGE_NAME = 'moyvr/my-repo:java-maven-1.0'
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
        stage("deploy") {
            steps {
                script {
                    echo "Deplopying docker image to EC2..."
                    def shellCmd = "bash ./server-cmds.sh"
                    sshagent(['ec2-server-key']) {
                    sh "scp server-cmds.sh ec2-user@54.234.54.219:/home/ec2-user"
                    sh "scp docker-compose.yaml ec2-user@54.234.54.219:/home/ec2-user"    
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@54.234.54.219 ${shellCmd}"
                    }
                }
            }
        }
    }
}
