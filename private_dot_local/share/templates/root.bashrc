export EDITOR=vim
export VISUAL="$EDITOR"
export PAGER=less

alias \
        ll='ls -alhvN --color=auto --group-directories-first' \
        sctl='systemctl' \
        ip='ip -color=auto' \
        e='$EDITOR' \
        se='e'

export PS1='\[\033[1m\]\[\033[38;5;130m\][\[\033[38;5;1m\]\u\[\033[38;5;7m\]@\[\033[38;5;107m\]\h \[\033[38;5;109m\]\W\[\033[38;5;130m\]] \[\033[38;5;7m\]$ \[\033[0m\]'

