#!/bin/bash

# Checkout master because we cant assume the build step has checked out the correct branch.
git fetch
git checkout origin/master
git branch -D master 
git checkout -b master