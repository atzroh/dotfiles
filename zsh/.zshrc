# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

[ -f ~/.zsh/path.zsh ] && source ~/.zsh/path.zsh # path configurations
[ -f ~/.zsh/sheldon.zsh ] && source ~/.zsh/sheldon.zsh # sheldon configurations
[ -f ~/.zsh/.p10k.zsh ] && source ~/.zsh/.p10k.zsh # powerlevel10k configurations
[ -f ~/.zsh/history.zsh ] && source ~/.zsh/history.zsh # history configurations
[ -f ~/.zsh/completion.zsh ] && source ~/.zsh/completion.zsh # completion configurations
[ -f ~/.zsh/alias.zsh ] && source ~/.zsh/alias.zsh # alias configurations
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh # fzf configurations
