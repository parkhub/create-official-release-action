#!/bin/bash

# Merge master into develop
git fetch
git checkout origin/develop 
git branch -D develop
git checkout -b develop
git pull origin master 
git push origin develop

# Merge develop into qa
git fetch
git checkout origin/qa 
git branch -D qa
git checkout -b qa
git pull origin develop 
git push origin qa

# Merge qa into staging
git fetch
git checkout origin/staging 
git branch -D staging
git checkout -b staging
git pull origin qa 
git push origin staging