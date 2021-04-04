#!/bin/bash
#  _               _
# | |             | |
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History file - infinite
HISTSIZE=HISTFILESIZE=

#
#	Set prompt
#

# Basic prompt as default
PS1='[\u@\h \W]\$ '

# If available, load polyglot:
[[ -f ~/.polyglot.sh ]] && source ~/.polyglot.sh

#
#	Env
#

if locale -a | grep ^nb_NO.utf8 &>/dev/null; then
	export LC_ALL="nb_NO.UTF-8"
fi
export LC_TIME="${LANG}"
export LC_CTYPE="${LANG}"

# MAKEFLAGS
[[ -x "$(command -v nproc)" ]] && export MAKEFLAGS="-j`nproc`"

#
#	Aliases
#

# Load uutils as aliases
gen_uutils && source ~/.uutils_aliases && rm ~/.uutils_aliases

alias make="make ${MAKEFLAGS}"
alias ls='ls -h --color=auto'
alias l='ls -alN --group-directories-first'
alias ss='sudo systemctl'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias vim='vim -p'

#
#       kdesrc-build
#

if [[ -d ~/kde/src/ ]]; then
	# Add kdesrc-build to PATH
	export PATH="${PATH}:${HOME}/kde/src/kdesrc-build"

	# Run projects built with kdesrc-build
	kdesrc-run () {
		source "${HOME}/kde/build/${1}/prefix.sh" && "${HOME}/kde/usr/bin/${1##*/}" "${@:2:$#}"
	}
fi
