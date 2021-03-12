# branch-fast-forward

Fast-forward from a `main_branch` to the `ff_branch` to keep the fast-forwarded branch even with the main one.

The merge is `ff-only` so any commit added to `ff_branch` and not `main_branch` will cause the paths to diverge and the merge to fail.

## Example Installation

To enable the action simply create a workflow similar to the one below:

```yml
name: Release FF

on:
  push:
    branches:
    - master

jobs:
  fast-forward:
    runs-on: ubuntu-latest
    steps:
    - name: Fast-Forward Release
      uses: JakobGray/branch-fast-forward@main
      with:
        main_branch: 'master'
        ff_branch: 'release-2.3'
        push_token: 'FF_TOKEN'
      env:
        FF_TOKEN: ${{ secrets.FF_TOKEN }}
```

In this example, every time commits are added to the `master` branch they will also be fast-forwarded to the `release-2.3` branch

## Parameters

### `main_branch`

The name of the primary branch.

### `ff_branch`

The name of the fast-forwarded branch.

### `user_name`

User name for git commits (default `GitHub Actions`).

### `user_email`

User email for git commits (default `actions@github.com`).

### `push_token`

Environment variable containing the token to use for push.
Needed for pushing on protected branches.
Using a secret to store this variable value is strongly recommended, since this
value will be printed in the logs.

```yml
      with:
        push_token: 'FOO_TOKEN'
      env:
        FOO_TOKEN: ${{ secrets.FOO_TOKEN }}
```