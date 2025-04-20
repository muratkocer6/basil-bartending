#!/bin/bash

set -e  # exit on any error

echo "🔄 Syncing ./frontend to S3 bucket s3://basil-backend-frontend ..."
aws s3 sync ./frontend s3://basil-backend-frontend --delete

echo "🚀 Invalidating CloudFront distribution cache..."
aws cloudfront create-invalidation \
  --distribution-id YOUR_CLOUDFRONT_DIST_ID \
  --paths "/*"

echo "✅ Frontend deployed and cache invalidated."
