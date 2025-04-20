pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = '182399722085.dkr.ecr.us-east-1.amazonaws.com/basil-backend'
        IMAGE_TAG = "backend-${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/muratkocer6/basil-bartending.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $ECR_REPO:$IMAGE_TAG ./backend"
            }
        }

        stage('Login to ECR') {
            steps {
                sh "aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO"
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh "docker push $ECR_REPO:$IMAGE_TAG"
            }
        }

        stage('Deploy to ECS') {
            steps {
                sh "./deploy-backend.sh $IMAGE_TAG"
            }
        }

        stage('Upload Frontend and Invalidate Cache') {
            steps {
                sh "./deploy-frontend.sh"
            }
        }

        stage('Health Check') {
            steps {
                sh "./healthcheck.sh"
            }
        }
    }
}
