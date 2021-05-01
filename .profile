#!/bin/sh
# Profile file. Runs on login

# Locale
export LANG="en_US.UTF-8"

# Env
export LC_CTYPE="nb_NO.UTF-8"
export LC_NUMERIC="nb_NO.UTF-8"
export LC_TIME="nb_NO.UTF-8"
export LC_COLLATE="nb_NO.UTF-8"
export LC_MONETARY="nb_NO.UTF-8"
#export LC_MESSAGES="nb_NO.UTF-8"
#export LC_PAPER="nb_NO.UTF-8"
#export LC_NAME="nb_NO.UTF-8"
#export LC_ADDRESS="nb_NO.UTF-8"
#export LC_TELEPHONE="nb_NO.UTF-8"
export LC_MEASUREMENT="nb_NO.UTF-8"
#export LC_IDENTIFICATION="nb_NO.UTF-8"
#export LC_ALL=nb_NO.UTF-8

# Env
[ -z "${HOSTNAME}" ] && export HOSTNAME="$(hostname)"
[ -z "$HOST" ] && export HOST="$HOSTNAME"

export TERM=st-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

# Custom scripts
[ -d "$HOME/.scripts/" ] && export PATH="$PATH:$HOME/.scripts/"

# Ruby GEM
[ -x "$(command -v ruby)" ] && \
	export GEM_HOME="$(ruby -e 'puts Gem.user_dir')" && \
	export PATH="$PATH:$GEM_HOME/bin"

# Software
export EDITOR='vim'
export TERMINAL='alacritty'

# Load shell config rc
. ~/.MYSHELLrc
