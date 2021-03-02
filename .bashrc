# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="nb_NO.UTF-8"
export LC_TIME=$LANG
export LC_CTYPE=$LANG

#
#	Load ohmybash
#

if [ -d /usr/share/oh-my-bash/ ]; then
	. /usr/share/oh-my-bash/bashrc
elif [ -d ~/.oh-my-bash/ ]; then
	. ~/.oh-my-bash/templates/bashrc.osh-template
else
	git clone --depth=1 https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash
	. ~/.oh-my-bash/templates/bashrc.osh-template
fi

#
#	Env vars
#

export EDITOR='nano'
export ARCHFLAGS="-arch x86_64"
export MAKEFLAGS="-j12"

#
#	Aliases
#

alias pmake='make $(MAKEFLAGS)'

if [ -x "$(command -v mtr)" ]; then alias traceroute='mtr'; fi

#
#	kdesrc-build
#

## Add kdesrc-build to PATH
export PATH="$HOME/kde/src/kdesrc-build:$PATH"

## Run projects built with kdesrc-build
kdesrc-run () {
	source "$HOME/kde/build/$1/prefix.sh" && "$HOME/kde/usr/bin/${1##*/}" "${@:2:$#}"
}

#
#	Functions
#

if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

if [ -x "$(command -v neofetch)" ]; then
	neofetch --color_blocks off --disable cpu gpu memory
fi