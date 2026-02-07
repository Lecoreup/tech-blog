# AWS Blog Project - Development Skills

## Project Context
Building a personal technical blog hosted entirely on AWS to showcase AWS certification projects and automation work. The blog should be simple, cost-effective, and easy to update with new project write-ups.

## Current State
- Static website files exist in S3 bucket (not yet deployed)
- Need to integrate/check existing files
- Goal: Minimal viable blog that's quick to update

## Technical Stack
- **Hosting**: AWS S3 (static site hosting) + CloudFront (CDN)
- **Domain**: Route 53 (if using custom domain)
- **SSL**: AWS Certificate Manager
- **Deployment**: AWS CLI / S3 sync commands
- **Content**: Markdown → HTML (simple static generator or plain HTML)

## Architecture Principles
1. **Serverless-first**: Use managed services to minimize operational overhead
2. **Cost-optimized**: Stay within free tier where possible
3. **Simple**: Avoid over-engineering; plain HTML/CSS is fine
4. **Version controlled**: All content in Git

## Key Requirements

### Blog Features (MVP)
- Homepage listing all projects
- Individual project pages following standard template
- Simple navigation
- Responsive design (mobile-friendly)
- Fast loading times

### AWS Integration
- S3 bucket configured for static website hosting
- CloudFront distribution for HTTPS and performance
- Proper IAM permissions for deployment
- (Optional) Route 53 for custom domain

### Content Structure
```
/
├── index.html (homepage - project list)
├── about.html (brief bio, certifications)
├── projects/
│   ├── project-1.html
│   ├── project-2.html
│   └── ...
├── assets/
│   ├── css/
│   ├── js/
│   └── images/
└── diagrams/
```

### Deployment Workflow
1. Update content locally
2. Preview locally (simple HTTP server)
3. Sync to S3: `aws s3 sync . s3://leestechblog --delete`
4. Invalidate CloudFront cache if needed

## Code Style Guidelines
- Clean, semantic HTML5
- Minimal CSS (consider using a lightweight framework like Pico.css or Water.css)
- No JavaScript unless necessary
- Comments explaining AWS-specific configurations

## Security Considerations
- S3 bucket policies: public read access only for website content
- CloudFront OAI (Origin Access Identity) for secure S3 access
- No sensitive information in code or content

## Testing Checklist
- [ ] All links work
- [ ] Images load correctly
- [ ] Responsive on mobile
- [ ] HTTPS working
- [ ] Fast page load (<2s)
- [ ] Proper meta tags for SEO

## Documentation Standards
- Each project page uses the standard template
- Architecture diagrams stored as source files (draw.io XML)
- Code samples syntax-highlighted
- External links open in new tabs
- Proper attribution for any third-party resources

## Common AWS Commands
```bash
# Sync local files to S3
aws s3 sync . s3://leestechblog --exclude ".git/*" --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation --distribution-id E24YRPEGAHQC7D --paths "/*"

# Check S3 website configuration
aws s3api get-bucket-website --bucket leestechblog
```

## Success Criteria
- Blog deploys successfully to AWS
- New projects can be added in <30 minutes
- Total monthly cost under $2 (or free tier)
- Professional appearance suitable for job applications
- Easy to maintain without constant Claude Code assistance