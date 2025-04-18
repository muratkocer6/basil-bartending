#!/bin/bash

set -e

echo "✅ Checking Frontend (CloudFront site)..."
curl -sSf https://basilbartending.com | grep -q "<title>" && echo "✔️ Frontend is up!" || echo "❌ Frontend check failed"

echo "✅ Checking Backend root endpoint..."
curl -m 5 -sSf https://api.basilbartending.com/ | grep -q "Welcome" && echo "✔️ Backend is up!" || echo "❌ Backend check failed"

echo "✅ Checking ECS logs for recent activity..."
aws logs tail /ecs/basil-backend --since 10m

echo "✅ Checking CloudFront invalidation status..."
aws cloudfront list-invalidations --distribution-id E33QXGF5XGNKB9 | grep -A 2 '"Invalidation"' | head -n 5

echo "✅ Checking Target Group Health..."
aws elbv2 describe-target-health \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:182399722085:targetgroup/basil-backend-tg/a31640c5963a9e07 \
  --query "TargetHealthDescriptions[*].TargetHealth.State" \
  --output text
