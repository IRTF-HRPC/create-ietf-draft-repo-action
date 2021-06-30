# REPLACE_DRAFT_NAME

## Building the draft

### Committing To `main` Directly

Commit a new repo to the `main` branch of the repository. A new workflow should
begin to run under Actions, check that the validate workflow has succeeded.

If the workflow has succeeded, new versions of the draft will be updated
automatically.

### Opening A PR
After committing changes to a new branch, open a Pull Request against the
repository. A new workflow should run under Actions, check that the validate
workflow has succeeded.

If the workflow has succeeded, request reviewers if necessary, and merge to
`main` when ready. New versions of the draft will be updated automatically.
