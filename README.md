# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Single `master` branch; environment differences live in the configs themselves.

## Install

```sh
git clone https://github.com/dlarocque/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh                  # auto-detect OS
./install.sh macos            # or explicit
./install.sh linux-kinesis
./install.sh --list           # show envs and packages
./install.sh --dry-run        # preview without changes
```

Requires `stow` (`brew install stow` / `apt install stow`).

### One-time migration note

If `~/.config` already exists as a folded symlink from an earlier setup
(`ls -la ~/.config` shows it pointing into `.dotfiles/`), unfold it before
running `install.sh`:

```sh
rm ~/.config && mkdir ~/.config
./install.sh
```

## How environment differences are handled

Two strategies, depending on whether the config format supports conditionals:

| Format supports conditionals? | Strategy | Example |
| --- | --- | --- |
| Yes | Single file with a branch | `zsh/.zshrc` uses `case "$OSTYPE"`; `vim/.vim/vimrc` uses `has('mac')`; `tmux/.tmux.conf` uses `if-shell`; `git/.gitconfig` uses `[include]` overlays |
| No | Per-env Stow packages | `alacritty-macos/` vs `alacritty-linux/`; `i3/` (Linux-only); `ghostty/` (macOS-only) |

### Git overlay

`git/.gitconfig` includes two optional overlay files:

- `~/.gitconfig.os` — symlink created by `install.sh` pointing to
  `git/.gitconfig.macos` or `git/.gitconfig.linux`
- `~/.gitconfig.local` — untracked, optional, per-machine overrides

Missing includes are silently ignored by git.

### Per-machine zsh overrides

`zsh/.zshrc` sources `~/.zshrc.local` if it exists. Use it for
machine-specific things you don't want to commit.

## Layout

```
.dotfiles/
├── install.sh
├── README.md
├── zsh/, bash/, vim/, nvim/, tmux/, fish/, gh/, zellij/   # cross-OS packages
├── git/                                                    # + .gitconfig.macos / .gitconfig.linux
├── alacritty-macos/, alacritty-linux/                      # per-OS variants
├── ghostty/                                                # macOS-only
├── i3/, terminator/                                        # Linux-only
```

## Adding a new environment

1. Edit `install.sh`, add a case branch in `pick_packages()` mapping the env
   name to the package list.
2. If the env needs a new per-OS config variant (e.g. `alacritty-bsd/`),
   create the package and add it to the list.
3. Add a `git/.gitconfig.<env>` overlay if needed.
