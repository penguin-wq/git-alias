#!/bin/sh
# git-alias - aliases and helper functions
# https://github.com/penguin-wq/git-alias

# --- BASIC ---
alias gv='git --version'
alias gi='git init'
alias gcl='git clone'

# --- STATUS & STAGING ---
alias gs='git status'
alias gsv='git status -sb'
alias ga='git add'
alias gA='git add --all'
alias gap='git add -p'

# --- DIFF ---
alias gd='git diff'
alias gds='git diff --staged'
alias gdn='git diff --name-only'

# --- COMMIT ---
gc() {
  if [ $# -eq 0 ]; then
    git commit
  else
    git commit -m "$*"
  fi
}
alias gca='git commit --amend --no-edit'
alias gcam='git commit --amend'

# --- BRANCH & SWITCH ---
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gsw='git switch'
alias gsc='git switch -c'
alias gswc='git switch -c'
alias gmain='git checkout main 2>/dev/null || git checkout master'

# --- REMOTE ---
alias gr='git remote'
alias grv='git remote -v'
alias gp='git push'
alias gl='git pull'
alias glr='git pull --rebase'
alias gf='git fetch'
alias gfa='git fetch --all'

# --- LOG & HISTORY ---
alias glog='git log --oneline'
alias gloga='git log --oneline --graph --all'
alias glast='git log -1'
alias gshow='git show'
alias gbl='git blame'

# --- STASH ---
alias gst='git stash'
alias gstl='git stash list'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gstsh='git stash show -p'
alias gstd='git stash drop'

# --- RESTORE & RESET ---
alias grs='git restore'
alias grss='git restore --staged'
alias gundo='git reset --soft HEAD~1'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -fd'

# --- MERGE & REBASE ---
alias gm='git merge'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

# --- TAGS ---
alias gt='git tag'
alias gtv='git tag -n'

# --- CONFIGURATION ---
alias gconf='git config --list'
alias gname='git config user.name'
alias gemail='git config user.email'
alias gmail='gemail'

# --- SEARCH ---
alias ggrep='git grep'
