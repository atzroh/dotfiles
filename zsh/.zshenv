# Skip compinit in /etc/zsh/zshrc; completion.zsh runs it
skip_global_compinit=1

# Keep PATH and fpath free of duplicates
typeset -U path fpath

# User binaries (pipx, sheldon) and fzf; set here so non-interactive shells get them too
path+=($HOME/.local/bin $HOME/.fzf/bin)
