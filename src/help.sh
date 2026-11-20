#!/bin/sh
# git-alias - interactive help system
# https://github.com/penguin-wq/git-alias

ghelp() {
  # Color detection: enable only if stdout is a TTY and NO_COLOR is not set
  _BOLD=""
  _CYAN=""
  _GREEN=""
  _DIM=""
  _RESET=""

  if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    _BOLD=$(printf '\033[1m')
    _CYAN=$(printf '\033[1;36m')
    _GREEN=$(printf '\033[1;32m')
    _DIM=$(printf '\033[2m')
    _RESET=$(printf '\033[0m')
  fi

  _category=$(echo "${1:-}" | tr '[:upper:]' '[:lower:]')

  _print_category() {
    _cat_name="$1"
    shift
    printf "%s%s%s\n" "$_CYAN" "$_cat_name" "$_RESET"
    while [ $# -ge 2 ]; do
      _alias="$1"
      _desc="$2"
      shift 2
      printf "  %s%-6s%s %s-%s %s\n" "$_GREEN" "$_alias" "$_RESET" "$_DIM" "$_RESET" "$_desc"
    done
    printf "\n"
  }

  case "$_category" in
    ""|"all")
      printf "%s----------------------------------------%s\n" "$_DIM" "$_RESET"
      printf "%sGit Workflow Shortcuts (git-alias)%s\n" "$_BOLD" "$_RESET"
      printf "%s----------------------------------------%s\n\n" "$_DIM" "$_RESET"

      _print_category "BASIC" \
        gv "git --version" \
        gi "git init" \
        gcl "git clone"

      _print_category "STATUS & STAGING" \
        gs "git status" \
        gsv "git status -sb" \
        ga "git add" \
        gA "git add --all" \
        gap "git add -p"

      _print_category "DIFF" \
        gd "git diff" \
        gds "git diff --staged" \
        gdn "git diff --name-only"

      _print_category "COMMIT" \
        gc "smart commit (opens editor if empty, or git commit -m '<msg>')" \
        gca "git commit --amend --no-edit" \
        gcam "git commit --amend"

      _print_category "BRANCH & SWITCH" \
        gb "git branch" \
        gba "git branch -a" \
        gco "git checkout" \
        gsw "git switch" \
        gsc "git switch -c" \
        gswc "git switch -c" \
        gmain "switch to main/master branch"

      _print_category "REMOTE" \
        gr "git remote" \
        grv "git remote -v" \
        gp "git push" \
        gl "git pull" \
        glr "git pull --rebase" \
        gf "git fetch" \
        gfa "git fetch --all"

      _print_category "LOG & HISTORY" \
        glog "git log --oneline" \
        gloga "git log --oneline --graph --all" \
        glast "git log -1" \
        gshow "git show" \
        gbl "git blame"

      _print_category "STASH" \
        gst "git stash" \
        gstl "git stash list" \
        gsta "git stash apply" \
        gstp "git stash pop" \
        gstsh "git stash show -p" \
        gstd "git stash drop"

      _print_category "RESTORE & RESET" \
        grs "git restore" \
        grss "git restore --staged" \
        gundo "git reset --soft HEAD~1 (undo commit, keep staged)" \
        gclean "git clean -fd" \
        gpristine "git reset --hard && git clean -fd"

      _print_category "MERGE & REBASE" \
        gm "git merge" \
        grb "git rebase" \
        grbc "git rebase --continue" \
        grba "git rebase --abort"

      _print_category "TAGS" \
        gt "git tag" \
        gtv "git tag -n"

      _print_category "CONFIGURATION" \
        gconf "git config --list" \
        gname "git config user.name" \
        gemail "git config user.email" \
        gmail "alias to gemail"

      _print_category "SEARCH" \
        ggrep "git grep"

      printf "%s----------------------------------------%s\n" "$_DIM" "$_RESET"
      printf "Tip: run %sghelp <category>%s to filter (e.g., %sghelp commit%s, %sghelp branch%s)\n" \
        "$_GREEN" "$_RESET" "$_GREEN" "$_RESET" "$_GREEN" "$_RESET"
      printf "%s----------------------------------------%s\n" "$_DIM" "$_RESET"
      ;;

    "basic")
      _print_category "BASIC" \
        gv "git --version" \
        gi "git init" \
        gcl "git clone"
      ;;

    "status"|"staging")
      _print_category "STATUS & STAGING" \
        gs "git status" \
        gsv "git status -sb" \
        ga "git add" \
        gA "git add --all" \
        gap "git add -p"
      ;;

    "diff")
      _print_category "DIFF" \
        gd "git diff" \
        gds "git diff --staged" \
        gdn "git diff --name-only"
      ;;

    "commit")
      _print_category "COMMIT" \
        gc "smart commit (opens editor if empty, or git commit -m '<msg>')" \
        gca "git commit --amend --no-edit" \
        gcam "git commit --amend"
      ;;

    "branch"|"switch")
      _print_category "BRANCH & SWITCH" \
        gb "git branch" \
        gba "git branch -a" \
        gco "git checkout" \
        gsw "git switch" \
        gsc "git switch -c" \
        gswc "git switch -c" \
        gmain "switch to main/master branch"
      ;;

    "remote")
      _print_category "REMOTE" \
        gr "git remote" \
        grv "git remote -v" \
        gp "git push" \
        gl "git pull" \
        glr "git pull --rebase" \
        gf "git fetch" \
        gfa "git fetch --all"
      ;;

    "log"|"history")
      _print_category "LOG & HISTORY" \
        glog "git log --oneline" \
        gloga "git log --oneline --graph --all" \
        glast "git log -1" \
        gshow "git show" \
        gbl "git blame"
      ;;

    "stash")
      _print_category "STASH" \
        gst "git stash" \
        gstl "git stash list" \
        gsta "git stash apply" \
        gstp "git stash pop" \
        gstsh "git stash show -p" \
        gstd "git stash drop"
      ;;

    "restore"|"reset")
      _print_category "RESTORE & RESET" \
        grs "git restore" \
        grss "git restore --staged" \
        gundo "git reset --soft HEAD~1 (undo commit, keep staged)" \
        gclean "git clean -fd" \
        gpristine "git reset --hard && git clean -fd"
      ;;

    "merge"|"rebase")
      _print_category "MERGE & REBASE" \
        gm "git merge" \
        grb "git rebase" \
        grbc "git rebase --continue" \
        grba "git rebase --abort"
      ;;

    "tags"|"tag")
      _print_category "TAGS" \
        gt "git tag" \
        gtv "git tag -n"
      ;;

    "config"|"configuration")
      _print_category "CONFIGURATION" \
        gconf "git config --list" \
        gname "git config user.name" \
        gemail "git config user.email" \
        gmail "alias to gemail"
      ;;

    "search")
      _print_category "SEARCH" \
        ggrep "git grep"
      ;;

    *)
      printf "Unknown category: %s%s%s\n\n" "$_CYAN" "$1" "$_RESET"
      printf "Available categories:\n"
      printf "  basic, status, diff, commit, branch, remote, log, stash, restore, merge, tags, config, search\n\n"
      printf "Usage: %sghelp [category]%s\n" "$_GREEN" "$_RESET"
      return 1
      ;;
  esac
}
