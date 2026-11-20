# git-alias

[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20WSL%20%7C%20Windows-blue.svg)](#cross-platform-support)
[![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-green.svg)](#installation)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)

---

## Features

- **Productivity Boost**: Ergonomic shortcuts for everyday Git commands (`gs`, `ga`, `gd`, `gco`, `gp`, `gl`).
- **Smart Commit Function**: `gc` opens your `$EDITOR` if called without arguments, or commits directly via `gc "commit message"`.
- **Safe Reset & Recovery**: `gundo` safely rolls back the last commit keeping files staged; `gpristine` discards untracked and modified files.
- **Branch Navigation**: `gmain` instantly switches to `main` (or falls back to `master`).
- **Tab-Completion Hooks**: Integrates with Zsh (`compdef`) and Bash (`__git_complete`) so your aliases retain context-aware tab completion.
- **Interactive Help**: Run `ghelp` or `ghelp <category>` (e.g. `ghelp branch`, `ghelp commit`) with color-coded terminal output.
- **Zero Dependencies**: Pure POSIX shell compatible. Works on macOS, Linux, WSL, and Git Bash on Windows.

---

## Installation

### 1. One-Line Install (Recommended)

Run the following command in your terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/penguin-wq/git-alias/main/install.sh | sh
```

The installer:
- Clones the repository to `~/.git-alias`
- Detects your shell (Zsh / Bash) and operating system
- Idempotently adds a managed sourcing block to `~/.zshrc`, `~/.bashrc`, or `~/.bash_profile`
- Preserves all your existing shell settings

Reload your shell or restart your terminal:
```sh
source ~/.zshrc   # for Zsh
# or
source ~/.bashrc  # for Bash
```

### 2. Manual Git Clone

```sh
git clone https://github.com/penguin-wq/git-alias.git ~/.git-alias
~/.git-alias/install.sh
```

### 3. Oh My Zsh / Plugin Managers

#### Oh My Zsh
Clone into your custom plugins directory:
```sh
git clone https://github.com/penguin-wq/git-alias.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-alias
```
Then add `git-alias` to your plugins array in `~/.zshrc`:
```zsh
plugins=(... git-alias)
```

#### Zinit
```zsh
zinit light penguin-wq/git-alias
```

#### Antigen
```zsh
antigen bundle penguin-wq/git-alias
```

---

## Command Reference

### Status & Staging
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `gs` | `git status` | Short status |
| `gsv` | `git status -sb` | Concise branch status |
| `ga` | `git add` | Add specific files |
| `gA` | `git add --all` | Stage all changes |
| `gap` | `git add -p` | Interactively stage patch hunks |

### Commit
| Shortcut | Command / Function | Description |
| :--- | :--- | :--- |
| `gc` | `gc [msg]` | Smart commit: opens editor on `gc`, or runs `git commit -m "[msg]"` |
| `gca` | `git commit --amend --no-edit` | Amend last commit keeping same message |
| `gcam` | `git commit --amend` | Amend last commit with editor |

### Branch & Switch
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `gb` | `git branch` | List local branches |
| `gba` | `git branch -a` | List all local and remote branches |
| `gco` | `git checkout` | Checkout branch or commit |
| `gsw` | `git switch` | Switch to an existing branch |
| `gsc` / `gswc` | `git switch -c` | Create and switch to a new branch |
| `gmain` | `git checkout main \|\| git checkout master` | Quick jump back to default branch |

### Diff
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `gd` | `git diff` | Diff working directory against index |
| `gds` | `git diff --staged` | Diff staged changes against HEAD |
| `gdn` | `git diff --name-only` | Show changed filenames only |

### Remote, Push & Pull
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `gp` | `git push` | Push current branch |
| `gl` | `git pull` | Pull changes |
| `glr` | `git pull --rebase` | Pull and rebase local commits |
| `gf` | `git fetch` | Fetch changes from remote |
| `gfa` | `git fetch --all` | Fetch all remotes and branches |
| `gr` | `git remote` | List remotes |
| `grv` | `git remote -v` | List remotes with URLs |

### Log & History
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `glog` | `git log --oneline` | Compact commit log |
| `gloga` | `git log --oneline --graph --all` | Visual ASCII commit graph |
| `glast` | `git log -1` | Show last commit details |
| `gshow` | `git show` | Inspect commit or object |
| `gbl` | `git blame` | Line-by-line attribution |

### Stash
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `gst` | `git stash` | Stash modified and staged changes |
| `gstl` | `git stash list` | View all stashes |
| `gsta` | `git stash apply` | Apply topmost stash without dropping |
| `gstp` | `git stash pop` | Apply and remove topmost stash |
| `gstsh` | `git stash show -p` | Show diff of current stash |
| `gstd` | `git stash drop` | Drop topmost or specified stash |

### Restore & Reset
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `grs` | `git restore` | Restore working tree files |
| `grss` | `git restore --staged` | Unstage files from index |
| `gundo` | `git reset --soft HEAD~1` | Undo last commit (keeps changes staged) |
| `gclean` | `git clean -fd` | Delete untracked files and directories |
| `gpristine` | `git reset --hard && git clean -fd` | Reset all changes and clean directory |

### Merge & Rebase
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `gm` | `git merge` | Merge branch into current branch |
| `grb` | `git rebase` | Rebase current branch |
| `grbc` | `git rebase --continue` | Continue rebase after conflict resolution |
| `grba` | `git rebase --abort` | Abort in-progress rebase |

### Tags & Config
| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `gt` | `git tag` | List tags |
| `gtv` | `git tag -n` | List tags with annotations |
| `gconf` | `git config --list` | List all Git configuration |
| `gname` | `git config user.name` | Display configured author name |
| `gemail` | `git config user.email` | Display configured author email |
| `ggrep` | `git grep` | Search text in tracked files |

---

## Interactive Help

Run `ghelp` at any time to display the full cheat sheet:

```sh
ghelp
```

You can also filter by category:

```sh
ghelp branch     # Branching shortcuts
ghelp commit     # Commit shortcuts
ghelp stash      # Stash shortcuts
ghelp diff       # Diff shortcuts
ghelp remote     # Remote & push/pull shortcuts
```

---

## Uninstallation

To remove `git-alias` and clean your shell configuration files:

```sh
~/.git-alias/uninstall.sh --purge
```

The uninstaller removes the configuration block from `~/.zshrc`, `~/.bashrc`, and `~/.bash_profile`, and deletes the `~/.git-alias` directory.

---

## Running Tests

Automated tests verify syntax, alias expansion, function behavior, installer idempotency, and uninstaller logic:

```sh
./tests/test_all.sh
```

---

## License

MIT © [penguin-wq](https://github.com/penguin-wq)
