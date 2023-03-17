#!/usr/bin/env groovy
@Library('jenkins-shared-library') _

pipeline {
    agent any
    tools {
        maven 'maven-3.9'
    }
    stages {
        stage("test") {
            steps {
                script {
                    echo "Deplopying the application..."
                    echo "Executing pipeline for branch "
                }
            }
        }
        stage("build jar") {
            steps {
                script {
                    buildJar()
                    }
                }
            }
        stage("build image") {
            steps {
                script {
                    buildImage 'moyvr/my-repo:jma-4.0'
                }
            }
        }
    }
}
