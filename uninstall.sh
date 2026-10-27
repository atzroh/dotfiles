#!/bin/bash
set -euo pipefail

# Reverts what install.sh sets up, so install.sh can be tested from a clean state.
# Docker and base packages (git, curl, zsh, ...) are left untouched.

DRY_RUN=false
AUTO_CONFIRM=false

DOTFILES_DIR="$HOME/dotfiles"
DOTFILES=(
    zsh
    git
    ghostty
    nvim
    ssh
)
APT_PACKAGES=(
    neovim
    ghostty
    eza
    bat
    fd-find
    ripgrep
    stow
    htop
    wl-clipboard
    chafa
    fastfetch
    pipx
    python3-venv
)

usage() {
    cat <<'EOF'
Usage: ./uninstall.sh [--dry-run] [--yes]

Reverts what install.sh sets up (except Docker and base packages).

Options:
  --dry-run   Show what would be done without changing anything.
  --yes       Skip the confirmation prompt.
  -h, --help  Show this help message.
EOF
}

# Print a command, and run it unless --dry-run
run() {
    echo "    \$ $*"
    if [[ "$DRY_RUN" == false ]]; then
        "$@"
    fi
}

remove_if_exists() {
    local target
    for target in "$@"; do
        if [[ -e "$target" || -L "$target" ]]; then
            run rm -rf -- "$target"
        fi
    done
}

is_installed() {
    dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "install ok installed"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
    --dry-run) DRY_RUN=true ;;
    --yes) AUTO_CONFIRM=true ;;
    -h | --help)
        usage
        exit 0
        ;;
    *)
        echo "Unknown option: $1" >&2
        usage >&2
        exit 1
        ;;
    esac
    shift
done

if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY RUN] Nothing will be changed."
elif [[ "$AUTO_CONFIRM" != true ]]; then
    cat <<EOF
This will revert install.sh:
  - login shell -> /bin/bash
  - JetBrains Mono Nerd Font
  - stow links: ${DOTFILES[*]}
  - lazygit, sheldon, fzf, fnm (Node.js), pipx apps (pynvim, uv)
  - Neovim data (~/.local/share/nvim, ~/.local/state/nvim, ~/.cache/nvim)
  - apt packages: ${APT_PACKAGES[*]}
  - Neovim PPA
EOF
    read -r -p "Continue? [y/N] " answer
    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi
fi

# ==============================================================================
# SHELL & FONTS
# ==============================================================================

echo "[*] Restoring default shell to bash..."
if [[ "$(getent passwd "$USER" | cut -d: -f7)" != /bin/bash ]]; then
    run chsh -s /bin/bash
fi

echo "[*] Removing JetBrains Mono Nerd Font..."
if [[ -d "$HOME/.local/share/fonts/JetBrainsMono" ]]; then
    remove_if_exists "$HOME/.local/share/fonts/JetBrainsMono"
    run fc-cache -f
fi

# ==============================================================================
# SYMLINK
# ==============================================================================

echo "[*] Removing dotfiles symlinks..."
if command -v stow >/dev/null 2>&1; then
    run stow -D -d "$DOTFILES_DIR" -t "$HOME" "${DOTFILES[@]}"
fi
# Broken links left by packages no longer in the repo
while IFS= read -r link; do
    if [[ "$(readlink "$link")" == *dotfiles/* ]]; then
        remove_if_exists "$link"
    fi
done < <(find "$HOME" "$HOME/.config" -maxdepth 1 -xtype l)

# ==============================================================================
# WEB DOWNLOADS & GIT REPOSITORIES
# ==============================================================================

echo "[*] Removing lazygit..."
if [[ -e /usr/local/bin/lazygit ]]; then
    run sudo rm -f /usr/local/bin/lazygit
fi

echo "[*] Removing sheldon..."
remove_if_exists "$HOME/.local/bin/sheldon" "$HOME/.local/share/sheldon"

echo "[*] Removing fzf..."
if [[ -x "$HOME/.fzf/uninstall" ]]; then
    run "$HOME/.fzf/uninstall"
fi
remove_if_exists "$HOME/.fzf"

# ==============================================================================
# PYTHON & NODE.JS ECOSYSTEM
# ==============================================================================

echo "[*] Removing Python tools..."
if command -v pipx >/dev/null 2>&1; then
    for app in pynvim uv; do
        if pipx list --short 2>/dev/null | grep -q "^$app "; then
            run pipx uninstall "$app"
        fi
    done
fi
# PATH line added by `pipx ensurepath`
if grep -q '^# Created by `pipx`' "$HOME/.profile" 2>/dev/null; then
    run sed -i '/^# Created by `pipx`/,+1d' "$HOME/.profile"
fi

echo "[*] Removing fnm and Node.js..."
remove_if_exists "$HOME/.local/share/fnm"

echo "[*] Removing Neovim data..."
remove_if_exists "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"

# ==============================================================================
# SYSTEM PACKAGES (APT)
# ==============================================================================

echo "[*] Purging apt packages..."
installed=()
for pkg in "${APT_PACKAGES[@]}"; do
    if is_installed "$pkg"; then
        installed+=("$pkg")
    fi
done
if [[ ${#installed[@]} -gt 0 ]]; then
    run sudo apt-get purge -y "${installed[@]}"
fi

echo "[*] Removing Neovim PPA..."
if compgen -G "/etc/apt/sources.list.d/neovim-ppa-*" >/dev/null; then
    run sudo add-apt-repository -y --remove ppa:neovim-ppa/unstable
    run sudo apt-get update
fi

echo "[+] Uninstallation completed!"
echo "    Run 'sudo apt-get autoremove --purge' to remove unused dependencies if needed."
echo "    Log out and back in to apply the shell change."
