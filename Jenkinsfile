pipeline {
    agent any
    tools {
        maven 'maven-3.9'
    }
    stages {
        stage("increment version") {
            steps {
                script {
                    echo "incrementing app version..."
                    sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                }
            }
        }
        stage("build app") {
            steps {
                script {
                    echo "building the application..."
                    sh 'mvn clean package'
                    }
                }
            }
        stage("build image") {
            steps {
                script {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId:'docker-hub-repo', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "docker build -t moyvr/my-repo:${IMAGE_NAME} ."
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push moyvr/my-repo:${IMAGE_NAME}"
                    }
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "deploying docker image to EC2..." 
                }
            }
        }
    stage("commit version update") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId:'a6f9c62c-b4b6-41fb-8aa8-dbd141e72a57', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'
                        sh 'git config --global --unset http.proxy'

                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'


                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/MoYVR/Java-maven-app.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin jenkins-jobs'
                    }
                }
            }
        }
    }
}
