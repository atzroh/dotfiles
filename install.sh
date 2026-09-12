#!/bin/bash
set -euo pipefail

# ==============================================================================
# SYSTEM PACKAGES INSTALLATION (APT)
# ==============================================================================

echo "[*] Updating and upgrading system packages..."
sudo apt-get update && sudo apt-get upgrade -y

PACKAGES=(
  # CLI Tools
  curl    # Data transfer tool
  wget    # Network downloader
  git     # Version control system
  gnupg   # GNU privacy guard
  stow    # Symlink manager
  ripgrep # Search tool
  fd-find # File finder
  eza     # Modern ls replacement
  bat     # Modern cat replacement
  htop    # System monitor
  xsel    # Clipboard manager
  unzip   # Extract ZIP files
  chafa   # Image-to-Terminal converter

  # Development Tools
  build-essential # Essential packages for building software
  tar             # Archiving utility

  # Languages & Interpreters
  zsh  # Shell
  pipx # Python package installer
)

echo "[*] Installing core packages..."
sudo apt-get install -y "${PACKAGES[@]}"

# Install packages from PPAs
echo "[*] Installing packages from PPAs..."
PPAS=(
  ppa:neovim-ppa/stable
  ppa:mkasberg/ghostty-ubuntu
  ppa:zhangsongcui3371/fastfetch
)
for ppa in "${PPAS[@]}"; do
  sudo add-apt-repository -y "$ppa" >/dev/null
done
sudo apt-get update
sudo apt-get install -y neovim ghostty fastfetch

# ==============================================================================
# NODE.JS ECOSYSTEM
# ==============================================================================

echo "[*] Installing fnm (Node.js version manager)..."
curl -fsSL https://fnm.vercel.app/install | bash
echo "[*] Initializing fnm in this shell..."
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --shell bash)"

echo "[*] Installing latest LTS version of Node.js..."
fnm install --lts
npm install -g npm@latest
corepack enable

# ==============================================================================
# PYTHON ECOSYSTEM
# ==============================================================================

echo "[*] Installing Python tools..."
pipx ensurepath
pipx install pynvim # Neovim Python support
pipx install uv     # Fast Python dev environment manager

# ==============================================================================
# GIT REPOSITORIES
# ==============================================================================

echo "[*] Installing LazyVim (Neovim starter configuration)..."
mkdir -p "$HOME/.config"
git clone -q https://github.com/LazyVim/starter "$HOME/.config/nvim/"
rm -rf "$HOME/.config/nvim/.git"

echo "[*] Installing fzf (Fuzzy finder)..."
git clone -q --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all >/dev/null

# ==============================================================================
# WEB DOWNLOADS & EXTERNAL SERVICES
# ==============================================================================

echo "[*] Installing lazygit (Git UI)..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -fLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin
rm -f lazygit.tar.gz lazygit

echo "[*] Installing Docker (Container platform)..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$USER" # add current user to docker group to use docker without sudo

# ==============================================================================
# SYMLINK
# ==============================================================================

DOTFILES=(
  zsh
  git
  ghostty
  nvim
  ssh
  fastfetch
)
echo "[*] Setting up dotfiles with stow..."
cd "$HOME/dotfiles" && stow -v --adopt "${DOTFILES[@]}" && git checkout -q -- .

# ==============================================================================
# FONTS & FINAL SETUP
# ==============================================================================

echo "[*] Installing JetBrains Mono Nerd Font..."
mkdir -p "$HOME/.local/share/fonts/JetBrainsMono/"
curl -fLo "/tmp/JetBrainsMono.zip" \
  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o "/tmp/JetBrainsMono.zip" -d "$HOME/.local/share/fonts/JetBrainsMono/"
fc-cache -fv
rm /tmp/JetBrainsMono.zip

chsh -s "$(which zsh)" # change default shell to zsh

echo "[+] Installation completed!"
