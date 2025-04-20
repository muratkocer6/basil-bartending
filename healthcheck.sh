#!/bin/bash

echo "✅ Checking Frontend (CloudFront site)..."
curl -sSf https://basilbartending.com > /dev/null && echo "✔️ Frontend is up!" || echo "❌ Frontend is down!"

echo "✅ Checking Backend root endpoint..."
curl -sSf https://api.basilbartending.com > /dev/null && echo "✔️ Backend is up!" || echo "❌ Backend is down!"

echo "✅ Checking ECS logs for recent activity..."
# Inject credentials if not already exported
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  export AWS_ACCESS_KEY_ID=your_access_key
  export AWS_SECRET_ACCESS_KEY=your_secret_key
  export AWS_DEFAULT_REGION=us-east-1
fi

# Now check logs
aws logs describe-log-groups --region us-east-1 >/dev/null && echo "✔️ AWS CLI can access logs." || echo "❌ Cannot access logs."
