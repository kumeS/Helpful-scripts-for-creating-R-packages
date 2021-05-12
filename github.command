#!/bin/bash

# If your need any proxy setting
# export https_proxy="http://..."
# export ftp_proxy="http://..."

MY_DIRNAME=$(dirname $0)
cd $MY_DIRNAME

cd ./[Your GitHub Directory]

# If you use MacOSX
du -a | grep .DS_Store | xargs rm -rf

git add -A

git commit -m "Your submit comment"
 
git push origin main

git config pull.rebase false

git pull

open "[Your GitHub URL]"

exit
