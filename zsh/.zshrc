# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

[ -f ~/.zsh/plugin.zsh ] && source ~/.zsh/plugin.zsh # plugin configurations
[ -f ~/.zsh/.p10k.zsh ] && source ~/.zsh/.p10k.zsh # powerlevel10k configurations
[ -f ~/.zsh/history.zsh ] && source ~/.zsh/history.zsh # history configurations
[ -f ~/.zsh/path.zsh ] && source ~/.zsh/path.zsh # path configurations
[ -f ~/.zsh/completion.zsh ] && source ~/.zsh/completion.zsh # completion configurations
[ -f ~/.zsh/alias.zsh ] && source ~/.zsh/alias.zsh # alias configurations
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh # fzf configurations
