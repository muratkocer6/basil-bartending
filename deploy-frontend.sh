#!/bin/bash

# --- CONFIGURATION ---
S3_BUCKET="basil-backend-frontend"
CLOUDFRONT_DISTRIBUTION_ID="E33QXGF5XGNKB9"
FRONTEND_DIR="./frontend"

# --- DEPLOY ---
echo "🔄 Syncing $FRONTEND_DIR to S3 bucket s3://$S3_BUCKET ..."
aws s3 sync "$FRONTEND_DIR" "s3://$S3_BUCKET" --delete

echo "🚀 Invalidating CloudFront distribution cache..."
aws cloudfront create-invalidation \
  --distribution-id "$CLOUDFRONT_DISTRIBUTION_ID" \
  --paths "/*"

stage('Deploy Frontend') {
  steps {
    sh './deploy-frontend.sh'
  }
}

echo "✅ Deployment complete!"
