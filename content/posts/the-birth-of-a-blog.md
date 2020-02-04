---
title: "The birth of a blog"
date: 2020-02-03T14:59:18Z
showDate: true
draft: false
tags: ["hugo","web"]
---

# Introduction

This post is about how I set up this site!

# Framework

So I wanted a static site generator. You know, the trendy, 'lightning fast' modern-web-has-gone-full-circle technology.
Because I just want to write some text that people can read, and I can execute a build step without hurting myself.

> Perfect is the enemy of good

Knowing I'm the kind of person who often lets perfect get the better of me, I didn't want to get stuck at step one _this_ time.

I took the top three static site frameworks from [stackshare](https://stackshare.io/static-site-generators): Jekyll, Gatsby, Hugo.
And whittled them down through opinionated first-impressions and prejudices:

1. [Gatsby](https://www.gatsbyjs.org/) is react-based and seemed to be peddling [JAMstack](https://jamstack.org/) 'webapp'.
This sounded a lot like 'javascript bloat' for a blog use-case.
2. I'd used [Jekyll](https://jekyllrb.com/) once before, and for my chosen theme I had to commit some file dump and modify the theme files directly.
Maybe this isn't always the case, but my experience scarred me. No theme updates?
3. [Hugo](https://gohugo.io/) is like Jekyll, but _new_, and Go 🥰

# Setup

Being on mac, installing Hugo with [homebrew](https://brew.sh/) is breezy:

```bash
brew install hugo
```

And following their [quick-start](https://gohugo.io/getting-started/quick-start/) was straightforward enough.

After my Jekyll experience I was delighted to find themes are tracked as git submodules. Theme are swappable and updates are easy! 🙌

# Deployment

## Netlify misfire

I had assumed I'd host for free with [netlify](https://www.netlify.com/), another trendy platform where Hugo is a first-class citizen.

But after linking to my GitHub repo and configuring the build command I was greeted with:

```
Transformation failed: POSTCSS: failed to transform “css/main.css” (text/css): PostCSS not found; install with “npm install postcss-cli”. See https://gohugo.io/hugo-pipes/postcss/ 2
```

It turns out my chosen theme ([Call me Sam](https://themes.gohugo.io/hugo-theme-sam/) - what a narcissist!) depended on the PostCSS 'Hugo Pipe',
which meant I [needed some npm packages](https://gohugo.io/hugo-pipes/postcss/) installed globally.

Whilst I could fix my local build like this easily enough, it was less obvious where to do this with Netlify.
Was node preinstalled? Can I execute multiple build commands?

## If you want a job done right...

I decided to take control of the build pipeline myself. Who knows what future dependencies I might want.
If I was going to have to learn some platform-specific toml configuration, I'd rather do it with something where I knew I wouldn't hit a brick wall.

So I built the site in a [circleci](https://circleci.com/) pipeline and deployed to GitHub pages. I like circleci because you can use docker images for each job, unlike e.g. travis, which can save some time installing dependencies.

After following some [instructions](https://circleci.com/blog/deploying-documentation-to-github-pages-with-continuous-integration/) the circleci job pushing to GitHub pages announced:

```
ERROR: The key you are authenticating with has been marked as read only.
```

Well, actually I just hadn't followed the 'Provisioning a deploy key' instructions.
Once I created a new key and gave the public part to GitHub and the private to circleci I was in business!

You can see the pipeline config [here](https://github.com/briggySmalls/blog/blob/a5c9745a1134491a0369aee7bf43883e8b045b3d/.circleci/config.yml) in all its glory.

# Conclusion

And there we have it! A Hugo site, built on circleci, deployed on GitHub pages. The internet has yet another blog.
