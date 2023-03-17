// def buildJar() {
//     echo "building the application..."
//     sh 'mvn package'
// } 

// def buildImage() {
//     echo "building the docker image..."
//     withCredentials([usernamePassword(credentialsId:'docker-hub-repo', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
//     sh 'docker build -t moyvr/my-repo:jma-3.0 .'
//     sh "echo $PASS | docker login -u $USER --password-stdin"
//     sh 'docker push moyvr/my-repo:jma-3.0'
//     }
// } 

def deployApp() {
    echo 'deploying the application...'
} 

return this
