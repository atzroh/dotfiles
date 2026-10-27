# Keybindings
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# History configuration for Zsh
setopt histignorealldups
setopt sharehistory

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Globbing
setopt globdots # include hidden files in globbing
