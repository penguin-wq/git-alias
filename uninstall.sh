#!/bin/sh
set -e

# git-alias uninstaller
# https://github.com/penguin-wq/git-alias

INSTALL_DIR="${GIT_ALIAS_INSTALL_DIR:-$HOME/.git-alias}"
START_TAG="# >>> git-alias initialize >>>"
END_TAG="# <<< git-alias initialize <<<"

remove_from_file() {
  _file="$1"
  if [ -f "$_file" ] && grep -Fq "$START_TAG" "$_file"; then
    _tmp_file="${_file}.tmp.$$"
    sed "/$START_TAG/,/$END_TAG/d" "$_file" > "$_tmp_file"
    mv "$_tmp_file" "$_file"
    echo "Removed git-alias configuration from $_file"
  fi
}

echo "Removing git-alias configuration..."
remove_from_file "$HOME/.zshrc"
remove_from_file "$HOME/.bashrc"
remove_from_file "$HOME/.bash_profile"
remove_from_file "$HOME/.profile"

# If --purge or -p is specified, remove INSTALL_DIR
if [ "${1:-}" = "--purge" ] || [ "${1:-}" = "-p" ]; then
  if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "Removed $INSTALL_DIR directory."
  fi
fi

echo ""
echo "Uninstallation complete. Restart your terminal or reload your shell profile."
