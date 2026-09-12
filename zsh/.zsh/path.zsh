# Enable bash completion for Python argcomplete
fpath=(/usr/lib/python3/dist-packages/argcomplete/bash_completion.d $fpath)

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# Created by `pipx` on 2026-04-04 06:48:04
export PATH="$PATH:$HOME/.local/bin"
