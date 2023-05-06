pipeline {
    agent any
    // tools {
    //     maven 'maven-3.9'
    // }
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copying all neccessary files to ansible control code"
                    sshagent(['ansible-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@34.236.151.183:/home/ubuntu"
                        
                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile ubuntu@34.236.151.183:/home/ubuntu/ssh-key.pem'
                        }
                    }
                    
                }
            }
        }
        stage("execute ansible playbook") {
            steps {
                script {
                    echo "calling ansible playbook to configure ec2 instances"
                    def remote = [:]
                    remote.name = "ansible-server"
                    // remote.host = "34.236.151.183"
                    remote.allowAnyHosts = true

                    // remote.user = ubuntu
                        sshCommand remote: '34.236.151.183', credentialsId: 'ansible-server-key', command: "ls -la"
                    }
                }
            }
        }
    }
// }

