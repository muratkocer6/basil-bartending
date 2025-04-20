pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    ECR_REGISTRY = '182399722085.dkr.ecr.us-east-1.amazonaws.com'
    ECR_REPOSITORY = 'basil-backend'
    IMAGE_TAG = "backend-${BUILD_NUMBER}"
  }

  stages {
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG ./backend'
      }
    }

  stage('Login to ECR') {
    steps {
      withCredentials([usernamePassword(credentialsId: 'aws-ecr-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        sh '''
          export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
          export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
          aws --version
          aws sts get-caller-identity
          aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 182399722085.dkr.ecr.us-east-1.amazonaws.com
        '''
      }
    }
  }

    stage('Push Image to ECR') {
      steps {
        sh 'docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG'
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
