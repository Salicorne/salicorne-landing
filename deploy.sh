#!/bin/bash
set -e

# Usage: ./deploy.sh "Optional commit message"

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

hugo -t hugo-cards

msg="Rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

cd public 
git add .
git commit -m "$msg"
git push

cd ..
git add .
git commit -m "$msg"
git push
