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
//                 timeout(time: 3, unit: 'MINUTES') {
//                     sh 'mvn compile'
//                 }
//             }
//         }

//         stage('Test') {
//             steps {
//                 timeout(time: 3, unit: 'MINUTES') {
//                     sh 'mvn test -DskipTests'
//                 }
//             }
//         }

//         stage('Build') {
//             steps {
//                 timeout(time: 3, unit: 'MINUTES') {
//                     sh 'mvn package -DskipTests'
//                 }
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 timeout(time: 5, unit: 'MINUTES') {
//                     sh 'ls -l target/'
//                     sh 'cp target/*.war abctechnologies.war'
//                     sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
//                 }
//             }
//         }

//         stage('Push Docker Image') {
//             steps {
//                 timeout(time: 5, unit: 'MINUTES') {
//                     withDockerRegistry([credentialsId: "mahoro01", url: ""]) {
//                         sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
//                     }
//                 }
//             }
//         }

//         // stage('Deploy as Container') {
//         //     steps {
//         //         timeout(time: 5, unit: 'MINUTES') {
//         //             sh '''
//         //                 echo "Stopping any container using port 8080..."

//         //                 # Stop any container using port 8080
//         //                 PORT_CONTAINER=$(docker ps -q --filter "publish=8080")
//         //                 if [ ! -z "$PORT_CONTAINER" ]; then
//         //                     echo "Stopping container using port 8080: $PORT_CONTAINER"
//         //                     docker stop $PORT_CONTAINER
//         //                     docker rm $PORT_CONTAINER
//         //                 fi

//         //                 # Remove any existing container named abc_tech
//         //                 CONTAINER_ID=$(docker ps -aq -f name=abc_tech)
//         //                 if [ ! -z "$CONTAINER_ID" ]; then
//         //                     docker stop $CONTAINER_ID || true
//         //                     docker rm $CONTAINER_ID || true
//         //                 fi

//         //                 # Deploy new container
//         //                 docker run -d -p 8081:8080 --name abc_tech $IMAGE_NAME:$BUILD_NUMBER
//         //             '''
//         //         }
//         //     }
//         // }
//         stage('Deploy to Kubernetes via Ansible') {
//           steps {
//         sh '''
//             export KUBECONFIG=/var/lib/jenkins/.kube/config
//             cd ansible/Playbooks
//             ansible-playbook -i localhost, -c local main.yaml
//         '''
//     }
// }

//         stage('Cleanup') {
//             steps {
//                 timeout(time: 2, unit: 'MINUTES') {
//                     sh '''
//                         echo "Cleaning up Docker resources..."
//                         docker system prune -af || true
//                         docker volume prune -f || true
//                     '''
//                 }
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

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test -DskipTests'
            }
        }

        stage('Build Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'cp target/*.war abctechnologies.war'
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: "mahoro01", url: ""]) {
                    sh "docker push $IMAGE_NAME:$BUILD_NUMBER"
                }
            }
        }

        stage('Deploy to Kubernetes via Ansible') {
            steps {
                sh '''
                    export KUBECONFIG=/var/lib/jenkins/.kube/config
                    cd $WORKSPACE/ansible/Playbooks
                    ansible-playbook -i localhost, -c local main.yaml
                '''
            }
        }

        stage('Cleanup') {
            steps {
                sh '''
                    docker system prune -af || true
                    docker volume prune -f || true
                '''
            }
        }
    }
}
