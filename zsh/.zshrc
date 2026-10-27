# Load modules in order:
#   plugins (fpath) -> completion (compinit, then fzf wraps Tab)
#   alias stays last so aliases never affect other modules
for f in options plugins p10k completion alias; do
  [[ -f ~/.zsh/$f.zsh ]] && source ~/.zsh/$f.zsh
done
unset f
