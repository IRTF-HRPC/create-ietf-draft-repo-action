# Create IETF Draft Repo

This Github Action creates a draft IETF repository in the designated author's
personal Github account or Github Organization.

This new repository will include the following features:

* Makefile for generating HTML, XML, and TXT versions of a draft Markdown file
* Github Actions workflow that validates the Markdown draft, generates the
alternate versions, and commits them to the repository
* Github Actions workflow that uploads the XML version of the draft to the IETF
Datatracker and triggers a confirmation email.

## How To Create A New Repo

You'll need to provide the Github Actions workflow with a Github API Token that
has the following permissions:

* Create Repo
TODO: add photo

(Note: This reqires a user with admin permissions for the repository.) Enter
the token as a Github Actions secret with the key `CREATE_REPO_GITHUB_TOKEN`.
TODO: add photo

Provide the workflow with the name of the new repository, and click Run.

## How To Use Newly Created Repo

The created repo will have two Github Actions workflows initialized upon
creation. The first, generate-from-markdown, runs every time a commit is pushed
to the repository and validates, generates, and commits HTML, XML, and TXT
files from the draft markdown back to the repo.

TODO: add photo

The second, publish-to-datatracker, takes an confirmation email address as
input, and publishes the current version of the repository's draft to
[IETF Datatracker](https://datatracker.ietf.org/submit/).
