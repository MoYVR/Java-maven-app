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
                    sh 'mvn build-helper:parse-version version:set \
                    -DnewVersion=\\\${parseVersion.majorVersion}.\\\${parseVersion.minorVersion}.\\\${parseVersion.nextIncrementalVersion} \
                    versions:commit.'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = [0][1]
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
    }
}

