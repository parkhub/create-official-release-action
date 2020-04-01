#!/bin/bash

echo "Environment Variables"
echo "REPO: ${REPO}"
echo "USERNAME: ${USERNAME}"
echo "TOKEN: ${TOKEN}"

echo "Configuring git"
git config --global url."https://${USERNAME}:${TOKEN}@github.com".insteadOf "https://github.com"
git config --global user.email "devops@parkhub.com"
git config --global user.name "codefresh-parkhub"

echo "Initialize GIT"
git init

echo "Cloning repo ${REPO}"
git clone https://github.com/${REPO}.git 

echo "Adding remote for repo ${REPO}"
git remote add origin https://github.com/${REPO}.git

echo "Checking out Master branch"
git fetch
git checkout origin/master
git checkout -b master

echo "Exporting token for use with release-it"
export GITHUB_TOKEN="${TOKEN}"

echo "Running release-it"
# $1 is the release type major, minor or patch
DEBUG=release-it:* release-it --ci --no-npm

echo "Updating develop from master after release..."
git fetch
git checkout origin/develop
git checkout -b PV-5000_merge-to-develop
git pull origin master 
git push -u origin MERGE-00_merge-to-develop
hub pull-request -h PV-5000_merge-to-develop

pr() {
  git push -u origin MERGE-00_merge-to-develop
  hub pull-request -h MERGE-00_merge-to-develop -F -
}

pr MERGE-00_merge-to-develop <<MSG
Auto Merge from master after release.

This branch should be merged in after a release.
MSG