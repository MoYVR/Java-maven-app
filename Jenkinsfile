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
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@54.146.250.200:/home/ubuntu"
                        
                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh "scp ${keyfile} ubuntu@54.146.250.200:/home/ubuntu/ssh-key.pem"
                        }
                    }
                    
                }
            }
        }

    }
}

