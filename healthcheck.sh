#!/bin/bash

echo "✅ Checking Frontend (CloudFront site)..."
curl -sf https://basilbartending.com && echo "✔️ Frontend is up!" || echo "❌ Frontend is down!"

echo "✅ Checking Backend root endpoint..."
curl -sf https://api.basilbartending.com && echo "✔️ Backend is up!" || echo "❌ Backend is down!"

echo "✅ Checking ECS logs for recent activity..."

# Set up AWS CLI config for the script context
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region us-east-1

# Attempt to list logs
aws logs describe-log-groups --limit 1 && echo "✔️ Log access succeeded" || echo "❌ Log access failed"
