# deploy.ps1 - Deploy Hugo blog to AWS S3 + CloudFront
# Usage: .\deploy.ps1

$ErrorActionPreference = "Stop"

$S3_BUCKET = "leestechblog"
$CF_DISTRIBUTION_ID = "E24YRPEGAHQC7D"
$AWS_PROFILE = "blog"

Write-Host "Building Hugo site..." -ForegroundColor Cyan
hugo --minify
if ($LASTEXITCODE -ne 0) {
    Write-Host "Hugo build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Syncing to S3 bucket: $S3_BUCKET..." -ForegroundColor Cyan
aws s3 sync public/ "s3://$S3_BUCKET" --profile $AWS_PROFILE --delete
if ($LASTEXITCODE -ne 0) {
    Write-Host "S3 sync failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Invalidating CloudFront cache..." -ForegroundColor Cyan
aws cloudfront create-invalidation --distribution-id $CF_DISTRIBUTION_ID --paths "/*" --profile $AWS_PROFILE
if ($LASTEXITCODE -ne 0) {
    Write-Host "CloudFront invalidation failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Deployment complete!" -ForegroundColor Green
Write-Host "Site URL: https://leestechblog.com" -ForegroundColor Cyan
Write-Host "CloudFront URL: https://d3xxxxxx.cloudfront.net" -ForegroundColor Cyan