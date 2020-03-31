#!/bin/bash

git config --global user.email "devops@parkhub.com"
git config --global user.name "codefresh-parkhub"
git remote rm origin
git remote add origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/parkhub/$REPO_NAME.git

# $1 is the release type major, minor or patch
DEBUG=release-it:* release-it --ci --no-npm