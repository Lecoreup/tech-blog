# How to Update Your Blog

## Adding a New Project Post

### From GitHub.com (quickest)

1. Go to https://github.com/Lecoreup/tech-blog
2. Navigate to `content/posts/`
3. Click **Add file** > **Create new file**
4. In the filename field, type: `my-project-name/index.md`
5. Paste the template below, fill in your content
6. Scroll down and commit directly to `main`
7. Wait ~30 seconds — the site auto-deploys

### From VS Code (with local preview)

1. Create a new post folder:
   ```powershell
   mkdir content/posts/my-project-name
   ```

2. Copy the template:
   ```powershell
   cp project-template.md content/posts/my-project-name/index.md
   ```

3. Edit `content/posts/my-project-name/index.md` in VS Code

4. Preview locally:
   ```powershell
   hugo server -D
   ```
   Open http://localhost:1313 in your browser

5. When happy, set `draft: false` in the front matter

6. Push to GitHub:
   ```powershell
   git add .
   git commit -m "Add new post: my-project-name"
   git push origin main
   ```

7. Auto-deploys in ~30 seconds

---

## Editing an Existing Post

### From GitHub.com
1. Go to https://github.com/Lecoreup/tech-blog
2. Navigate to `content/posts/your-post-name/index.md`
3. Click the pencil icon to edit
4. Make changes, commit to `main`

### From VS Code
1. Open `content/posts/your-post-name/index.md`
2. Make changes
3. Commit and push to `main`

---

## Editing the About Page

Edit `content/about/index.md` — same process as above.

---

## Post Template

Copy this into any new `index.md` file:

```yaml
---
title: "Your Project Title"
subtitle: ""
date: 2026-02-07
lastmod: 2026-02-07
draft: false
author: "Lee Powell"
authorLink: "https://www.linkedin.com/in/-leepowell/"
description: "Brief one-line description."

tags: ["AWS", "add-more-tags"]
categories: ["Projects"]

toc:
  enable: true
  auto: true
code:
  copy: true
  maxShownLines: 50
---

Summary that appears on the homepage.

<!--more-->

## Project Overview

**Goal**: What you were trying to accomplish.

**Services Used**:
- **Service 1** -- What it does
- **Service 2** -- What it does

## Architecture

Describe or diagram the architecture.

## Implementation

What you did step by step.

## What I Learned

Key takeaways.
```

---

## Adding Images to a Post

1. Place images in the same folder as your post:
   ```
   content/posts/my-project-name/
   ├── index.md
   ├── screenshot.png
   └── diagram.png
   ```

2. Reference them in markdown:
   ```markdown
   ![Screenshot description](screenshot.png)
   ```

---

## Quick Reference

| Task | Command |
|------|---------|
| Preview locally | `hugo server -D` |
| Build site | `hugo --minify` |
| Deploy manually | `.\deploy.ps1` |
| Check live site | https://d2va8fpl9a8wq4.cloudfront.net/ |
| View deploy status | https://github.com/Lecoreup/tech-blog/actions |

---

## Tips

- Text above `<!--more-->` becomes the homepage summary
- Set `draft: true` to hide a post while working on it
- Use `tags` to categorize posts (they show up on the Tags page)
- Commit directly to `main` for auto-deploy, or use a branch + PR for review
- Images in the same folder as `index.md` are automatically available
