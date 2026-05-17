# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Single `master` branch; environment differences live in the configs themselves.

## Quick start

```sh
git clone https://github.com/dlarocque/dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh        # fresh machine: brews + tpm + install
# or
make install          # already-bootstrapped: just stow
```

| Command | What it does |
| --- | --- |
| `make install` | stow packages for the current env |
| `make dry-run` | preview without changes |
| `make list` | list available environments |
| `make bootstrap` | run `bootstrap.sh` (brews + TPM + oh-my-zsh + stow) |
| `make update` | git pull + restow + update tmux plugins |
| `make brew` | upgrade all brews, cleanup |
| `make lint` | shellcheck the shell scripts |
| `make help` | show all targets |

`install.sh` supports `[env]`, `--list`, `--dry-run`. Auto-detects from `uname`.

### One-time migration note

If `~/.config` already exists as a folded symlink from an earlier setup
(`ls -la ~/.config` shows it pointing into `.dotfiles/`), unfold it before
running `install.sh`:

```sh
rm ~/.config && mkdir ~/.config
./install.sh
```

## Environment strategy

Two ways to express per-environment differences, depending on whether the
config format supports conditionals:

| Format supports conditionals? | Strategy | Example |
| --- | --- | --- |
| Yes | Single file with a branch | `zsh/.zshrc` uses `case "$OSTYPE"`; `vim/.vim/vimrc` uses `has('mac')`; `tmux/.tmux.conf` uses `if-shell`; `git/.gitconfig` uses `[include]` overlays |
| No | Per-env Stow packages | `alacritty-macos/` vs `alacritty-linux/`; `i3/` (Linux-only); `ghostty/` (macOS-only) |

### Per-machine overrides

- `~/.gitconfig.local` — untracked, sourced by `git/.gitconfig` if present.
- `~/.zshrc.local` — untracked, sourced at the end of `zsh/.zshrc` if present.

## Layout

```
.dotfiles/
├── install.sh        # stow wrapper, per-env package selection
├── bootstrap.sh      # fresh-machine setup (brews, tpm, install)
├── Makefile          # common operations
├── .editorconfig
│
├── zsh/, bash/       # shells; OS-conditional inside the file
├── vim/, nvim/       # editors; vim uses has('mac')
├── tmux/             # tmux + TPM plugins
├── git/              # + .gitconfig.{macos,linux} overlays
├── ssh/              # ~/.ssh/config template (NEVER commit keys)
├── bin/              # ~/bin scripts
│
├── starship/         # prompt
├── atuin/            # shell history (local-only, no sync)
├── bat/              # cat replacement
├── ripgrep/          # search defaults
├── python/           # .pythonrc
├── go/               # ~/.config/go/env
│
├── fish/, gh/, zellij/                # cross-OS singletons
├── alacritty-macos/, alacritty-linux/ # per-OS variants
├── ghostty/                           # macOS-only
├── i3/, terminator/                   # Linux-only
```

## Adding a new environment

1. Edit `install.sh`, add a case branch in `pick_packages()` mapping the env
   name to the package list.
2. If the env needs a new per-OS config variant (e.g. `alacritty-bsd/`),
   create the package and add it to the list.
3. Add a `git/.gitconfig.<env>` overlay if needed.

## Tools assumed to be installed

`bootstrap.sh` installs all of these via homebrew:

| Tool | What it's for |
| --- | --- |
| stow | symlinking the dotfiles |
| starship | shell prompt |
| zoxide | smarter `cd` |
| atuin | shell history (local only) |
| fzf | fuzzy finder (Ctrl+T, Ctrl+R, Alt+C) |
| ripgrep, fd, bat | modern grep / find / cat |
| nvm | node version manager (auto-`nvm use` on `.nvmrc`) |
| tmux + TPM | terminal multiplexer + plugins |

First tmux session after bootstrap: press `Ctrl-a I` to install plugins.
