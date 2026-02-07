---
title: "Hosting a Hugo Blog on AWS with S3 and CloudFront"
subtitle: "Building a serverless static site with HTTPS delivery"
date: 2026-02-07
lastmod: 2026-02-07
draft: false
author: "Lee Powell"
authorLink: "https://www.linkedin.com/in/-leepowell"
description: "How I built and deployed this technical blog using Hugo, AWS S3 for storage, and CloudFront for CDN delivery with HTTPS."

tags: ["AWS", "S3", "CloudFront", "Hugo", "Static Site"]
categories: ["Projects"]

hiddenFromHomePage: false
hiddenFromSearch: false

toc:
  enable: true
  auto: true
code:
  copy: true
  maxShownLines: 50
---

A walkthrough of how I set up this blog using Hugo and deployed it to AWS using S3 and CloudFront.

<!--more-->

## Project Overview

**Goal**: Host a personal technical blog on AWS using only serverless/managed services, keeping costs near zero while achieving fast global delivery over HTTPS.

**Services Used**:
- **Amazon S3** -- Static file storage and origin for the website
- **Amazon CloudFront** -- CDN for HTTPS termination and global edge caching
- **Hugo** -- Static site generator with the LoveIt theme
- **AWS CLI** -- Deployment automation

## Architecture

```text
[Local Machine] --> hugo build --> [public/ folder]
                                        |
                                   aws s3 sync
                                        |
                                   [S3 Bucket: leestechblog]
                                        |
                                   [CloudFront Distribution]
                                        |
                                   [End Users via HTTPS]
```

## Implementation

### Setting Up Hugo

I chose Hugo as my static site generator because it's fast, has no runtime dependencies, and the LoveIt theme provides a professional look out of the box with features like dark mode, table of contents, and code highlighting.

The basic workflow is:
1. Write content in Markdown files under `content/posts/`
2. Run `hugo server` to preview locally
3. Run `hugo --minify` to build the production site into `public/`

### S3 Static Website Hosting

I created an S3 bucket with static website hosting enabled:

```bash
aws s3 website s3://leestechblog --index-document index.html --error-document error.html
```

Then applied a public read bucket policy so CloudFront (and anyone) can access the files:

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::leestechblog/*"
  }]
}
```

### CloudFront Distribution

I set up a CloudFront distribution to provide:
- **HTTPS** -- S3 website endpoints only support HTTP, so CloudFront adds SSL/TLS
- **Edge caching** -- Content cached at AWS edge locations worldwide for faster delivery
- **Cache invalidation** -- After each deployment, I invalidate the cache to serve fresh content

The key configuration decision was using the S3 **website endpoint** (`leestechblog.s3-website-eu-west-1.amazonaws.com`) as the origin rather than the S3 REST API endpoint. This is important because the website endpoint automatically resolves directory URLs (like `/about/`) to `index.html`, which Hugo's URL structure requires.

### Deployment Script

I created a simple PowerShell script that handles the full deployment:

```powershell
hugo --minify
aws s3 sync public/ s3://leestechblog --delete
aws cloudfront create-invalidation --distribution-id E24YRPEGAHQC7D --paths "/*"
```

## What I Learned

- **S3 website endpoints vs REST endpoints**: The website endpoint handles directory index resolution, trailing slashes, and custom error pages. The REST endpoint doesn't. When using CloudFront, this choice matters for how URLs resolve.
- **CloudFront cache invalidation**: The first 1,000 invalidation paths per month are free. Using `/*` counts as one path and invalidates everything.
- **Hugo's `baseURL`**: Setting this to `/` generates relative URLs that work regardless of the domain, which is useful when the final CloudFront URL isn't known during development.

## Cost Breakdown

| Service | Estimated Monthly Cost |
|---------|----------------------|
| S3 Storage | ~$0.02 (small static files) |
| S3 Requests | ~$0.01 |
| CloudFront | Free tier covers 1TB/month |
| **Total** | **< $0.05/month** |

## Next Steps

- Add more project write-ups documenting AWS certification work
- Set up a CI/CD pipeline with GitHub Actions for automated deployments
- Consider adding a custom domain with Route 53 and ACM
