#!/bin/sh
# git-alias - shell completion integration for zsh and bash
# https://github.com/penguin-wq/git-alias

# Zsh completion wiring
if [ -n "$ZSH_VERSION" ] && type compdef >/dev/null 2>&1; then
  compdef _git gv=git-version
  compdef _git gi=git-init
  compdef _git gcl=git-clone
  compdef _git gs=git-status
  compdef _git gsv=git-status
  compdef _git ga=git-add
  compdef _git gA=git-add
  compdef _git gap=git-add
  compdef _git gd=git-diff
  compdef _git gds=git-diff
  compdef _git gdn=git-diff
  compdef _git gc=git-commit
  compdef _git gca=git-commit
  compdef _git gcam=git-commit
  compdef _git gb=git-branch
  compdef _git gba=git-branch
  compdef _git gco=git-checkout
  compdef _git gsw=git-switch
  compdef _git gsc=git-switch
  compdef _git gswc=git-switch
  compdef _git gmain=git-checkout
  compdef _git gr=git-remote
  compdef _git grv=git-remote
  compdef _git gp=git-push
  compdef _git gl=git-pull
  compdef _git glr=git-pull
  compdef _git gf=git-fetch
  compdef _git gfa=git-fetch
  compdef _git glog=git-log
  compdef _git gloga=git-log
  compdef _git glast=git-log
  compdef _git gshow=git-show
  compdef _git gbl=git-blame
  compdef _git gst=git-stash
  compdef _git gstl=git-stash
  compdef _git gsta=git-stash
  compdef _git gstp=git-stash
  compdef _git gstsh=git-stash
  compdef _git gstd=git-stash
  compdef _git grs=git-restore
  compdef _git grss=git-restore
  compdef _git gm=git-merge
  compdef _git grb=git-rebase
  compdef _git grbc=git-rebase
  compdef _git grba=git-rebase
  compdef _git gt=git-tag
  compdef _git gtv=git-tag
  compdef _git gconf=git-config
  compdef _git gname=git-config
  compdef _git gemail=git-config
  compdef _git gmail=git-config
  compdef _git ggrep=git-grep
fi

# Bash completion wiring
if [ -n "$BASH_VERSION" ] && type __git_complete >/dev/null 2>&1; then
  __git_complete gco _git_checkout
  __git_complete gb _git_branch
  __git_complete gba _git_branch
  __git_complete gsw _git_switch
  __git_complete gsc _git_switch
  __git_complete gswc _git_switch
  __git_complete gmain _git_checkout
  __git_complete ga _git_add
  __git_complete gap _git_add
  __git_complete gd _git_diff
  __git_complete gds _git_diff
  __git_complete gc _git_commit
  __git_complete gca _git_commit
  __git_complete gcam _git_commit
  __git_complete gp _git_push
  __git_complete gl _git_pull
  __git_complete glr _git_pull
  __git_complete gf _git_fetch
  __git_complete gfa _git_fetch
  __git_complete gm _git_merge
  __git_complete grb _git_rebase
  __git_complete grbc _git_rebase
  __git_complete grba _git_rebase
  __git_complete gst _git_stash
  __git_complete gstl _git_stash
  __git_complete gsta _git_stash
  __git_complete gstp _git_stash
  __git_complete gstsh _git_stash
  __git_complete gstd _git_stash
  __git_complete grs _git_restore
  __git_complete grss _git_restore
  __git_complete gt _git_tag
  __git_complete glog _git_log
  __git_complete gloga _git_log
  __git_complete gshow _git_show
fi
