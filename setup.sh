#!/usr/bin/env bash
# Idempotent zsh + oh-my-zsh + powerlevel10k setup for Debian/Ubuntu.
# Safe to re-run.
set -euo pipefail

# --- privilege handling ---
SUDO=""
if [[ "$(id -u)" -ne 0 ]]; then
  SUDO="sudo"
fi

# --- packages ---
echo "==> Updating apt"
$SUDO apt-get update
DEBIAN_FRONTEND=noninteractive $SUDO apt-get -y \
  -o Dpkg::Options::='--force-confdef' \
  -o Dpkg::Options::='--force-confold' \
  upgrade

echo "==> Installing tools"
DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y \
  -o Dpkg::Options::='--force-confdef' \
  -o Dpkg::Options::='--force-confold' \
  git zsh curl ca-certificates

$SUDO apt-get autoremove -y
$SUDO apt-get clean

# --- oh-my-zsh ---
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> oh-my-zsh already installed, skipping"
else
  echo "==> Installing oh-my-zsh"
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- theme + plugins ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_if_missing() {
  local repo="$1" dest="$2"
  if [[ -d "$dest" ]]; then
    echo "==> $dest exists, skipping clone"
  else
    git clone --depth=1 "$repo" "$dest"
  fi
}

clone_if_missing https://github.com/romkatv/powerlevel10k.git           "$ZSH_CUSTOM/themes/powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions.git   "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# --- profile files ---
PROFILE_DIR="$HOME/zsh-profile"
clone_if_missing https://github.com/jwaresolutions/zsh-profile.git "$PROFILE_DIR"

cp "$PROFILE_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
cp "$PROFILE_DIR/.zshrc"    "$HOME/.zshrc"

# --- default shell ---
ZSH_BIN="$(command -v zsh)"
if [[ "${SHELL:-}" != "$ZSH_BIN" ]]; then
  echo "==> Setting default shell to zsh"
  $SUDO chsh -s "$ZSH_BIN" "$(whoami)"
fi

echo "==> Done. Open a new shell or run: exec zsh"
