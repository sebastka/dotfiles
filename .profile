#!/bin/sh
# Profile file. Runs on login

# Locale
export LANG="en_US.UTF-8"

# Env
readonly loc="nb_NO"
if [[ ! -z "${loc}" ]] && [[ ! -z $(locale -a | grep $loc) ]]; then
	# If $loc is not null AND if it is loaded:
	export LC_ALL="C"
	export LC_CTYPE="$loc.UTF-8"
	export LC_NUMERIC="$loc.UTF-8"
	export LC_TIME="$loc.UTF-8"
	export LC_COLLATE="$loc.UTF-8"
	export LC_MONETARY="$loc.UTF-8"
	export LC_MESSAGES="$loc.UTF-8"
	#export LC_PAPER="$loc.UTF-8"
	#export LC_NAME="$loc.UTF-8"
	#export LC_ADDRESS="$loc.UTF-8"
	#export LC_TELEPHONE="$loc.UTF-8"
	export LC_MEASUREMENT="$loc.UTF-8"
	#export LC_IDENTIFICATION="$loc.UTF-8"
	#export LC_ALL=nb_NO.UTF-8
fi

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
