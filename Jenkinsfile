pipeline {

HEAD
  agent any

  stages {
    stage('Build') {
      steps {
        echo '🔨 Building the application...'
      }
    }

    stage('Test') {
      steps {
        echo '🧪 Running tests...'
      }
    }

    stage('Deploy') {
      steps {
       HEAD
        echo 'Deploying app...'
      HEAD
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
}
