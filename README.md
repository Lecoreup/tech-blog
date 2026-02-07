# Lee's Tech Blog

A personal technical blog documenting AWS DevOps engineering projects, built with [Hugo](https://gohugo.io/) and the [LoveIt](https://github.com/dillonzq/LoveIt) theme. Hosted on AWS using S3 and CloudFront.

**Live site**: https://d2va8fpl9a8wq4.cloudfront.net/

## Tech Stack

- **Static Site Generator**: Hugo + LoveIt theme
- **Hosting**: AWS S3 (static website hosting)
- **CDN**: AWS CloudFront
- **SSL**: AWS Certificate Manager
- **Deployment**: AWS CLI

## Prerequisites

- [Hugo](https://gohugo.io/installation/) (extended version, v0.112.0+)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- Git

## Local Development

### Preview the site locally

```bash
hugo server -D
```

Starts a local server at `http://localhost:1313` with live reload. The `-D` flag includes draft posts.

### Build the site

```bash
hugo --minify
```

Generates the static site into the `public/` directory.

## Adding a New Project Post

1. **Create a new post directory**:
   ```bash
   mkdir content/posts/my-new-project
   ```

2. **Copy the template**:
   ```bash
   cp project-template.md content/posts/my-new-project/index.md
   ```

3. **Edit the post** (`content/posts/my-new-project/index.md`):
   - Update the front matter: title, date, description, tags
   - Write your content below the `<!--more-->` marker
   - Text above `<!--more-->` appears as the summary on the homepage

4. **Preview locally**:
   ```bash
   hugo server -D
   ```

5. **When ready to publish**, set `draft: false` in the front matter

6. **Deploy**:
   ```powershell
   .\deploy.ps1
   ```

## Deployment

### Quick Deploy (PowerShell)

```powershell
.\deploy.ps1
```

### Quick Deploy (Bash)

```bash
./deploy.sh
```

### Manual Deploy

```bash
hugo --minify
aws s3 sync public/ s3://leestechblog --delete
aws cloudfront create-invalidation --distribution-id E24YRPEGAHQC7D --paths "/*"
```

## Project Structure

```
tech-blog/
├── archetypes/          # Hugo content templates
│   └── default.md
├── content/
│   ├── about/           # About page
│   │   └── index.md
│   └── posts/           # Blog posts (each in its own directory)
│       └── hosting-a-hugo-blog-on-aws/
│           └── index.md
├── themes/
│   └── LoveIt/          # Hugo theme
├── config.toml          # Site configuration
├── project-template.md  # Template for new project posts
├── deploy.ps1           # Windows deployment script
├── deploy.sh            # Bash deployment script
└── README.md
```

## Configuration

Site configuration is in `config.toml`. Key settings:
- `baseURL`: CloudFront domain (`https://d2va8fpl9a8wq4.cloudfront.net/`)
- `[params.home.profile]`: Homepage title, subtitle, avatar
- `[params.social]`: Social media links
- `[author]`: Author information

## Useful AWS Commands

### Deployment

```bash
# Full sync (use for initial deployment or major changes)
aws s3 sync public/ s3://leestechblog --delete

# Upload single file
aws s3 cp public/index.html s3://leestechblog/index.html
```

### CloudFront Cache Invalidation

```bash
# Invalidate everything (use sparingly - costs money after 1000/month)
aws cloudfront create-invalidation --distribution-id E24YRPEGAHQC7D --paths "/*"

# Invalidate specific paths
aws cloudfront create-invalidation --distribution-id E24YRPEGAHQC7D --paths "/index.html" "/posts/index.html"
```

### Checking Configuration

```bash
# View S3 website configuration
aws s3api get-bucket-website --bucket leestechblog

# List CloudFront distributions
aws cloudfront list-distributions --query 'DistributionList.Items[*].[Id,DomainName,Status]' --output table
```

## Troubleshooting

### Changes not appearing after deployment
Clear CloudFront cache:
```bash
aws cloudfront create-invalidation --distribution-id E24YRPEGAHQC7D --paths "/*"
```

### 403 Forbidden error
Check bucket policy allows public read access:
```bash
aws s3api get-bucket-policy --bucket leestechblog
```

### Images not loading
Verify file paths are relative and files were uploaded:
```bash
aws s3 ls s3://leestechblog/ --recursive
```

### CSS not applying
Hard refresh browser (Ctrl+Shift+R) or check file path in HTML.

### Hugo build errors
Ensure you have Hugo extended version:
```bash
hugo version
```

## Cost

- **S3**: ~$0.023/GB stored + $0.09/GB transferred (first 1GB/month free)
- **CloudFront**: 1TB/month free for 12 months, then ~$0.085/GB
- **Expected monthly cost**: $0-2 for a low-traffic blog

## Tips for Fast Updates

1. **Screenshot as you build** - Don't try to recreate later
2. **Save code snippets immediately** - Copy interesting Lambda functions, policies, etc.
3. **Use the template** - Don't overthink formatting
4. **Batch deployments** - Add 2-3 projects, then deploy once
5. **Keep it simple** - Done is better than perfect

## Resources

- [AWS S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [AWS Architecture Icons](https://aws.amazon.com/architecture/icons/) - For diagrams
- [Hugo Documentation](https://gohugo.io/documentation/)
- [LoveIt Theme Docs](https://hugoloveit.com/)

---

**Last Updated**: 2026-02-07
**Site URL**: https://d2va8fpl9a8wq4.cloudfront.net/
