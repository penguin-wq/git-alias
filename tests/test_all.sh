#!/usr/bin/env bash
set -euo pipefail

# Test suite for git-alias
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PASSED=0
FAILED=0

assert_eq() {
  local expected="$1"
  local actual="$2"
  local msg="$3"
  if [ "$expected" = "$actual" ]; then
    echo "  PASS: $msg"
    PASSED=$((PASSED + 1))
  else
    echo "  FAIL: $msg (expected '$expected', got '$actual')"
    FAILED=$((FAILED + 1))
  fi
}

assert_contains() {
  local needle="$1"
  local haystack="$2"
  local msg="$3"
  if [[ "$haystack" == *"$needle"* ]]; then
    echo "  PASS: $msg"
    PASSED=$((PASSED + 1))
  else
    echo "  FAIL: $msg ('$needle' not found)"
    FAILED=$((FAILED + 1))
  fi
}

echo "=== Test 1: Syntax check ==="
for f in "$REPO_DIR"/git-alias.sh "$REPO_DIR"/install.sh "$REPO_DIR"/uninstall.sh "$REPO_DIR"/src/*.sh; do
  bash -n "$f"
  zsh -n "$f"
done
zsh -n "$REPO_DIR"/git-alias.plugin.zsh
echo "  PASS: All scripts pass bash -n and zsh -n"
PASSED=$((PASSED + 1))

echo "=== Test 2: Sourcing and aliases in Bash ==="
BASH_OUTPUT=$(bash -c "
  . '$REPO_DIR/git-alias.sh'
  alias gs
  alias gundo
  alias gmain
  alias gemail
  alias gmail
")
assert_contains "alias gs='git status'" "$BASH_OUTPUT" "gs alias in Bash"
assert_contains "alias gundo='git reset --soft HEAD~1'" "$BASH_OUTPUT" "gundo alias in Bash"
assert_contains "alias gmain='git checkout main 2>/dev/null || git checkout master'" "$BASH_OUTPUT" "gmain alias in Bash"
assert_contains "alias gemail='git config user.email'" "$BASH_OUTPUT" "gemail alias in Bash"
assert_contains "alias gmail='gemail'" "$BASH_OUTPUT" "gmail alias in Bash"

echo "=== Test 3: Sourcing and aliases in Zsh ==="
ZSH_OUTPUT=$(zsh -c "
  . '$REPO_DIR/git-alias.sh'
  which gs
  which gundo
  which gmain
  which gemail
  which gmail
")
assert_contains "gs: aliased to git status" "$ZSH_OUTPUT" "gs alias in Zsh"
assert_contains "gundo: aliased to git reset --soft HEAD~1" "$ZSH_OUTPUT" "gundo alias in Zsh"
assert_contains "gmain: aliased to git checkout main 2>/dev/null || git checkout master" "$ZSH_OUTPUT" "gmain alias in Zsh"
assert_contains "gemail: aliased to git config user.email" "$ZSH_OUTPUT" "gemail alias in Zsh"
assert_contains "gmail: aliased to gemail" "$ZSH_OUTPUT" "gmail alias in Zsh"

echo "=== Test 4: gc function logic ==="
GC_TEST=$(bash -c "
  . '$REPO_DIR/src/alias.sh'
  git() {
    echo \"GIT_CALLED: \$*\"
  }
  gc
  gc 'my custom message'
  gc multiple args message
")
assert_contains "GIT_CALLED: commit" "$GC_TEST" "gc with no args opens interactive commit"
assert_contains "GIT_CALLED: commit -m my custom message" "$GC_TEST" "gc with quoted message"
assert_contains "GIT_CALLED: commit -m multiple args message" "$GC_TEST" "gc with unquoted arguments"

echo "=== Test 5: ghelp filtering and error handling ==="
HELP_OUTPUT=$(bash -c ". '$REPO_DIR/src/help.sh'; ghelp branch")
assert_contains "BRANCH & SWITCH" "$HELP_OUTPUT" "ghelp branch prints branch section"
assert_contains "gmain" "$HELP_OUTPUT" "ghelp branch lists gmain"

HELP_ERR=0
bash -c ". '$REPO_DIR/src/help.sh'; ghelp invalid_category" >/dev/null 2>&1 || HELP_ERR=$?
assert_eq "1" "$HELP_ERR" "ghelp returns exit code 1 on unknown category"

echo "=== Test 6: Installer and Uninstaller in isolated HOME ==="
MOCK_HOME=$(mktemp -d)
export HOME="$MOCK_HOME"

# Run install.sh from repo
bash "$REPO_DIR/install.sh" >/dev/null

assert_eq "true" "$([ -f "$MOCK_HOME/.git-alias/git-alias.sh" ] && echo true || echo false)" "Installer synced files to ~/.git-alias"
assert_eq "true" "$([ -f "$MOCK_HOME/.bashrc" ] && echo true || echo false)" "Installer created/updated ~/.bashrc"
assert_eq "true" "$([ -f "$MOCK_HOME/.zshrc" ] && echo true || echo false)" "Installer created/updated ~/.zshrc"

COUNT_FIRST=$(grep -c "# >>> git-alias initialize >>>" "$MOCK_HOME/.bashrc" || true)
assert_eq "1" "$COUNT_FIRST" "Single initialization block added on first install"

# Run install.sh second time (idempotency check)
bash "$REPO_DIR/install.sh" >/dev/null
COUNT_SECOND=$(grep -c "# >>> git-alias initialize >>>" "$MOCK_HOME/.bashrc" || true)
assert_eq "1" "$COUNT_SECOND" "No duplicate block added on re-install"

# Verify sourced configuration in mock home
MOCK_RUN=$(bash -c "
  export HOME='$MOCK_HOME'
  . '$MOCK_HOME/.bashrc'
  alias gs
")
assert_contains "alias gs='git status'" "$MOCK_RUN" "Aliases work via sourced mock .bashrc"

# Run uninstall.sh with --purge
bash "$MOCK_HOME/.git-alias/uninstall.sh" --purge >/dev/null
UNINSTALL_COUNT=$(grep -c "# >>> git-alias initialize >>>" "$MOCK_HOME/.bashrc" || true)
assert_eq "0" "$UNINSTALL_COUNT" "Configuration block cleanly removed on uninstall"
assert_eq "false" "$([ -d "$MOCK_HOME/.git-alias" ] && echo true || echo false)" "Directory removed on purge uninstall"

# Clean up
rm -rf "$MOCK_HOME"

echo ""
echo "========================================"
echo "Tests Passed: $PASSED | Tests Failed: $FAILED"
echo "========================================"

if [ "$FAILED" -ne 0 ]; then
  exit 1
fi
