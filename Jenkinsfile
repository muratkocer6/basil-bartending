pipeline {
HEAD
  agent any

  stages {
    stage('Build') {
      steps {
        echo 'Building the app...'
      }
    }

    stage('Test') {
      steps {
        echo 'Running tests...'
      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploying app...'
      }
    }
  }

    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t basil-backend .'
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
                docker tag basil-backend:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/basil-backend:latest
                docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/basil-backend:latest
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                '''
            }
        }
    }
 63184ef (Create Jenkinsfile)
}
