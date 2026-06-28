#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '\n==> %s\n' "$1"
}

confirm() {
  local prompt="$1"
  local default="${2:-y}"
  if [ "$default" = "y" ]; then
    read -rp "$prompt [Y/n] " answer
    [ -z "$answer" ] || [[ "$answer" =~ ^[Yy] ]]
  else
    read -rp "$prompt [y/N] " answer
    [[ "$answer" =~ ^[Yy] ]]
  fi
}

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
brew_bin="/opt/homebrew/bin/brew"

# --- Install prereqs (always) ---

if command -v brew >/dev/null 2>&1; then
  brew_bin="$(command -v brew)"
elif [ -x "$brew_bin" ]; then
  export PATH="/opt/homebrew/bin:$PATH"
else
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH="/opt/homebrew/bin:$PATH"
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew was not found after installation." >&2
  exit 1
fi

log "Updating Homebrew"
"$brew_bin" update

if ! command -v chezmoi >/dev/null 2>&1; then
  log "Installing chezmoi"
  "$brew_bin" install chezmoi
fi

# --- Optional steps (default: yes) ---

run_chezmoi=true
run_brew_bundle=true

echo ""
confirm "Apply dotfiles with chezmoi?" "y" || run_chezmoi=false
confirm "Install Homebrew packages from Brewfile?" "y" || run_brew_bundle=false
echo ""

if $run_chezmoi; then
  log "Applying dotfiles with chezmoi"
  chezmoi apply --source="$repo_dir"
else
  log "Skipping chezmoi"
fi

if $run_brew_bundle; then
  if [ -f "$repo_dir/Brewfile" ]; then
    log "Installing Homebrew bundle"
    "$brew_bin" bundle --file="$repo_dir/Brewfile"
  else
    log "Skipping Homebrew bundle; no Brewfile found"
  fi
else
  log "Skipping Homebrew bundle"
fi

macos_script="$repo_dir/scripts/configure-macos.sh"
if [ -x "$macos_script" ]; then
  log "Applying macOS defaults"
  "$macos_script"
else
  log "Skipping macOS defaults; script not found"
fi

log "Done"
