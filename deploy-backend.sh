#!/bin/bash

set -e

IMAGE_TAG=$1
CLUSTER_NAME="basil-cluster"
SERVICE_NAME="basil-backend-service"
CONTAINER_NAME="basil-backend"
REPOSITORY_URI="182399722085.dkr.ecr.us-east-1.amazonaws.com/basil-backend"

echo "🛠 Updating ECS service with image: $REPOSITORY_URI:$IMAGE_TAG"

# Register new task definition with updated image
TASK_DEFINITION=$(aws ecs describe-task-definition --task-definition $SERVICE_NAME)
NEW_TASK_DEF=$(echo $TASK_DEFINITION | jq --arg IMAGE "$REPOSITORY_URI:$IMAGE_TAG" \
  '.taskDefinition | .containerDefinitions[0].image = $IMAGE | {family: .family, containerDefinitions: [.containerDefinitions[0]]}')

aws ecs register-task-definition \
  --cli-input-json "$(echo $NEW_TASK_DEF)"

# Get the new revision number
NEW_REVISION=$(aws ecs describe-task-definition --task-definition $SERVICE_NAME | jq -r '.taskDefinition.revision')

# Update ECS service to use the new task revision
aws ecs update-service \
  --cluster $CLUSTER_NAME \
  --service $SERVICE_NAME \
  --task-definition "$SERVICE_NAME:$NEW_REVISION"

echo "✅ ECS service updated to image: $IMAGE_TAG"
