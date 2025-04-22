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

    stage('Login to ECR & Push Image') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ecr-creds']]) {
          sh '''
            echo "🔐 Logging in to ECR..."
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

            aws sts get-caller-identity
            aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

            echo "📤 Pushing Docker image..."
            docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
          '''
        }
      }
    }

    stage('Deploy to ECS') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ecr-creds']]) {
          sh './deploy-backend.sh $IMAGE_TAG'
        }
      }
    }

    stage('Upload Frontend and Invalidate Cache') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ecr-creds']]) {
          sh './deploy-frontend.sh'
        }
      }
    }

    stage('Health Check') {
      steps {
        sh './healthcheck.sh'
      }
    }
  }
}

stage('Notify New Relic') {
    script {
      node {
        withCredentials([string(credentialsId: 'newrelic-api-key', variable: 'NEW_RELIC_API_KEY')]) {
          sh '''
            echo 📡 Notifying New Relic Deployment API...
            curl -X POST https://api.newrelic.com/v2/applications/${NEW_RELIC_APP_ID}/deployments.json \
            -H "X-Api-Key:${NEW_RELIC_API_KEY}" \
            -H "Content-Type: application/json" \
            -d '{
                  "deployment": {
                    "revision": "'${GIT_COMMIT}'",
                    "changelog": "Automated deployment via Jenkins",
                    "description": "Backend deployed to ECS",
                    "user": "Jenkins"
                  }
                }'
          '''
        }
      }
    }
}
