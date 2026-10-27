###aliases###
# colorize grep output (ls is aliased to eza below)
if [[ -x /usr/bin/dircolors ]]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# eza alias
alias ls='eza --icons --group-directories-first --color=auto'
alias ll='eza -alh --icons --group-directories-first --color=auto --time-style=long-iso --git --git-repos'

# bat alias
alias cat='batcat --paging=never'

# cd alias
alias ...='../../'
alias ..='cd ../'
alias ~='cd ~/'

# mv and cp alias
alias mv='mv -i'
alias cp='cp -ir'

# fd alias
alias fd='fdfind'
alias fa='fdfind -IH'
alias fdir='fdfind -H --type d'

# wl-clipboard alias
alias wlc='wl-copy'
alias wlp='wl-paste'
alias wlx='wl-paste | bash'

# tree alias
alias tree='eza --tree --icons --color=auto --git-ignore -I ".git|node_modules"'
alias atree='eza -a --tree --icons --color=auto --git-ignore -I ".git|node_modules"'

# stow alias
alias stow='stow -v'

# icat alias
alias icat='chafa -f kitty'

# password alias
alias genpw='openssl rand -base64 18 | wl-copy && wl-paste'

# fastfetch alias (hide host, local ip and battery)
alias fastfetch='fastfetch -s Title:Separator:OS:Kernel:Uptime:Packages:Shell:Display:DE:WM:WMTheme:Theme:Icons:Font:Cursor:Terminal:TerminalFont:CPU:GPU:Memory:Swap:Disk:PowerAdapter:Locale:Break:Colors'
