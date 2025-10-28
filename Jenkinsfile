pipeline 

{
    agent any 
    stages 
    {
        stage('Code checkout')
        {
            steps 
            {
                git branch: 'main', url: 'https://github.com/Diane-Mahoro1/Industry-Grade-Project-I.git'
            }
        }
        stage('code compile'){
            steps
            {
                sh 'mvn compile'
            }

        }

        stage('Test'){
            steps
            {
                sh 'mvn test'
            }
        }
        stage('build'){
            steps
            {
                sh 'mvn package'
            }
        }

        stage('Build Docker Image'){
            steps{
                // sh 'cp /var/lib/jenkins/workspace/$JOB_NAME/target/abctechnologies.war/var/lib/jenkins/workspace/$JOB_NAME/abctechnologies.war'
                // sh 'docker build -t mahoro01/abc_tech:$BUILD_NUMBER .'
                sh '''
                cp target/ABCtechnlogies-1.0.war abctechnologies.war
                docker build -t mytomcatapp .
                '''
            }

        }
        stage('push Docker Image'){
            steps{
                withDockerRegistry([credentialsId: "dockerhub", url:""])
                {
                    sh 'docker push mahoro01/abc_tech:$BUILD_NUMBER'
                }
            }
        }
        stage('deploy as container'){
            steps{
                sh 'docker run -itd -P mahoro01/abc_tech:$BUILD_NUMBER'
            }
        }
    }
}