#!/bin/sh
# git-alias - cross-platform Git workflow shortcuts and utilities
# https://github.com/penguin-wq/git-alias

# Resolve installation directory if not already set
if [ -z "${GIT_ALIAS_DIR:-}" ]; then
  _script_path="${BASH_SOURCE[0]:-${(%):-%x}}"
  if [ -n "$_script_path" ] && [ "$_script_path" != "bash" ] && [ "$_script_path" != "zsh" ] && [ "$_script_path" != "sh" ]; then
    GIT_ALIAS_DIR="$(CDPATH= cd -- "$(dirname -- "$_script_path")" && pwd)"
  else
    GIT_ALIAS_DIR="$HOME/.git-alias"
  fi
  unset _script_path
fi

export GIT_ALIAS_DIR

# Load aliases
if [ -f "$GIT_ALIAS_DIR/src/alias.sh" ]; then
  . "$GIT_ALIAS_DIR/src/alias.sh"
fi

# Load interactive help
if [ -f "$GIT_ALIAS_DIR/src/help.sh" ]; then
  . "$GIT_ALIAS_DIR/src/help.sh"
fi

# Load shell completion hooks
if [ -f "$GIT_ALIAS_DIR/src/completion.sh" ]; then
  . "$GIT_ALIAS_DIR/src/completion.sh"
fi
