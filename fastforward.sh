#!/bin/bash

set -e

echo
echo "  'Branch Fast-Forward' is using the following input:"
echo "    - main_branch = '$INPUT_MAIN_BRANCH'"
echo "    - ff_branch = '$INPUT_FF_BRANCH'"
echo "    - user_name = $INPUT_USER_NAME"
echo "    - user_email = $INPUT_USER_EMAIL"
echo "    - push_token = $INPUT_PUSH_TOKEN"
echo

if [[ -z "${!INPUT_PUSH_TOKEN}" ]]; then
  echo "Set the ${INPUT_PUSH_TOKEN} env variable."
  exit 1
fi

git config --global user.name "$INPUT_USER_NAME"
git config --global user.email "$INPUT_USER_EMAIL"

REPO_URL="https://${!INPUT_PUSH_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git clone -b ${INPUT_MAIN_BRANCH} "${REPO_URL}" repo-copy
cd repo-copy
if ! git checkout -b ${INPUT_FF_BRANCH} origin/${INPUT_FF_BRANCH}
then
  echo "Release branch does not exist. Creating new branch."
  git checkout -b ${INPUT_FF_BRANCH}
  git push origin ${INPUT_FF_BRANCH}
else
  git merge --ff-only ${INPUT_MAIN_BRANCH}
  git push
fi
