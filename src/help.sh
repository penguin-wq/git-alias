#!/bin/sh

ghelp() {
    cat <<'EOF'
----------------------------------------
Git Commands
----------------------------------------

BASIC
  gv    - git --version
  gi    - git init
  gcl   - git clone

STATUS & STAGING
  gs    - git status
  gsv   - git status -sb
  ga    - git add
  gA    - git add --all
  gap   - git add -p

DIFF
  gd    - git diff
  gds   - git diff --staged
  gdn   - git diff --name-only

COMMIT
  gc    - git commit -m
  gca   - git commit --amend --no-edit
  gcam  - git commit --amend

BRANCH
  gb    - git branch
  gba   - git branch -a
  gco   - git checkout
  gsw   - git switch
  gsc   - git switch -c

REMOTE
  gr    - git remote
  grv   - git remote -v
  gp    - git push
  gl    - git pull
  glr   - git pull --rebase
  gf    - git fetch
  gfa   - git fetch --all

LOG & HISTORY
  glog  - git log --oneline
  gloga - git log --oneline --graph --all
  glast - git log -1
  gshow - git show
  gbl   - git blame

STASH
  gst   - git stash
  gstl  - git stash list
  gsta  - git stash apply
  gstp  - git stash pop
  gstd  - git stash show

RESTORE
  grs   - git restore
  grss  - git restore --staged

MERGE & REBASE
  gm    - git merge
  grb   - git rebase
  grbc  - git rebase --continue
  grba  - git rebase --abort

TAGS
  gt    - git tag
  gtv   - git tag -n

CONFIGURATION
  gconf - git config --list
  gname - git config user.name
  gmail - git config user.email

SEARCH
  ggrep - git grep

----------------------------------------
  ghelp - display Git commands
----------------------------------------
EOF
}

