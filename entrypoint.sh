#!/bin/sh
echo '=================== Install Hugo ==================='
DOWNLOAD_HUGO_VERSION=${HUGO_VERSION:-0.54.0}
echo "Installing Hugo $DOWNLOAD_HUGO_VERSION"
wget -O /tmp/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${DOWNLOAD_HUGO_VERSION}/hugo_extended_${DOWNLOAD_HUGO_VERSION}_Linux-64bit.tar.gz &&\
tar -zxf /tmp/hugo.tar.gz -C /tmp &&\
mv /tmp/hugo /usr/local/bin/hugo &&\
rm /tmp/*

echo '=================== Create deploy key to push ==================='
mkdir /root/.ssh
ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts && \
echo "${GIT_DEPLOY_KEY}" > /root/.ssh/id_rsa && \
chmod 400 /root/.ssh/id_rsa

echo '=================== Clone website ==================='
git clone ${WEBSITE_GIT}

echo '=================== Build site ==================='
hugo
ls -hal
echo '=================== Publish to GitHub Pages ==================='
mkdir -p ${WEBSITE_DIR}
cp -R public/* ${WEBSITE_DIR}
cd ${WEBSITE_DIR} && \
git config user.name "rick" && \
git config user.email "361981269@qq.com" && \
git log -3 && \
git add . && \
pwd && \
git remote -vv && \
echo -n 'Files to Commit:' && ls -l | wc -l && \
timestamp=$(date +%s%3N) && \
git commit -m "Automated deployment to GitHub Pages on $timestamp" && \
git status && \
git push origin master --force
echo '=================== Done  ==================='
