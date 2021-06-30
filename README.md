# Create IETF Draft Repo

This Github Action creates a draft IETF repository in the designated author's
personal Github account or Github Organization.

This new repository will include the following features:

* Makefile for generating HTML, XML, and TXT versions of a draft Markdown file
* Github Actions workflow that validates the Markdown draft, generates the
alternate versions, and commits them to the repository
* Github Actions workflow that uploads the XML version of the draft to the IETF
Datatracker and triggers a confirmation email.

## Setting Up This Action

(Note: This reqires a user with admin permissions for the repository.) You'll
need to provide the Github Actions workflow with a Github API Token that has
at a minimum the following permissions:

* repo
* workflow

Create your Github token by logging in as the intended user, going to the user
dropdown, then Settings -> Developer settings -> Personal access tokens.

[Personal access token](images/access_token.png)

Generate the token and save the value.

Now go to the repository's Settings tab, then the Secrets sidebar option. Click
on the New repository secret button. Provide the Github token as a Github
Actions secret with the key `CREATE_REPO_GITHUB_TOKEN`, and the current user as
a secret with the key `CREATE_REPO_GITHUB_USER`.

[Secrets](images/secrets.png)

## How To Create A New Repo

To create a new repository, go to the Actions tab and select Generate new repo
in the sidebar.

[Generate new repo](images/new_repo_workflow.png)

Under the workflow runs section there will be a button labeled Run workflow.
Clicking this brings up several options. The name will be the exact name the
new repo will create, so ensure this doesn't conflict. Add the name of the
Github Organization if this should exist under an organization rather than as
the user's own. And lastly, set the last option to true to create a private
repo.

TODO: add photo

## How To Use Newly Created Repo

The created repo will have two Github Actions workflows initialized upon
creation. The first, generate-from-markdown, runs every time a commit is pushed
to the repository and validates, generates, and commits HTML, XML, and TXT
files from the draft markdown back to the repo.

The second, publish-to-datatracker, takes an confirmation email address as
input, and publishes the current version of the repository's draft to
[IETF Datatracker](https://datatracker.ietf.org/submit/).
