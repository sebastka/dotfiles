#!/bin/sh
# Profile file. Runs on login

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="${LANG}"

# If $loc is not null AND if it is loaded:
readonly loc="MYLOC"
if [[ ! -z "${loc}" ]] && [[ ! -z $(locale -a 2>/dev/null | grep "$loc") ]]; then
	export LC_ALL="$loc.UTF-8"
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
fi

# Env
[ -z "${HOSTNAME}" ] && export HOSTNAME="$(hostname)"
[ -z "$HOST" ] && export HOST="$HOSTNAME"

export TERM=xterm-256color
export CLICOLOR=1

# Custom scripts
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"

# Ruby GEM
[ -x "$(command -v ruby)" ] && \
	export GEM_HOME="$(ruby -e 'puts Gem.user_dir')" && \
	export PATH="$PATH:$GEM_HOME/bin"

# Software
export EDITOR='vim'
export TERMINAL='alacritty'

# Load shell config rc
[ -f "$HOME/.MYSHELLrc" ] && . "$HOME/.MYSHELLrc"
