#!/bin/bash
DRAFT_NAME=$1
CREATE_REPO_GITHUB_USER=$2
CREATE_REPO_GITHUB_TOKEN=$3
ORG_NAME=$4
PRIVATE_REPO=$5

echo "Creating new repository ${DRAFT_NAME}"
mkdir "${DRAFT_NAME}"
cp repo/* "${DRAFT_NAME}"/
mkdir -p "${DRAFT_NAME}"/.github
cp -r workflows/ "${DRAFT_NAME}"/.github/
cd "${DRAFT_NAME}"

# change api url based on whether an org name was provided
if [[ -z "${ORG_NAME}" ]]; then
    repository_prefix="user"
    OWNER_NAME=$CREATE_REPO_GITHUB_USER
else
    repository_prefix="orgs/${ORG_NAME}"
    OWNER_NAME=$ORG_NAME
fi

# set private repo to true in json blob if needed
private_repo_data_blob=''
if [[ "${PRIVATE_REPO}" == "true" ]]; then
    private_repo_data_blob=',"private":"true"'
fi

resp=$(curl -s \
    -u "${CREATE_REPO_GITHUB_USER}:${CREATE_REPO_GITHUB_TOKEN}" \
    -o response.txt \
    -w "%{http_code}" \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/"${repository_prefix}"/repos \
    -d '{"name":"'${DRAFT_NAME}'"'${private_repo_data_blob}'}')

if [[ "$resp" != "201" ]]; then
    echo "Response $resp received from GitHub API, please check token permissions."
    exit 1
else
    rm response.txt
    echo "Response $resp received from GitHub API."
    echo "Repository ${repository_prefix}/${DRAFT_NAME} created."
    git_url="https://${CREATE_REPO_GITHUB_USER}:${CREATE_REPO_GITHUB_TOKEN}@github.com/${OWNER_NAME}/${DRAFT_NAME}.git"
    git init
    sed -i 's/REPLACE_DRAFT_NAME/'"${DRAFT_NAME}"'/g' Makefile README.md draft-x.md
    mv draft-x.md draft-"${DRAFT_NAME}".md
    git config --local user.email "action@github.com"
    git config --local user.name "GitHub Action"
    git add . .github/
    git commit -m "initial commit"
    git branch -M main
    git remote add origin "$git_url"
    git push --set-upstream origin main
    echo "Created new repository ${repository_prefix}/${DRAFT_NAME}"
fi
