#!/bin/sh
set -e

# git-alias installer
# https://github.com/penguin-wq/git-alias

REPO_URL="https://github.com/penguin-wq/git-alias.git"
INSTALL_DIR="${GIT_ALIAS_INSTALL_DIR:-$HOME/.git-alias}"

# 1. Determine execution context (local clone vs remote pipe)
CURRENT_SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd || true)"

if [ -f "$CURRENT_SCRIPT_DIR/git-alias.sh" ]; then
  # Local execution from repository
  if [ "$CURRENT_SCRIPT_DIR" != "$INSTALL_DIR" ]; then
    echo "Syncing git-alias to $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$INSTALL_DIR/src"
    cp -f "$CURRENT_SCRIPT_DIR/git-alias.sh" "$INSTALL_DIR/"
    cp -f "$CURRENT_SCRIPT_DIR/git-alias.plugin.zsh" "$INSTALL_DIR/"
    if [ -f "$CURRENT_SCRIPT_DIR/uninstall.sh" ]; then
      cp -f "$CURRENT_SCRIPT_DIR/uninstall.sh" "$INSTALL_DIR/"
      chmod +x "$INSTALL_DIR/uninstall.sh" 2>/dev/null || true
    fi
    cp -rf "$CURRENT_SCRIPT_DIR/src/"* "$INSTALL_DIR/src/"
  fi
else
  # Remote execution via curl / wget pipe
  if [ -d "$INSTALL_DIR/.git" ]; then
    echo "Updating existing git-alias repository at $INSTALL_DIR..."
    git -C "$INSTALL_DIR" pull --ff-only
  elif [ -d "$INSTALL_DIR" ]; then
    echo "Directory $INSTALL_DIR already exists; updating files..."
    git clone --depth=1 "$REPO_URL" "$INSTALL_DIR.tmp"
    cp -rf "$INSTALL_DIR.tmp/"* "$INSTALL_DIR/"
    rm -rf "$INSTALL_DIR.tmp"
  else
    echo "Cloning git-alias into $INSTALL_DIR..."
    git clone --depth=1 "$REPO_URL" "$INSTALL_DIR"
  fi
fi

# Ensure uninstall script exists in INSTALL_DIR if available
if [ -f "$CURRENT_SCRIPT_DIR/uninstall.sh" ] && [ ! -f "$INSTALL_DIR/uninstall.sh" ]; then
  cp -f "$CURRENT_SCRIPT_DIR/uninstall.sh" "$INSTALL_DIR/"
  chmod +x "$INSTALL_DIR/uninstall.sh" 2>/dev/null || true
fi

# 2. Function to configure a shell RC file idempotently
configure_file() {
  _file="$1"
  _shell_name="$2"

  mkdir -p "$(dirname "$_file")"
  touch "$_file"

  START_TAG="# >>> git-alias initialize >>>"
  END_TAG="# <<< git-alias initialize <<<"

  # If block already exists, clean it out first to ensure updated paths/content
  if grep -Fq "$START_TAG" "$_file"; then
    _tmp_file="${_file}.tmp.$$"
    sed "/$START_TAG/,/$END_TAG/d" "$_file" > "$_tmp_file"
    mv "$_tmp_file" "$_file"
    echo "$_shell_name: updating existing git-alias configuration in $_file"
  else
    echo "$_shell_name: adding git-alias configuration to $_file"
  fi

  cat >> "$_file" <<EOF

$START_TAG
# !! Contents within this block are managed by git-alias !!
if [ -f "$INSTALL_DIR/git-alias.sh" ]; then
  . "$INSTALL_DIR/git-alias.sh"
fi
$END_TAG
EOF
}

# 3. Detect candidate shells & RC files
CONFIGURED=0

# Detect Zsh
if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ] || [ "$(basename "${SHELL:-}")" = "zsh" ] || which zsh >/dev/null 2>&1; then
  configure_file "$HOME/.zshrc" "Zsh"
  CONFIGURED=1
fi

# Detect Bash
if [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ] || [ -f "$HOME/.bash_profile" ] || [ "$(basename "${SHELL:-}")" = "bash" ] || which bash >/dev/null 2>&1; then
  case "$(uname -s 2>/dev/null || true)" in
    Darwin)
      if [ -f "$HOME/.bash_profile" ] || [ ! -f "$HOME/.bashrc" ]; then
        configure_file "$HOME/.bash_profile" "Bash (macOS)"
      else
        configure_file "$HOME/.bashrc" "Bash"
      fi
      ;;
    *)
      configure_file "$HOME/.bashrc" "Bash"
      ;;
  esac
  CONFIGURED=1
fi

if [ "$CONFIGURED" -eq 0 ]; then
  configure_file "$HOME/.profile" "POSIX Shell"
fi

echo ""
echo "Installation complete!"
echo "To activate git-alias in your current session, run:"
if [ -n "$ZSH_VERSION" ] || [ "$(basename "${SHELL:-}")" = "zsh" ]; then
  echo "  source ~/.zshrc"
elif [ "$(uname -s 2>/dev/null || true)" = "Darwin" ] && [ -f "$HOME/.bash_profile" ]; then
  echo "  source ~/.bash_profile"
else
  echo "  source ~/.bashrc"
fi
echo ""
echo "Run 'ghelp' to view all available Git shortcuts."
