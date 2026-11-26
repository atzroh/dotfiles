# Shell options: keybindings, history, globbing, directories, input

# Keybindings
bindkey -e

# History configuration for Zsh
setopt histignorealldups
setopt sharehistory
setopt histignorespace
setopt extendedhistory
setopt histreduceblanks

# Keep 100000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Globbing
setopt globdots # include hidden files in globbing

# Directories
setopt autocd
setopt autopushd
setopt pushdignoredups

# Input
setopt interactivecomments
