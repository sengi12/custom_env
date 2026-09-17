# custom_env

My dotfiles: zsh (oh-my-zsh), vim, and notes on the Ghidra theme. One
directory per package, each mirroring `$HOME`, so the layout works with a
plain symlink script or with GNU stow.

```
install.sh          links everything into ~ and sets up oh-my-zsh
zsh/.zshrc          oh-my-zsh config, plugins, a great many aliases
zsh/.bashrc         TERM only; bash is not the daily shell
vim/.vimrc          self-contained, vim-plug bootstraps itself
ghidra/README.md    ghidra-dark is obsolete; how to use built-in themes
ghidra/themes/      exported .theme files go here
```

## Bootstrap a new machine

```sh
git clone git@github.com:sengi12/custom_env.git ~/.dotfiles && ~/.dotfiles/install.sh
```

`install.sh` is idempotent and runs on macOS (bash 3.2) and Debian/Ubuntu:

- symlinks every dotfile in `zsh/` and `vim/` into `~`; a real file already
  there is moved to `~/.dotfiles-backup/<timestamp>/` first, a link that
  already points into this repo is left alone
- installs oh-my-zsh via the official installer if `~/.oh-my-zsh` is missing
  (unattended, does not change your login shell, keeps the linked `.zshrc`)
- clones `zsh-users/zsh-syntax-highlighting` and `desyncr/auto-ls` into
  `${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins`, which is where the
  `plugins=(...)` line in `.zshrc` expects them

Flags:

| flag        | effect                                                       |
|-------------|--------------------------------------------------------------|
| `--dry-run` | print every step, change nothing                             |
| `--deps`    | `brew install` / `apt-get install` vim zsh fzf universal-ctags first |
| `--help`    | usage                                                        |

Then `exec zsh` (or `chsh -s "$(command -v zsh)"` once). Vim installs its
plugins on first launch; `:PlugUpdate` later.

Machine-specific paths in `.zshrc` are all optional and guarded. Override
them with environment variables if the defaults do not match:
`GHIDRA_INSTALL_DIR`, `AFL_DIR`, `ZERO10_EDITOR`.

## Using GNU stow instead

Every package directory mirrors `$HOME`, so from the repo root:

```sh
stow -t ~ zsh vim
```

does the same linking as `install.sh` (stow refuses to overwrite existing
files rather than backing them up). `ghidra` is documentation, not a stow
package; do not stow it. You still need oh-my-zsh and the two plugins; run
`install.sh` once or clone them by hand.

## Adding a package

1. `mkdir <name>` and put the files inside at the path they should have
   relative to `$HOME` (`<name>/.config/foo/rc` becomes `~/.config/foo/rc`).
2. Add `<name>` to the `PACKAGES` list near the top of `install.sh`
   (it links only top-level dot-entries; a nested tree like `.config/foo`
   is linked as one directory link).
3. Run `./install.sh --dry-run`, then `./install.sh`.

## History

Before this layout the repo carried a 15 MB tarball of a whole
`~/.oh-my-zsh` checkout, two copies of the vitaly/dotvim distro, a
`.viminfo`, and a vendored ghidra-dark. They are gone from the tree but
remain in the history of `main`; nothing was rewritten.
