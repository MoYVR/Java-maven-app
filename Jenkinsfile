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
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@54.83.72.11:/home/ubuntu"
                        
                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile ubuntu@54.83.72.11:/home/ubuntu/ssh-key.pem'
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
                    remote.host = "54.83.72.11"
                    remote.allowAnyHosts = true
                    remote.logLevel = 'FINEST'

                    

                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                        remote.user = user
                        remote.identityFile = keyfile
//                         sshCommand remote: remote, command: 'ls', verbose: true
                        def commandResult = sshCommand remote: remote, command: "ls -ll"
                        echo "Result: " + commandResult
                    }
                }
            }
        }

    }
}

