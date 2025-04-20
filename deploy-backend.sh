#!/bin/bash

# This script is triggered by Jenkins and receives the image tag as an argument
IMAGE_TAG=$1

# ECR image path (update if needed)
ECR_IMAGE="182399722085.dkr.ecr.us-east-1.amazonaws.com/basil-backend:$IMAGE_TAG"

# Update the ECS service with the new image (customize cluster/service names if needed)
aws ecs update-service \
  --cluster basil-cluster \
  --service basil-backend-service \
  --force-new-deployment \
  --region us-east-1

# Optional: log the image that was deployed
echo "✅ ECS deployment triggered using image: $ECR_IMAGE"
