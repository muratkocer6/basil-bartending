pipeline {
HEAD

HEAD
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    ECR_REPO = '182399722085.dkr.ecr.us-east-1.amazonaws.com/basil-backend'
    IMAGE_TAG = "backend-${env.BUILD_NUMBER}"
    CLUSTER = 'basil-backend-cluster'
    SERVICE = 'basil-backend-service'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/muratkocer6/basilbartending.git'
      }

    agent any
    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "182399722085.dkr.ecr.us-east-1.amazonaws.com/basil-backend"
        FRONTEND_BUCKET = "basil-backend-frontend"
        CLOUDFRONT_DIST_ID = "E33QXGF5XGNKB9"
    }
    stages {
        stage('Build Backend') {
            steps {
                sh 'docker build -t $ECR_REPO:latest ./backend'
            }
        }
        stage('Push to ECR') {
            steps {
                sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO'
                sh 'docker push $ECR_REPO:latest'
            }
        }
        stage('Deploy to ECS') {
            steps {
                sh 'aws ecs update-service --cluster basil-backend-cluster --service basil-backend-service --force-new-deployment'
            }
        }
        stage('Sync Frontend') {
            steps {
                sh 'aws s3 sync ./frontend s3://$FRONTEND_BUCKET --delete'
            }
        }
        stage('Invalidate Cache') {
            steps {
                sh 'aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DIST_ID --paths "/*"'
            }
        }
        stage('Health Check') {
            steps {
                sh './healthcheck.sh'
            }
        }
    }
       HEAD

    stage('Login to ECR') {
      steps {
       HEAD
       HEAD
        echo 'Deploying app...'
      HEAD
        sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO'
      }
    }

    stage('Push Image to ECR') {
      steps {
        sh 'docker push $ECR_REPO:$IMAGE_TAG'
      }
    }

    stage('Deploy to ECS') {
      steps {
        sh '''
          aws ecs update-service \
            --cluster $CLUSTER \
            --service $SERVICE \
            --force-new-deployment \
            --region $AWS_REGION
        '''
      }
    }

    stage('Health Check') {
      steps {
        sh '''
          echo "Checking backend health..."
          curl --fail https://api.basilbartending.com/api || echo "❌ Backend failed health check"
        '''
        bc335cb (Update Jenkinsfile for automated ECS deployment)
      }
    }
  }

  agent any
    da52db3 (Update Jenkinsfile)

    9818da0 (Fix Jenkinsfile merge conflict)
  environment {
    IMAGE_NAME = "basil-backend"
    ECR_REPO = "182399722085.dkr.ecr.us-east-1.amazonaws.com/basil-backend"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/muratkocer6/basilbartending.git', branch: 'main'
      }
    }
  HEAD
   (Create Jenkinsfile)

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME .'
      }
    }

    stage('Login to ECR') {
      steps {
        sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPO'
      }
    }

    stage('Push to ECR') {
      steps {
        sh 'docker tag $IMAGE_NAME $ECR_REPO'
        sh 'docker push $ECR_REPO'
      HEAD

        da52db34b40cd10f095a91dfdf5187f4b2dd1727
        9818da0 (Fix Jenkinsfile merge conflict)

        echo '🚀 Deploying to production...'
        // You can add real deployment steps here later
        6db4471 (Fix syntax error in Jenkinsfile)
      }
    }
  }
 da52db3 (Update Jenkinsfile)
         5e48868 (Saving local changes before rebase)
}

