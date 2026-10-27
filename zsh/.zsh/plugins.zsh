# External tools and zsh plugins; loaded before compinit

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# initialize sheldon (zsh-completions adds to fpath, so this must run before compinit)
if (( $+commands[sheldon] )); then
    eval "$(sheldon source)"
fi
