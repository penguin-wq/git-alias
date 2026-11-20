#!/bin/sh

DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install_shell_config() {
  SHELL_CONFIG="$1"
  SHELL_NAME="$2"

  mkdir -p "$(dirname "$SHELL_CONFIG")"
  touch "$SHELL_CONFIG"

  if grep -Fq "# DOTFILES GIT CONFIG" "$SHELL_CONFIG"; then
    echo "$SHELL_NAME already configured."
    return
  fi

  cat >> "$SHELL_CONFIG" <<EOF

DOTFILES="$DOTFILES_DIR"
. "\$DOTFILES/git/alias.sh"
. "\$DOTFILES/git/help.sh"
EOF

  echo "$SHELL_NAME configured successfully."
}

echo "Installing dotfiles..."

install_shell_config "$HOME/.zshrc" "Zsh"
install_shell_config "$HOME/.bashrc" "Bash"

echo ""
echo "installation complete!"
echo "restart your terminal or reload your shell."

