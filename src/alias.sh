#!/bin/sh

alias gv='git --version'
alias gi='git init'
alias gcl='git clone'

alias gs='git status'
alias gsv='git status -sb'
alias ga='git add'
alias gA='git add --all'
alias gap='git add -p'

alias gd='git diff'
alias gds='git diff --staged'
alias gdn='git diff --name-only'

alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gcam='git commit --amend'

alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gsw='git switch'
alias gsc='git switch -c'

alias gr='git remote'
alias grv='git remote -v'
alias gp='git push'
alias gl='git pull'
alias glr='git pull --rebase'
alias gf='git fetch'
alias gfa='git fetch --all'

alias glog='git log --oneline'
alias gloga='git log --oneline --graph --all'
alias glast='git log -1'
alias gshow='git show'
alias gbl='git blame'

alias gst='git stash'
alias gstl='git stash list'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gstd='git stash show'

alias grs='git restore'
alias grss='git restore --staged'

alias gm='git merge'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

alias gt='git tag'
alias gtv='git tag -n'

alias gconf='git config --list'
alias gname='git config user.name'
alias gmail='git config user.email'

alias ggrep='git grep'

