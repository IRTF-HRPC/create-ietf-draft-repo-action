#!/bin/bash
DRAFT_NAME=$1
TOKEN_USER=$2
CREATE_REPO_GITHUB_TOKEN=$3
ORG_NAME=$4

echo "Creating new repository ${DRAFT_NAME}"
mkdir "${DRAFT_NAME}"
cp Makefile "${DRAFT_NAME}"/
cd "${DRAFT_NAME}"

# change api url based on whether an org name was provided
if [[ -z "${ORG_NAME}" ]]; then
    repository_prefix="user"
else
    repository_prefix="orgs/${ORG_NAME}"
fi

resp=$(curl -s \
    -u "${TOKEN_USER}:${CREATE_REPO_GITHUB_TOKEN}" \
    -o response.txt \
    -w "%{http_code}" \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/"${repository_prefix}"/repos \
    -d '{"name":"'${DRAFT_NAME}'"}')

if [[ "$resp" != "201" ]]; then
    echo "Response $resp received from GitHub API, please check token permissions."
    exit 1
else
    echo "Repository ${repository_prefix}/${DRAFT_NAME} created."
    git_url=$(cat response.txt | jq -r '.git_url')
    git init
    git remote add origin "$git_url"
    rm response.txt
    sed -i 's/REPLACE_DRAFT_NAME/'"${DRAFT_NAME}"'/g' Makefile
    git config --local user.email "action@github.com"
    git config --local user.name "GitHub Action"
    git add .
    git commit -m "initial commit"
    git push -u origin
    echo "Created new repository ${repository_prefix}/${DRAFT_NAME}"
fi
