#!/bin/bash
# deploy.sh - Deploy Hugo blog to AWS S3 + CloudFront
# Usage: ./deploy.sh

set -euo pipefail

S3_BUCKET="leestechblog"
CF_DISTRIBUTION_ID="E24YRPEGAHQC7D"

echo "Building Hugo site..."
hugo --minify

echo "Syncing to S3 bucket: $S3_BUCKET..."
aws s3 sync public/ "s3://$S3_BUCKET" --delete

echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
    --distribution-id "$CF_DISTRIBUTION_ID" \
    --paths "/*"

echo "Deployment complete!"
