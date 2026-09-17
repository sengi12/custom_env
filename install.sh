#!/usr/bin/env bash
# install.sh -- link these dotfiles into $HOME and set up the shell.
#
# Works with bash 3.2 (macOS) and Debian/Ubuntu. Safe to re-run: existing
# links that already point here are left alone, real files are moved to
# ~/.dotfiles-backup/<timestamp>/ before a link replaces them.
#
#   ./install.sh            link dotfiles, install oh-my-zsh + plugins
#   ./install.sh --deps     also install vim zsh fzf universal-ctags (brew/apt)
#   ./install.sh --dry-run  print what would happen, change nothing
#
# Packages are the top-level directories; each mirrors $HOME, so
# zsh/.zshrc -> ~/.zshrc. Only entries whose name starts with a dot are
# linked (README.md and the like stay put). `stow -t ~ zsh vim` from the
# repo root does the same job if you prefer GNU stow.

set -eu

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
PACKAGES="zsh vim"
BACKUP_ROOT="$HOME/.dotfiles-backup"
OMZ_DIR="$HOME/.oh-my-zsh"   # not $ZSH: oh-my-zsh exports that in every child shell
OMZ_CUSTOM="${ZSH_CUSTOM:-$OMZ_DIR/custom}"
OMZ_INSTALLER="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
PLUGIN_REPOS="zsh-users/zsh-syntax-highlighting desyncr/auto-ls"

DRY_RUN=0
DEPS=0
STAMP="$(date +%Y%m%d-%H%M%S)"

usage() {
  sed -n '2,/^$/p' "$0" | sed 's/^# \{0,1\}//'
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --deps)    DEPS=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown option: $arg" >&2; usage >&2; exit 2 ;;
  esac
done

log() { printf '%s\n' "$*"; }
run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    log "  [dry-run] $*"
  else
    "$@"
  fi
}

# ---------------------------------------------------------------------------
# 1. link package dotfiles into $HOME
# ---------------------------------------------------------------------------
backup_file() {
  # $1 = existing path in $HOME to move aside
  dest="$BACKUP_ROOT/$STAMP"
  log "  backup  $1 -> $dest/"
  run mkdir -p "$dest"
  run mv "$1" "$dest/"
}

link_entry() {
  # $1 = package, $2 = entry name (e.g. .zshrc)
  src="$DOTFILES/$1/$2"
  target="$HOME/$2"
  if [ -L "$target" ]; then
    if [ "$(readlink "$target")" = "$src" ]; then
      log "  ok      ~/$2"
      return
    fi
    log "  relink  ~/$2 (was -> $(readlink "$target"))"
    run rm "$target"
  elif [ -e "$target" ]; then
    backup_file "$target"
  fi
  log "  link    ~/$2 -> $src"
  run ln -s "$src" "$target"
}

link_packages() {
  log "linking dotfiles from $DOTFILES"
  for pkg in $PACKAGES; do
    [ -d "$DOTFILES/$pkg" ] || continue
    for path in "$DOTFILES/$pkg"/.[!.]*; do
      [ -e "$path" ] || continue
      name="$(basename "$path")"
      case "$name" in .gitkeep|.DS_Store) continue ;; esac
      link_entry "$pkg" "$name"
    done
  done
}

# ---------------------------------------------------------------------------
# 2. oh-my-zsh and the two custom plugins the .zshrc lists
# ---------------------------------------------------------------------------
fetch() {
  # $1 = url, prints body to stdout
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$1"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$1"
  else
    echo "need curl or wget to download $1" >&2
    return 1
  fi
}

install_omz() {
  if [ -d "$OMZ_DIR" ]; then
    log "oh-my-zsh already at $OMZ_DIR"
    return
  fi
  if ! command -v git >/dev/null 2>&1; then
    log "git not found; skipping oh-my-zsh (install git and re-run)"
    return
  fi
  log "installing oh-my-zsh into $OMZ_DIR"
  if [ "$DRY_RUN" -eq 1 ]; then
    log "  [dry-run] RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \"\$(curl -fsSL $OMZ_INSTALLER)\" \"\" --unattended"
    return
  fi
  installer="$(fetch "$OMZ_INSTALLER")" || return 1
  ZSH="$OMZ_DIR" RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$installer" "" --unattended
}

install_plugins() {
  if ! command -v git >/dev/null 2>&1; then
    log "git not found; skipping zsh plugins"
    return
  fi
  for repo in $PLUGIN_REPOS; do
    name="${repo##*/}"
    dest="$OMZ_CUSTOM/plugins/$name"
    if [ -d "$dest" ]; then
      log "  ok      $name"
      continue
    fi
    log "  clone   https://github.com/$repo -> $dest"
    run mkdir -p "$OMZ_CUSTOM/plugins"
    run git clone --quiet --depth 1 "https://github.com/$repo.git" "$dest"
  done
}

# ---------------------------------------------------------------------------
# 3. optional system packages
# ---------------------------------------------------------------------------
install_deps() {
  pkgs="vim zsh fzf universal-ctags"
  if command -v brew >/dev/null 2>&1; then
    log "installing with brew: $pkgs"
    # shellcheck disable=SC2086
    run brew install $pkgs
  elif command -v apt-get >/dev/null 2>&1; then
    log "installing with apt: $pkgs"
    run sudo apt-get update
    # shellcheck disable=SC2086
    run sudo apt-get install -y $pkgs
  else
    log "no brew or apt-get found; install these yourself: $pkgs"
  fi
}

# ---------------------------------------------------------------------------
[ "$DRY_RUN" -eq 1 ] && log "(dry run: nothing will be changed)"
[ "$DEPS" -eq 1 ] && install_deps
link_packages
install_omz
log "zsh plugins in $OMZ_CUSTOM/plugins"
install_plugins
log "done. open a new shell, or: exec zsh"
