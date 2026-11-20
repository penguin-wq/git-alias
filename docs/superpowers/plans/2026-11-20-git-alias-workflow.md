# Cross-Platform Git Alias Workflow Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform `git-alias` into a robust, cross-platform Git workflow toolkit installable on macOS, Linux, WSL, and Windows (Git Bash), with zero-dependency curl/local installer, plugin manager support, completion, modernized help, and full test suite.

**Architecture:** A single POSIX entrypoint `git-alias.sh` modularly loads aliases, functions, autocompletion hooks, and interactive help. A cross-platform `install.sh` handles both remote one-liner curl installs and local repository installs with idempotent shell RC configuration, accompanied by an `uninstall.sh` and Oh My Zsh plugin entrypoint.

**Tech Stack:** POSIX Shell / Bash / Zsh, Git

**Spec:** [git-alias-workflow-plan.md](file:///home/JERUS/.gemini/antigravity-cli/brain/1e264d5a-0ce7-465b-8100-1a82d9c5f24f/git-alias-workflow-plan.md)

## Global Constraints
- Must remain strictly POSIX / sh compatible for core scripts (`install.sh`, `uninstall.sh`, `src/alias.sh`).
- Zero external dependencies beyond standard shell and `git`.
- Must not overwrite or corrupt user's existing shell RC files (`~/.zshrc`, `~/.bashrc`, `~/.bash_profile`).
- Idempotent configuration: running the installer multiple times must never produce duplicate entries.

## Review Focus
1. Sourcing `git-alias.sh` in both `bash` and `zsh` subshells behaves identically and does not error.
2. `install.sh` correctly resolves repo directory when piped via `curl | sh` vs executed locally `./install.sh`.
3. `install.sh` handles missing RC files gracefully without failing.
4. `uninstall.sh` cleanly removes injected configuration block without removing user's custom RC content.
5. `gc` function correctly distinguishes zero-argument commits from message-based commits.

---

### Task 1: Core Entrypoint & Plugin Support
**Files:**
- Create: `git-alias.sh`
- Create: `git-alias.plugin.zsh`
- Modify: `.bash/.bashrc`, `.zsh/.zshrc`

- [ ] **Step 1: Write `git-alias.sh` entrypoint**
  Resolve script directory, guard against multiple sourcing, and source `src/alias.sh`, `src/help.sh`, and `src/completion.sh`.
- [ ] **Step 2: Write `git-alias.plugin.zsh` wrapper**
  Source `git-alias.sh` from the plugin directory.
- [ ] **Step 3: Update sample files in `.bash/.bashrc` and `.zsh/.zshrc`**
  Point to `git-alias.sh`.
- [ ] **Step 4: Verify syntax with `bash -n` and `zsh -n`**
- [ ] **Step 5: Commit changes**

---

### Task 2: Aliases & Functions Refinement
**Files:**
- Modify: `src/alias.sh`

- [ ] **Step 1: Implement `gc` shell function**
  Handle interactive commit on 0 args, `git commit -m "$*"` on 1+ args.
- [ ] **Step 2: Add modern workflow aliases**
  Add `gundo`, `gmain`, `gclean`, `gpristine`, `gswc`. Refine stash aliases (`gsta`, `gstp`, `gstsh`, `gstd`).
- [ ] **Step 3: Resolve `gmail` collision**
  Add `gemail` and provide alias `gmail=gemail` for backwards compatibility.
- [ ] **Step 4: Verify syntax and behavior in bash and zsh**
- [ ] **Step 5: Commit changes**

---

### Task 3: Shell Completion Support
**Files:**
- Create: `src/completion.sh`

- [ ] **Step 1: Implement Zsh completion registration**
  Check for `compdef` and wire aliases to `_git` subcommands.
- [ ] **Step 2: Implement Bash completion registration**
  Check for `__git_complete` and wire aliases to `_git_<subcommand>`.
- [ ] **Step 3: Verify syntax in bash and zsh**
- [ ] **Step 4: Commit changes**

---

### Task 4: Modern Categorized Help
**Files:**
- Modify: `src/help.sh`

- [ ] **Step 1: Update `ghelp` to support category filter**
  Allow `ghelp [category]` (e.g. `ghelp commit`, `ghelp branch`).
- [ ] **Step 2: Add TTY-aware color formatting**
  Check `[ -t 1 ]` and `$NO_COLOR`.
- [ ] **Step 3: Verify help output**
- [ ] **Step 4: Commit changes**

---

### Task 5: Cross-Platform Installer & Uninstaller
**Files:**
- Modify: `install.sh`
- Create: `uninstall.sh`

- [ ] **Step 1: Rewrite `install.sh`**
  Add remote curl/clone detection, shell auto-detection (Zsh, Bash, macOS `.bash_profile`), and idempotent block markers.
- [ ] **Step 2: Write `uninstall.sh`**
  Safely strip the configuration block and clean up directory if requested.
- [ ] **Step 3: Write automated tests in `tests/test_all.sh`**
  Test installer idempotency, uninstallation, alias definitions, and help output in temporary HOME.
- [ ] **Step 4: Run test suite under both bash and zsh**
- [ ] **Step 5: Commit changes**

---

### Task 6: Documentation (README.md)
**Files:**
- Modify: `README.md`

- [ ] **Step 1: Write complete, formatted README**
  Include 1-line install, manual install, Oh My Zsh install, full cheatsheet table, uninstall instructions, and OS support matrix.
- [ ] **Step 2: Commit changes**
