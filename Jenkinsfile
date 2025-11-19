// pipeline 

// {
//     agent any 
//     stages 
//     {
//         stage('Code checkout')
//         {
//             steps 
//             {
//                 git branch: 'main', url: 'https://github.com/Diane-Mahoro1/Industry-Grade-Project-I.git'
//             }
//         }
//         stage('code compile'){
//             steps
//             {
//                 sh 'mvn compile'
//             }

//         }

//         stage('Test'){
//             steps
//             {
//                 sh 'mvn test'
//             }
//         }
//         stage('build'){
//             steps
//             {
//                 sh 'mvn package'
//             }
//         }

//         stage('Build Docker Image'){
//             steps{
//                 // sh 'cp /var/lib/jenkins/workspace/$JOB_NAME/target/abctechnologies.war/var/lib/jenkins/workspace/$JOB_NAME/abctechnologies.war'
//                 // sh 'docker build -t mahoro01/abc_tech:$BUILD_NUMBER .'
//                 sh '''
//                 cp target/ABCtechnlogies-1.0.war abctechnologies.war
//                 docker build -t mytomcatapp .
//                 '''
//             }

//         }
//         stage('push Docker Image'){
//             steps{
//                 withDockerRegistry([credentialsId: "dockerhub", url:""])
//                 {
//                     sh 'docker push mahoro01/abc_tech:$BUILD_NUMBER'
//                 }
//             }
//         }
//         stage('deploy as container'){
//             steps{
//                 sh 'docker run -itd -P mahoro01/abc_tech:$BUILD_NUMBER'
//             }
//         }
//     }
// // }
// pipeline {
//     agent any
//     environment {
//         IMAGE_NAME = "mahoro01/abc_tech"
//     }


//     stages {
//         stage('Code checkout') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Diane-Mahoro1/Industry-Grade-Project-I.git'
//             }
//         }

//         stage('Code compile') {
//             steps {
//                 sh 'mvn compile'
//             }
//         }

//         stage('Test') {
//             steps {
//                 sh 'mvn test'
//             }
//         }

//         stage('Build') {
//             steps {
//                 sh 'mvn package'
//             }
//         }

//         stage('Build Docker Image') {
//     steps {
//         sh 'ls -l target/'  // List all files in the target directory to confirm the WAR file
//         sh 'cp target/*.war abctechnologies.war'  // Copy the WAR file
//         sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'  // Build Docker image
//     }
// }


//         stage('Push Docker Image') {
//             steps {
//                 withDockerRegistry([credentialsId: "mahoro01", url: ""]) {
//                     sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
//                 }
//             }
//         }

//         stage('Deploy as Container') {
//             steps {
//                 sh 'docker run -itd -P mahoro01/abc_tech:$BUILD_NUMBER || true'
//             }
//         }
//     }
// }
// stage('Cleanup') {
//     steps {
//         sh '''
//             echo "Cleaning up Docker resources..."
//             docker system prune -af || true
//             docker volume prune -f || true
//         '''
//     }
// // }
// pipeline {
//     agent any
//     environment {
//         IMAGE_NAME = "mahoro01/abc_tech"
//     }

//     stages {
//         stage('Code checkout') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Diane-Mahoro1/Industry-Grade-Project-I.git'
//             }
//         }

//         stage('Code compile') {
//             steps {
//                 sh 'mvn compile'
//             }
//         }

//         stage('Test') {
//             steps {
//                 sh 'mvn test -DskipTests'
//             }
//         }

//         stage('Build') {
//             steps {
//                 sh 'mvn package -DskipTests'
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 sh 'ls -l target/'  // Verify the WAR file exists
//                 sh 'cp target/*.war abctechnologies.war'
//                 sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
//             }
//         }

//         stage('Push Docker Image') {
//             steps {
//                 withDockerRegistry([credentialsId: "mahoro01", url: ""]) {
//                     sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
//                 }
//             }
//         }

//         stage('Deploy as Container') {
//             steps {
//                 // Stop and remove previous container if exists
//                 sh '''
//                     CONTAINER_ID=$(docker ps -q -f name=abc_tech || true)
//                     if [ ! -z "$CONTAINER_ID" ]; then
//                         docker stop $CONTAINER_ID
//                         docker rm $CONTAINER_ID
//                     fi
//                     docker run -d -p 8080:8080 --name abc_tech $IMAGE_NAME:$BUILD_NUMBER
//                 '''
//             }
//         }

//         stage('Cleanup') {
//             steps {
//                 sh '''
//                     echo "Cleaning up Docker resources..."
//                     docker system prune -af || true
//                     docker volume prune -f || true
//                 '''
//             }
//         }
//     }
// }
pipeline {
    agent any

    environment {
        IMAGE_NAME = "mahoro01/abc_tech"
    }

    stages {
        stage('Code checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Diane-Mahoro1/Industry-Grade-Project-I.git'
            }
        }

        stage('Code compile') {
            steps {
                timeout(time: 3, unit: 'MINUTES') {
                    sh 'mvn compile'
                }
            }
        }

        stage('Test') {
            steps {
                timeout(time: 3, unit: 'MINUTES') {
                    sh 'mvn test -DskipTests'
                }
            }
        }

        stage('Build') {
            steps {
                timeout(time: 3, unit: 'MINUTES') {
                    sh 'mvn package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    sh 'ls -l target/'
                    sh 'cp target/*.war abctechnologies.war'
                    sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    withDockerRegistry([credentialsId: "mahoro01", url: ""]) {
                        sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
                    }
                }
            }
        }

        // stage('Deploy as Container') {
        //     steps {
        //         timeout(time: 3, unit: 'MINUTES') {
        //             sh '''
        //                 CONTAINER_ID=$(docker ps -q -f name=abc_tech || true)
        //                 if [ ! -z "$CONTAINER_ID" ]; then
        //                     docker stop $CONTAINER_ID
        //                     docker rm $CONTAINER_ID
        //                 fi
        //                 docker run -d -p 8080:8080 --name abc_tech $IMAGE_NAME:$BUILD_NUMBER
        //             '''
        //         }
        //     }
        // }
        stage('Deploy as Container') {
    steps {
        sh '''
            echo "Stopping any container using port 8080..."

            # Find and stop container using port 8080
            PORT_CONTAINER=$(docker ps -q --filter "publish=8080")

            if [ ! -z "$PORT_CONTAINER" ]; then
                echo "Stopping container using port 8080: $PORT_CONTAINER"
                docker stop $PORT_CONTAINER
                docker rm $PORT_CONTAINER
            fi

            # Also remove abc_tech if exists
            CONTAINER_ID=$(docker ps -aq -f name=abc_tech)
            if [ ! -z "$CONTAINER_ID" ]; then
                docker stop $CONTAINER_ID || true
                docker rm $CONTAINER_ID || true
            fi

            # Now deploy new container
            docker run -d -p 8080:8080 --name abc_tech $IMAGE_NAME:$BUILD_NUMBER
        '''
    }
}


        stage('Cleanup') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    sh '''
                        echo "Cleaning up Docker resources..."
                        docker system prune -af || true
                        docker volume prune -f || true
                    '''
                }
            }
        }
    }
}
