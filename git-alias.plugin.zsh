# git-alias plugin for Oh My Zsh / framework managers
# https://github.com/penguin-wq/git-alias

GIT_ALIAS_DIR="${0:A:h}"
if [ -f "$GIT_ALIAS_DIR/git-alias.sh" ]; then
  . "$GIT_ALIAS_DIR/git-alias.sh"
fi
