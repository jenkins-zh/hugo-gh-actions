# Hugo Github Action

GitHub Action for building and publishing Hugo-built site.

Inspired by [khanhicetea/gh-actions-hugo-deploy-gh-pages](https://github.com/khanhicetea/gh-actions-hugo-deploy-gh-pages)

## Secrets

- `GIT_DEPLOY_KEY` - *Required* your deploy key which has **Write access**

## Create Deploy Key

1. Generate deploy key `ssh-keygen -t rsa -f hugo -q -N ""`
1. Then go to "Settings > Deploy Keys" of repository
1. Add your public key within "Allow write access" option.
1. Copy your private deploy key to `GIT_DEPLOY_KEY` secret in "Settings > Secrets"

## Environment Variables

- `HUGO_VERSION` : **optional**, default is **0.54.0** - [check all versions here](https://github.com/gohugoio/hugo/releases)

```
name: Deploy to GitHub Pages

on:
  push:
    branches:
    - master

jobs:
  hugo-deploy-gh-pages:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: hugo-deploy-gh-pages
      uses: linuxsuren/surenpi@master
      env:
        GIT_DEPLOY_KEY: ${{ secrets.GIT_DEPLOY_KEY }}
        HUGO_VERSION: "0.53"
        WEBSITE_GIT: "git@github.com:LinuxSuRen/linuxsuren.github.io.git"
        WEBSITE_DIR: "linuxsuren.github.io"
```
