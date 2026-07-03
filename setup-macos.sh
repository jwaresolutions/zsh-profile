#!/usr/bin/env bash
# Idempotent zsh + oh-my-zsh + powerlevel10k + iTerm2 setup for macOS.
# Safe to re-run.
set -euo pipefail

# --- Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing tools"
brew install git curl >/dev/null

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

clone_if_missing https://github.com/romkatv/powerlevel10k.git             "$ZSH_CUSTOM/themes/powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions.git     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# --- profile files ---
PROFILE_DIR="$HOME/zsh-profile"
clone_if_missing https://github.com/jwaresolutions/zsh-profile.git "$PROFILE_DIR"

TIMESTAMP="$(date +%Y%m%d%H%M%S)"
for f in .zshrc .p10k.zsh; do
  if [[ -f "$HOME/$f" ]]; then
    echo "==> Backing up existing ~/$f to ~/$f.backup.$TIMESTAMP"
    cp "$HOME/$f" "$HOME/$f.backup.$TIMESTAMP"
  fi
done

cp "$PROFILE_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
cp "$PROFILE_DIR/.zshrc"    "$HOME/.zshrc"
echo "==> Installed ~/.zshrc and ~/.p10k.zsh (check the .backup.$TIMESTAMP files for anything custom to merge back in, e.g. extra PATH exports)"

# --- default shell ---
ZSH_BIN="$(command -v zsh)"
if [[ "${SHELL:-}" != "$ZSH_BIN" ]]; then
  echo "==> Setting default shell to zsh"
  chsh -s "$ZSH_BIN" "$(whoami)"
fi

# --- MesloLGS NF font (required by powerlevel10k) ---
FONT_DIR="$HOME/Library/Fonts"
FONT_BASE="https://github.com/romkatv/powerlevel10k-media/raw/master"
mkdir -p "$FONT_DIR"
for f in "MesloLGS NF Regular.ttf" "MesloLGS NF Bold.ttf" "MesloLGS NF Italic.ttf" "MesloLGS NF Bold Italic.ttf"; do
  if [[ -f "$FONT_DIR/$f" ]]; then
    echo "==> $f already installed, skipping"
  else
    echo "==> Installing font: $f"
    encoded="${f// /%20}"
    curl -fsSL -o "$FONT_DIR/$f" "$FONT_BASE/$encoded"
  fi
done

# --- iTerm2 profile font ---
ITERM_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
if [[ -f "$ITERM_PLIST" ]]; then
  if pgrep -x iTerm2 >/dev/null 2>&1; then
    echo "==> iTerm2 is currently running - quit it fully (Cmd+Q) and re-run this script,"
    echo "    otherwise iTerm2 will overwrite the font change with its in-memory settings on quit."
  else
    cp "$ITERM_PLIST" "$ITERM_PLIST.backup.$TIMESTAMP"
    python3 <<'PYEOF'
import os, plistlib, re

path = os.path.expanduser("~/Library/Preferences/com.googlecode.iterm2.plist")
with open(path, "rb") as f:
    data = plistlib.load(f)

profiles = data.get("New Bookmarks", [])

def new_font_string(old, family="MesloLGS-NF-Regular"):
    m = re.match(r"^(.*)\s+(\d+)$", old) if old else None
    size = m.group(2) if m else "12"
    return f"{family} {size}"

for p in profiles:
    old_normal = p.get("Normal Font", "Monaco 12")
    old_nonascii = p.get("Non Ascii Font", old_normal)
    p["Normal Font"] = new_font_string(old_normal)
    p["Non Ascii Font"] = new_font_string(old_nonascii)
    print(f"==> iTerm2 profile '{p.get('Name', '<unnamed>')}' font set to {p['Normal Font']}")

with open(path, "wb") as f:
    plistlib.dump(data, f, fmt=plistlib.FMT_BINARY)
PYEOF
    killall cfprefsd 2>/dev/null || true
    echo "==> iTerm2 font updated. Fully quit (Cmd+Q) and relaunch iTerm2 for it to take effect."
  fi
else
  echo "==> iTerm2 not installed, skipping terminal font configuration"
fi

echo "==> Done. Open a new shell or run: exec zsh"
