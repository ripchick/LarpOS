# LarpOS live shell (zsh)
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'

# greet the moon
command -v fastfetch >/dev/null 2>&1 && fastfetch
